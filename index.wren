import "bialet" for Response
import "_app/layout" for Layout
import "_app/domain" for Usuario, Dominio

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var html = Layout.render("Dominios", '
  <h2>Solo quedan %( Dominio.quedan ) dominios gratis</h2>
  <div>
    <a class="btn" href="/crear-usuario">Registrar dominio</a>
    <a class="btn alt" href="/iniciar-sesion">Iniciar sesión</a>
  </div>
')
Response.out(html)
