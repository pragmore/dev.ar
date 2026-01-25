import "/_app/layout" for Layout
import "/_app/domain" for Dominio, Usuario
import "/_app/cloudflare" for Cloudflare

// Set plain text response
Response.header("Content-Type", "text/plain")

// Verificar que se proporcione la clave de administrador
var adminKey = Request.header("admin-key")
var expectedKey = Config.get("ADMIN_KEY")

if (!adminKey || adminKey != expectedKey) {
  System.log("Abuse intentado sin clave de administrador o con clave incorrecta")
  return "ok"
}

// Obtener el FQDN del parámetro
var fqdn = Request.post("fqdn")
if (!fqdn) {
  System.log("Abuse intentado sin FQDN por administrador")
  return "ok"
}

// Normalizar el FQDN
fqdn = Dominio.normalizarDominio(fqdn)

// Buscar el dominio
var dominio = Dominio.findByFqdn(fqdn)
if (!dominio) {
  System.log("Abuse intentado en dominio %( fqdn ) no existente por administrador")
  return "dominio don't exists"
}

var resultado = []

dominio["redirect"] = ""

// 2. Actualizar DNS en Cloudflare
if (dominio["dns"] && dominio["dns"].count > 1) {
    dominio["dns"] = "home.dev.ar"
    Cloudflare.actualizarDns(dominio)
    System.log("DNS del dominio %( fqdn ) actualizado a 'home.dev.ar' por administrador")
}
Dominio.guardar(dominio)

// 3. Cambiar la contraseña del usuario
var usuario = `SELECT * FROM usuarios WHERE id = ?`.first(dominio["usuario"])
if (usuario) {
  usuario["password"] = "1"
  Db.save("usuarios", usuario)
  System.log("Contraseña del usuario %( usuario["email"] ) cambiada a '1' por administrador")
}

System.log("Abuse realizado en dominio %( fqdn ) por administrador")

return "ok"