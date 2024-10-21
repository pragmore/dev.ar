import "bialet" for Response, Request
import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario
import "_app/cloudflare" for Cloudflare

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
    dominio["redirect"] = Request.post("redirect")
    System.print("Cambiar redirect de %( dominio["fqdn"] ) a %( dominio["redirect"] )")
    if (Dominio.guardar(dominio)) {
      mensaje = '<p class="alert alert-success" role="alert">Redireccion cambiada ✅</p>'
    }
  }
  if (Request.post("dns")) {
    dominio["dns"] = Dominio.normalizarDns(Request.post("dns"))
    System.print("Cambiar DNS de %( dominio["fqdn"] ) a %( dominio["dns"] )")
    if (dominio["dns"].count > 0 && Dominio.guardar(dominio)) {
      if (Cloudflare.actualizarDns(dominio)) {
        mensaje = <div>
          <p class="alert alert-success" role="alert">DNS cambiado ✅</p>
          <p class="alert alert-info" role="alert">📢 Recordá que <strong>los cambios pueden tardar hasta 48 horas</strong> en impactar.</p>
        </div>
      } else {
        mensaje = <div>
          <p class="alert alert-danger" role="alert">Error al actualizar el DNS ❌</p>
          <p>Se guardó el DNS en nuestra base de datos, pero falló la actualización de Cloudflare. Por favor, intenta de nuevo en unos minutos. En caso de volver a fallar, <a href="mailto:albo@pragmore.com?subject=Fallo+DNS+{{ dominio["fqdn"] }}">mandanos un correo</a>.</p>
        </div>
      }
    }
  }
}

// WTF!? Porque esta vacio pero con count 1?
if (dominio["redireccion"].count == 1) {
  dominio["redireccion"] = ""
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
        <h2 class="text-center fs-1 alert alert-warning">⚠️ Leer atentamente!</h2>
        <ul class="fs-3">
          <li>No hay que usar servidores NS para configurar</li>
          <li>Podés tener configurado la redireccion y el DNS de un espacio, siempre va a tener prioridad el DNS, en caso de no estar correctamente configurado se tomará la redirección</li>
          <li>Los cambios de DNS pueden tardar hasta 48 horas</li>
          <li>Si pones una IP en DNS se creará un registro del tipo <code>A</code></li>
          <li>Si pones un dominio en DNS se creará un registro del tipo <code>CNAME</code></li>
          <li>Para <strong>GitHub</strong> tenés que poner tu usuario en el DNS (ej: <code>roberto.github.io</code>), configurarlo desde Pages y asegurarte que exista el archivo <code>CNAME</code> en tu repositorio con el dominio. Lee atentamente la <a href="https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/about-custom-domains-and-github-pages" target="_blank">documentación de GitHub</a>.</li>
          <li><strong>Los proveedores que piden una verifición de un registro <code>TXT</code> no estan disponibles por el momento (entre ellos Vercel y Google)</strong></li>
        </ul>
        <p>Si necesitas ayuda enviame un correo a <a href="mailto:albo@pragmore.com">albo@pragmore.com</a></p>
      </div>
    </div>
  </div>
</section> )
Response.out(html)
