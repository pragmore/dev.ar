import "/_app/layout" for Layout
import "/_app/domain" for Dominio, Usuario
import "/_app/cloudflare" for Cloudflare

// Set plain text response
Response.header("Content-Type", "text/plain")

// Verificar que se proporcione la clave de administrador
var adminKey = Request.header("admin-key")
var expectedKey = Config.get("ADMIN_KEY")

if (!adminKey || adminKey != expectedKey) {
  System.log("Reset intentado sin clave de administrador o con clave incorrecta")
  return "ok"
}

// Obtener el email del parámetro
var email = Request.post("email")
if (!email) {
  System.log("Reset intentado sin email por administrador")
  return "ok"
}

// Buscar el usuario
var usuario = `SELECT * FROM usuarios WHERE email = ?`.first(email)
if (!usuario) {
  System.log("Reset intentado en usuario %( email ) no existente por administrador")
  return "usuario don't exists"
}

// Cambiar la contraseña del usuario a vacía
usuario["password"] = ""
Db.save("usuarios", usuario)
System.log("Contraseña del usuario %( email ) reseteada por administrador")

return "ok"
