import "bialet" for Response, Request, Session, Db
import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario

var idUsuario = Session.new().get("usuario")
System.print("Usuario %(idUsuario)")

if (!idUsuario) {
  return Response.redirect("/")
}

var dominios = Dominio.findByUsuario(idUsuario)
var dominio = dominios[0]

var guardado
if (Request.isPost()) {
  dominio["redirect"] = Request.post("redirect")
  System.print("Cambiar redirect de %( dominio["fqdn"] ) a %( dominio["redirect"] )")
  guardado = Db.save("dominios", dominio)
}

var html = Layout.render("dev.ar", "
  <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
  <p>
    <a href='/cerrar-sesion'>Cerrar sesión</a>
  </p>
  <p>
  Tu dominio es: <strong>%( dominio["fqdn"] )</strong>
  </p>
  %( guardado ? "<p class='msg ok'>Redireccion cambiada</p>" : "" )
  <p>
    Redirecciona a:
    <form method='post'>
      <input name='redirect' value='%( dominio["redirect"] ?dominio["redirect"] : "" )' placeholder='https://example.com' />
      <p><button class='btn'>Cambiar adonde redirecciona</button></p>
    </form>
  </p>
")
Response.out(html)

