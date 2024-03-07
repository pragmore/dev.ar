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
  dominio["redirect"] = Request.post("redirect")
  System.print("Cambiar redirect de %( dominio["fqdn"] ) a %( dominio["redirect"] )")
  if (Dominio.guardar(dominio)) {
    mensajeGuardado = '<p class="alert alert-success" role="alert">Redireccion cambiada</p>'
  }
}

var html = Layout.render("Dashboard", '
<section class="features-icons bg-light">
  <div class="container-fluid justify-content-center">
    <div class="row px-4">
      <div class="col-xl-6 offset-xl-2">
        <p class="alert alert-info" role="alert">ℹ️ Próximamente habrá mas opciones de hosting<p>
      </div>
    </div>
    <div class="row px-4 mt-4">
      <div class="col-xl-6 offset-xl-2">
          <div class="container-fluid">
            <div class="row">
              <h1>
                Tu dominio es: <strong class="text-secondary">%( dominio["fqdn"] )</strong>
              </h1>
            </div>
            <div class="row mt-4">
              <form method="post" action="/hosting">
                <h2>Hosting</h2>
                <div class="form-floating mb-3">
                  <select name="hosting" class="form-select" id="hosting">
                    <option value="">Ninguno</option>
                    <option value="github" %( dominio["hosting"] == "github" ? "selected" :"" )>GitHub</option>
                  </select>
                  <label for="hosting">Hosting</label>
                </div>
                <button class="btn btn-primary">Cambiar hosting</button>
              </form>
            </div>
            <div class="row mt-4">
              <form method="post">
                <h2>Redirección</h2>
                %( mensajeGuardado )
                <div class="form-floating mb-3">
                  <input type="text" name="redirect" class="form-control" id="redirect" value="%( dominio["redirect"] ?dominio["redirect"] : "" )" placeholder="https://ejemplo.com">
                  <label for="redirect">URL donde redirecciona tu dominio</label>
                </div>
                <button class="btn btn-primary">Cambiar redirección</button>
              </form>
            </div>
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
