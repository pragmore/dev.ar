import "/_app/layout" for Layout
import "/_app/domain" for Dominio, Usuario
import "/_app/cloudflare" for Cloudflare

// Set plain text response
Response.header("Content-Type", "text/plain")

// Verificar que se proporcione la clave de administrador
var adminKey = Request.header("admin-key")
var expectedKey = Config.get("ADMIN_KEY")

if (!adminKey || adminKey != expectedKey) {
  System.log("TXT intentado sin clave de administrador o con clave incorrecta")
  return "ok"
}

// Obtener parámetros
var fqdn = Request.post("fqdn")
var name = Request.post("name")       // ej: _vercel
var content = Request.post("content") // ej: vc-domain-verify=belenjesus.dev.ar,89674ed4e0eec7174c97

if (!fqdn || !name || !content) {
  System.log("TXT intentado sin parámetros completos por administrador")
  return "faltan parametros: fqdn, name, content"
}

// Normalizar el FQDN
fqdn = Dominio.normalizarDominio(fqdn)

// Buscar el dominio
var dominio = Dominio.findByFqdn(fqdn)
if (!dominio) {
  System.log("TXT intentado en dominio %( fqdn ) no existente por administrador")
  return "dominio don't exists"
}

// Crear el registro TXT en Cloudflare
var response = Cloudflare.createTxtRecord(dominio, name, content)

if (response["success"]) {
  System.log("Registro TXT creado para %( fqdn ): %( name ) = %( content )")
  return "ok"
} else {
  System.log("Error creando TXT para %( fqdn ): %( response )")
  return "error: %( response["errors"] )"
}
