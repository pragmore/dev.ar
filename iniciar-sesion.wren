import "bialet" for Response, Request, Session
import "_app/layout" for Layout
import "_app/domain" for Usuario

var error = false
var messages = {}
var referrer = Request.get("ref")

if (Request.isPost()) {
  var email = Request.post("email")
  var password = Request.post("password")
  var idUsuario = Usuario.iniciar(email, password)
  if (idUsuario) {
    // TODO Session
    Session.new().set("usuario", idUsuario)
    return Response.redirect("/dashboard")
  } else {
    error = true
  }
}

var html = Layout.render("Iniciar sesión", "
  <form method='post'>
    %( error ? "<p class='msg err'>El correo o la contraseña son incorrectos</p>" : "" )

    <p><label for='email'>Correo electrónico</label></p>
    <p>
      <input
        type='email'
        name='email'
        id='email'
        placeholder='email@ejemplo.com'
        required
      />
    </p>

    <p><label for='password'>Contraseña</label></p>
    <p>
      <input
        type='password'
        name='password'
        id='password'
        required
      />
    </p>

    <p><button class='btn main'>Iniciar sesión</button></p>

    <p>No tengo un usuario, <a href='/crear-usuario'>crear uno nuevo</a></p>
  </form>
")
Response.out(html)
