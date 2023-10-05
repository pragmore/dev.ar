import "bialet" for Response
import "_app/layout" for Layout

var html = Layout.render("dev.ar", "
  <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
  <div class='text-lg text-center'>
    <p>
      ¿Queres tener tu dominio <strong>.dev.ar</strong> gratis?
    </p>
    <p>
      <a class='btn main' href='/crear-usuario'>Sumate a la beta 🎉</a>
    </p>
    <p>
      <a href='/iniciar-sesion'>Iniciar sesión</a>
    </p>
  </div>
  <script src='https://unpkg.com/typewriter-effect@2.3.1/dist/core.js'></script>
  <script src='js/index.js'></script>
")
Response.out(html)
