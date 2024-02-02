import "bialet" for Response
import "_app/layout" for Layout
import "_app/domain" for Usuario

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Dominios gratis", '
  <div>
      <a class="btn" href="/crear-usuario">Sumate a la beta</a>
      <a class="btn alt" href="/iniciar-sesion">Iniciar sesión</a>
  </div>
')
Response.out(html)
