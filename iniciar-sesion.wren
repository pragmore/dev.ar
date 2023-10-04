import "bialet" for Response, Request
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
    return Response.redirect("/dashboard")
  } else {
    error = true
  }
}

var html = Layout.render("Iniciar sesión en dev.ar", "
  <h1>👩‍💻 Iniciar sesión en <em>dev.ar</em></h1>
  <form method='post'>
    %( error ? "<p className='msg err'>El correo o la contraseña son incorrectos</p>" : "" )

    <p><label htmlFor='email'>Correo electrónico</label></p>
    <p>
      <input
        type='email'
        name='email'
        id='email'
        placeholder='email@ejemplo.com'
        required
      />
    </p>

    <p><label htmlFor='password'>Contraseña</label></p>
    <p>
      <input
        type='password'
        name='password'
        id='password'
        required
      />
    </p>

    <p><button className='btn main'>Registrar cuenta y dominio</button></p>

    <p>No tengo un usuario, <a href='/crear-usuario'>crear uno nuevo</a></p>
  </form>
")
Response.out(html)
