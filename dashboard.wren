import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario
import "_app/cloudflare" for Cloudflare
import "_app/validator" for Validator

if (!Usuario.estaLogueado) {
  return Response.redirect("/")
}

var dominios = Dominio.delUsuarioLogueado
if (!dominios || dominios.count <= 0) {
  Usuario.cerrarSesion
  return Response.redirect("/")
}
var dominio = dominios[0]

var mensaje
if (Request.isPost) {
  if (Request.post("redirect")) {
    var nuevoRedirect = Request.post("redirect").trim()
    // Solo validar conflicto si se está configurando un valor (no al eliminar)
    if (nuevoRedirect.count > 0 && dominio["dns"] && dominio["dns"].count > 1) {
      mensaje = <div>
        <p class="alert alert-danger" role="alert">❌ No se puede configurar la redirección</p>
        <p class="alert alert-warning">Ya tenés configurado el DNS (<code>{{ dominio["dns"] }}</code>). <strong>Solo podés tener una configuración activa a la vez.</strong><br><br>
        Si querés usar redirección, primero eliminá el DNS dejando el campo vacío y guardando.</p>
      </div>
    } else {
      dominio["redirect"] = nuevoRedirect
      System.print("Cambiar redirect de %( dominio["fqdn"] ) a %( dominio["redirect"] )")
      if (Dominio.guardar(dominio)) {
        if (nuevoRedirect.count > 0) {
          mensaje = '<p class="alert alert-success" role="alert">Redireccion cambiada ✅</p>'
        } else {
          mensaje = '<p class="alert alert-success" role="alert">Redireccion eliminada ✅</p>'
        }
      }
    }
  }
  if (Request.post("dns")) {
    var dnsNormalizado = Dominio.normalizarDns(Request.post("dns").trim())
    
    // Solo validar conflicto si se está configurando un valor (no al eliminar)
    if (dnsNormalizado.count > 0 && dominio["redirect"] && dominio["redirect"].count > 1) {
      mensaje = <div>
        <p class="alert alert-danger" role="alert">❌ No se puede configurar el DNS</p>
        <p class="alert alert-warning">Ya tenés configurada una redirección (<code>{{ dominio["redirect"] }}</code>). <strong>Solo podés tener una configuración activa a la vez.</strong><br><br>
        Si querés usar DNS, primero eliminá la redirección dejando el campo vacío y guardando.</p>
      </div>
    } else if (dnsNormalizado.count > 0 && !Validator.dnsValido(dnsNormalizado)) {
      var errorMsg = "El valor ingresado no es válido. "
      if (dnsNormalizado.contains("http") || dnsNormalizado.contains("/")) {
        errorMsg = errorMsg + "⚠️ <strong>No debes incluir 'http://', 'https://' ni barras ('/').</strong> "
      }
      mensaje = <div>
        <p class="alert alert-danger" role="alert">❌ DNS inválido</p>
        <p class="alert alert-warning">{{ errorMsg }}<br><br>
        <strong>Ejemplos válidos:</strong><br>
        • Para una IP: <code>192.168.1.1</code><br>
        • Para un dominio: <code>usuario.github.io</code> o <code>ejemplo.com</code><br><br>
        <strong>❌ NO válido:</strong> <code>https://usuario.github.io</code> o <code>usuario.github.io/proyecto</code>
        </p>
      </div>
    } else {
      dominio["dns"] = dnsNormalizado
      System.print("Cambiar DNS de %( dominio["fqdn"] ) a %( dominio["dns"] )")
      if (Dominio.guardar(dominio)) {
        if (dnsNormalizado.count > 0 && Cloudflare.actualizarDns(dominio)) {
          var tipoRegistro = Validator.esIp(dnsNormalizado) ? "A" : "CNAME"
          mensaje = <div>
            <p class="alert alert-success" role="alert">DNS cambiado ✅ (Registro tipo <strong>{{ tipoRegistro }}</strong>)</p>
            <p class="alert alert-info" role="alert">📢 Recordá que <strong>los cambios pueden tardar hasta 48 horas</strong> en impactar.</p>
          </div>
        } else if (dnsNormalizado.count == 0) {
          mensaje = '<p class="alert alert-success" role="alert">DNS eliminado ✅</p>'
        } else {
          mensaje = <div>
            <p class="alert alert-danger" role="alert">Error al actualizar el DNS ❌</p>
            <p>Se guardó el DNS en nuestra base de datos, pero falló la actualización de Cloudflare. Por favor, intenta de nuevo en unos minutos. En caso de volver a fallar, <a href="mailto:albo@pragmore.com?subject=Fallo+DNS+{{ dominio["fqdn"] }}">mandanos un correo</a>.</p>
          </div>
        }
      }
    }
  }
}

// WTF!? Porque esta vacio pero con count 1?
if (dominio["redirect"].count == 1) {
  dominio["redirect"] = ""
}
if (dominio["dns"].count == 1) {
  dominio["dns"] = ""
}

var html = Layout.render("Dashboard",
<section>
  <div class="container-fluid justify-content-center px-4 mt-4">
    {{ mensaje && <aside class="row px-4">
      <div class="col-xl-6 offset-xl-2">
        {{ mensaje }}
      </div>
    </aside> }}
    <div class="row">
      <div class="col-xl-6 offset-xl-2">
          <div class="container-fluid">
            <div class="row">
              <h1>
                Tu espacio es: <strong class="text-secondary">{{ dominio["fqdn"] }}</strong>
              </h1>
            </div>
            <div class="row mt-4">
              <form method="post">
                <h2>Redirección</h2>
                <div class="form-floating mb-3">
                  <input type="text" name="redirect" class="form-control" id="redirect" value="{{ dominio["redirect"] && dominio["redirect"] }}" placeholder="https://ejemplo.com">
                  <label for="redirect">URL donde se redirecciona tu espacio</label>
                </div>
                <button class="btn btn-primary">Cambiar redirección</button>
              </form>
            </div>
            <div class="row mt-4">
              <form method="post">
                <h2>DNS</h2>
                <div class="form-floating mb-3">
                  <input type="text" name="dns" class="form-control" id="dns" value="{{ dominio["dns"] }}" placeholder="tu-usuario.github.io">
                  <label for="dns">Dominio o IP donde {{ dominio["fqdn"] }} esta alojado</label>
                </div>
                <button class="btn btn-primary">Actualizar DNS</button>
              </form>
            </div>
            <div class="row mt-4 fs-4">
              <a href="https://www.youtube.com/watch?v=ay9ZHj2Kjcg" target="_blank">Tutorial paso a paso para configurar GitHub</a>
            </div>
          </div>
      </div>
    </div>
    <div class="row px-4 mt-4">
      <div class="col-xl-6 offset-xl-2">
        <h2 class="text-center fs-1 alert alert-warning">⚠️ Leer atentamente antes de configurar!</h2>
        
        <div class="alert alert-danger fs-4 mb-4">
          <h3>🚫 Reglas importantes:</h3>
          <ul>
            <li><strong>⚡ Solo podés tener UNA configuración activa:</strong> Redirección <strong>O</strong> DNS, no ambas al mismo tiempo</li>
          </ul>
          <h4 class="mt-3">Para el campo DNS específicamente:</h4>
          <ul>
            <li><strong>NO incluyas <code>http://</code> o <code>https://</code></strong> en el DNS</li>
            <li><strong>NO incluyas barras <code>/</code> ni rutas</strong> (como <code>/proyecto</code>) en el DNS</li>
            <li><strong>NO confundas URL con dominio en el DNS:</strong>
              <ul>
                <li>❌ Incorrecto en DNS: <code>https://usuario.github.io</code></li>
                <li>✅ Correcto en DNS: <code>usuario.github.io</code></li>
              </ul>
            </li>
          </ul>
          <p class="mb-0"><em>Nota: En el campo de Redirección SÍ debés poner la URL completa con <code>https://</code></em></p>
        </div>
        
        <div class="alert alert-success fs-4 mb-4">
          <h3>✅ ¿Qué poner en el campo DNS?</h3>
          <p><strong>Solo hay 2 opciones válidas:</strong></p>
          <ol>
            <li><strong>Una dirección IP</strong> (se creará un registro tipo <code>A</code>):
              <ul><li>Ejemplo: <code>192.168.1.1</code></li></ul>
            </li>
            <li><strong>Un dominio sin protocolos</strong> (se creará un registro tipo <code>CNAME</code>):
              <ul>
                <li>Ejemplo para GitHub: <code>usuario.github.io</code></li>
                <li>Ejemplo genérico: <code>ejemplo.com</code></li>
              </ul>
            </li>
          </ol>
        </div>
        
        <h3>� ¿Querés entender mejor cómo funciona?</h3>
        <div class="alert alert-info fs-5 mb-4">
          <ul>
            <li><strong>¿Qué es una redirección?</strong> <a href="https://es.wikipedia.org/wiki/Redirecci%C3%B3n_de_URL" target="_blank">Ver en Wikipedia</a> - Envía automáticamente a los visitantes a otra URL</li>
            <li><strong>¿Cómo funciona el DNS?</strong> <a href="https://es.wikipedia.org/wiki/Sistema_de_nombres_de_dominio" target="_blank">Ver en Wikipedia</a> - Sistema que traduce nombres de dominio a direcciones IP</li>
            <li><strong>Subdominios y DNS:</strong> <a href="https://www.cloudflare.com/es-es/learning/dns/glossary/what-is-a-subdomain/" target="_blank">Guía de Cloudflare</a> - Explica cómo funcionan los subdominios</li>
            <li><strong>Registros DNS (A y CNAME):</strong> <a href="https://www.cloudflare.com/es-es/learning/dns/dns-records/" target="_blank">Guía de Cloudflare</a></li>
          </ul>
        </div>
        
        <h3>📋 Información adicional:</h3>
        <ul class="fs-4">
          <li><strong>⚠️ Solo podés usar redirección O DNS, no ambos.</strong> Para cambiar de uno a otro, primero eliminá el actual dejando el campo vacío</li>
          <li>No hay que usar servidores NS para configurar</li>
          <li>Los cambios de DNS pueden tardar hasta 48 horas en propagarse</li>
          <li>Para <strong>GitHub Pages</strong>: Ingresá <code>tu-usuario.github.io</code> en DNS (sin <code>https://</code>), configuralo desde Pages y asegurate que exista el archivo <code>CNAME</code> en tu repositorio. <a href="https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages" target="_blank">Ver documentación de GitHub</a>.</li>
          <li><strong>Para verificación TXT</strong> (Vercel, Google, etc.): Enviame un correo a <a href="mailto:albo@pragmore.com?subject=Registro+TXT+de+dev.ar">albo@pragmore.com</a> con los datos <code>(TYPE, NAME, CONTENT)</code></li>
        </ul>
        <p class="fs-4">Si necesitas ayuda, enviame un correo a <a href="mailto:albo@pragmore.com">albo@pragmore.com</a></p>
      </div>
    </div>
  </div>
</section> )
Response.out(html)
