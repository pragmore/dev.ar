import "bialet" for Response, Request
import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario

if (!Usuario.estaLogueado) {
  return Response.redirect("/")
}

var dominios = Dominio.delUsuarioLogueado
var dominio = dominios[0]

var mensajeGuardado
if (Request.isPost()) {
  dominio["redirect"] = Request.post("redirect")
  System.print("Cambiar redirect de %( dominio["fqdn"] ) a %( dominio["redirect"] )")
  if (Dominio.guardar(dominio)) {
    mensajeGuardado = '<p class="msg ok">Redireccion cambiada</p>'
  }
}

var html = Layout.render("Dashboard", '
  <form method="post">
    <p>
    Tu dominio es: <strong>%( dominio["fqdn"] )</strong>
    </p>
    %( mensajeGuardado )
    <p>
      <label for="redirect">Redirecciona a:</label>
      <input name="redirect" value="%( dominio["redirect"] ?dominio["redirect"] : "" )" placeholder="https://example.com" />
    </p>
    <p><button class="btn">Cambiar adonde redirecciona</button></p>
  </form>
')
Response.out(html)
