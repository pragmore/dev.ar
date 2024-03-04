import "bialet" for Response, Request
import "_app/layout" for Layout
import "_app/domain" for Dominio, Usuario
import "_app/validator" for Validator

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var error = false
var messages = {}
var referrer = Request.get("ref")

if (Request.isPost()) {
  var email = Request.post("email")
  var password = Request.post("password")
  var domain = Dominio.normalizarDominio(Request.post("domain"))
  var referrer = Request.post("referrer")
  if (!Validator.email(email)) {
    error = true
    messages["email"] = "Correo electrónico no válido"
  } else if (Usuario.findByEmail(email)) {
    error = true
    messages["email"] = "El correo electrónico ya está registrado"
  }
  if (!Validator.domain(domain)) {
    error = true
    messages["domain"] = "Dominio no válido"
  } else if (Dominio.findByFqdn(domain)) {
    error = true
    messages["domain"] = "El dominio ya está registrado"
  }
  if (!error) {
    Usuario.guardar(email, password, domain, referrer)
    return Response.redirect("/dashboard")
  }
}

var html = Layout.render("Crear usuario y dominio", "
  <form method='post'>
    <input type='hidden' name='ref' id='ref' value='%( referrer )' />

    %( error ? "<p class='msg err'>%( messages )</p>" : "" )

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

    <p>
      <label for='fqdn'>Dominio</label>
      Debe tener por lo menos 6 letras, números o guión medio y tiene que empezar con una letra.
    </p>
    <p>
      <input
        name='domain'
        id='domain'
        placeholder='dominio.dev.ar'
        pattern='^[a-z0-9-]{6,}\\.dev\\.ar$'
        required
      />
    </p>

    <p>
      <label>
        <input type='checkbox' name='terms' required />
        <span>Acepto los <a href='/terminos-y-condiciones' target='_blank'>términos y condiciones</a></span>
      </label>
    </p>

    <p><button class='btn main'>Registrar cuenta y dominio</button></p>

    <p>Ya tengo un usuario, <a href='/iniciar-sesion'>iniciar sesión</a></p>
  </form>
")
Response.out(html)
