import "bialet" for Response
import "_app/layout" for Layout

var html = Layout.render("dev.ar", "
  <h1>👩‍💻 <em>loquequieras</em>.dev.ar</h1>
  <p class='text-lg' id='text'>
  ¿Queres tener tu dominio <strong>.dev.ar</strong> gratis?
  </p>
  <p class='text-lg'>
    <a class='btn main' href='/crear-usuario'>Sumate a la beta 🎉</a>
  </p>
  <p class='text-lg'>
    <a class='btn' href='/iniciar-sesion'>Iniciar sesión</a>
  </p>
  <p class='text-lg'>
  <script src='https://unpkg.com/typewriter-effect@2.3.1/dist/core.js'></script>
  <script src='js/index.js'></script>
")
Response.out(html)
