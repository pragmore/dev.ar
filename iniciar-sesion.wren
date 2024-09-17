import "bialet" for Response, Request, Session
import "_app/layout" for Layout
import "_app/domain" for Usuario

var error = false
var messages = {}
var referrer = Request.get("ref")

if (Request.isPost) {
  var email = Request.post("email")
  var password = Request.post("password")
  if (Usuario.iniciar(email, password)) {
    return Response.redirect("/dashboard")
  } else {
    error = true
  }
}

var html = Layout.render("Iniciar sesión",
<section class="container" id="signup">
  <div class="row justify-content-center mt-4">
    <div class="col-xl-6">
      <h2 class="mb-4">Iniciar sesión</h2>
      <form method="post">
        {{ error && <p class="alert alert-danger">El correo o la contraseña son incorrectos</p> }}
        <div class="form-floating mb-3">
          <input type="email" name="email" class="form-control" id="floatingInput" placeholder="nombre@ejemplo.com">
          <label for="floatingInput">Correo electrónico</label>
        </div>
        <div class="form-floating mb-3">
          <input type="password" class="form-control" name="password" id="password" placeholder="Contraseña">
          <label for="password">Contraseña</label>
        </div>
        <button type="submit" class="btn btn-primary">Iniciar sesión</button>
      </form>
      <p class="mt-5 text-center alert alert-info" role="alert">Si te olvidaste la contraseña envianos un correo a albo arroba pragmore.com</p>
    </div>
  </div>
</section>
)
Response.out(html)
