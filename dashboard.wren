import "bialet" for Response
import "_app/layout" for Layout

var html = Layout.render("dev.ar", "
  <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
  <p>
    <a href='/cerrar-sesion'>Cerrar sesión</a>
  </p>
  <p>
  Dominio
  </p>
")
Response.out(html)

