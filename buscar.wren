import "bialet" for Request, Response
import "_app/layout" for Layout
import "_app/domain" for Usuario, Dominio
import "_app/validator" for Validator

if (Usuario.estaLogueado) {
  return Response.redirect("/dashboard")
}

var q = Dominio.normalizarDominio(Request.get("q"))
var encontrado = Dominio.findByFqdn(q)
var valido = Dominio.valido(q)

var error = false
var messages = {}
var referrer = Request.get("ref")

if (!encontrado && valido && Request.isPost()) {
  var email = Request.post("email")
  var password = Request.post("password")
  var domain = q
  var referrer = Request.get("ref")
  if (!Validator.email(email)) {
    error = true
    messages["email"] = "Correo electrónico no válido"
  } else if (Usuario.findByEmail(email)) {
    error = true
    messages["email"] = "El correo electrónico ya está registrado"
  }
  if (!error) {
    Usuario.guardar(email, password, domain, referrer)
    return Response.redirect("/dashboard")
  }
}

System.print(valido)

var html = Layout.render("Buscar dominio %(q)", '

  %( Layout.headerBuscar(q) )

  %( encontrado || !valido ? '
<section class="features-icons bg-light text-center">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-xl-6">
        <h2 class="alert alert-warning text-center" role="alert">El dominio se encuentra registrado 😞</h2>
      </div>
    </div>
  </div>
</section>
  ' : '
<section class="features-icons bg-light">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-xl-6">
        %( error ?
          '<p class="alert alert-error">%(messages)</p>':
          '<h2 class="alert alert-success text-center" role="alert">¡El dominio esta disponible! 🥳</h2>'
        )
      </div>
    </div>
    <div class="row justify-content-center mt-4">
      <div class="col-xl-6">
        <form method="POST">
          <div class="mb-3">
            <h1>
              Registrar <strong class="text-secondary">%(q)</strong>
            </h1>
          </div>
          <div class="form-floating mb-3">
            <input type="email" class="form-control" id="email" placeholder="nombre@ejemplo.com">
            <label for="email">Correo electrónico</label>
          </div>
          <div class="form-floating mb-3">
            <input type="password" class="form-control" id="password" placeholder="Contraseña">
            <label for="password">Contraseña</label>
          </div>
          <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
            <label class="form-check-label" for="flexCheckDefault">
              Acepto los <a href="/terminos-y-condiciones" target="_blank">términos y condiciones</a>
            </label>
          </div>
          <button type="submit" class="btn btn-primary">Crear cuenta</button>
        </form>
    </div>
  </div>
</section>
')
')
Response.out(html)
