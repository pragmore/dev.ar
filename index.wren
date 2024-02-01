import "bialet" for Response, Session
import "_app/layout" for Layout

if (Session.new().get("usuario")) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Dominios gratis", '
  <div>
      <a class="nb-button orange" href="/crear-usuario">Sumate a la beta</a>
      <a class="nb-button blue" href="/iniciar-sesion">Iniciar sesión</a>
  </div>
')
Response.out(html)
