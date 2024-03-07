import "bialet" for Response, Request
import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario

if (!Usuario.estaLogueado) {
  return Response.redirect("/")
}

var dominios = Dominio.delUsuarioLogueado
if (!dominios || dominios.count <= 0) {
  Usuario.cerrarSesion
  return Response.redirect("/")
}
var dominio = dominios[0]

var mensajeGuardado
if (Request.isPost) {
  dominio["hosting"] = Request.post("hosting")
  if (dominio["hosting"] == "github") {
    var cname = Request.post("cname")
    `INSERT OR REPLACE INTO hosting (, key, value) VALUES ("%(dominio["fqdn"])", "%(cname)")`
  }
  System.print("Cambiar hosting de %( dominio["fqdn"] ) a %( dominio["hosting"] )")
  if (Dominio.guardar(dominio)) {
    mensajeGuardado = '<p class="alert alert-success" role="alert">Hosting actualizado</p>'
  }
}

  var hosting
if (!dominio["hosting"]) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Configuracion Hosting", '
<section class="features-icons bg-light">
  <div class="container-fluid justify-content-center">
    <div class="row px-4 mt-4">
      <div class="col-xl-6 offset-xl-2">
          <div class="container-fluid">
            <div class="row">
              <h1>
                Tu dominio <strong class="text-secondary">%( dominio["fqdn"] )</strong>
                esta apuntando a <strong class="text-secondary">%( dominio["hosting"] )</strong>
              </h1>
            </div>
            %( dominio["hosting"] == "github" ? '
              <div class="row mt-4">
                <form method="post">
                  <h2>Configuración de GitHub</h2>
                  %( mensajeGuardado )
                  <div class="form-floating mb-3">
                    <input type="text" name="cname" class="form-control" id="cname" value="%( hosting["value"] ?hosting["value"] : "" )" placeholder="ejemplo.github.io">
                    <label for="redirect">URL con el nombre del repositorio (ejemplo.github.io)</label>
                  </div>
                  <button class="btn btn-primary">Actualizar configuración</button>
                </form>
              </div>
            ' : "" )
          </div>
      </div>
    </div>
    <div class="row px-4 mt-4">
      <div class="col-xl-6 offset-xl-2">
        <p>Si necesitas ayuda enviame un correo a <a href="mailto:albo@pragmore.com">albo@pragmore.com</a></p>
      </div>
    </div>
  </div>
</section>
')
Response.out(html)
