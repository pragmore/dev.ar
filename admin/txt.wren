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
System.print("fqdn normalizado: %(fqdn)")

// Buscar el dominio
var dominio = Dominio.findByFqdn(fqdn)
System.print("dominio encontrado: %(dominio)")
if (!dominio) {
  System.log("TXT intentado en dominio %( fqdn ) no existente por administrador")
  return "dominio don't exists"
}

// Buscar y eliminar registros TXT existentes con el mismo nombre
System.print("Buscando registros TXT existentes para %( name ).%( fqdn )")
var existingRecords = Cloudflare.listTxtRecords(dominio, name)
System.print("Registros existentes: %( existingRecords )")

if (existingRecords && existingRecords["success"] && existingRecords["result"]) {
  existingRecords["result"].each { |record|
    System.print("Eliminando registro existente: %( record["id"] ) - %( record["name"] )")
    Cloudflare.deleteRecordById(record["id"])
  }
}

// Debug info
var debugInfo = "fqdn: %(fqdn), dominio[fqdn]: %(dominio["fqdn"])"

// Crear el registro TXT en Cloudflare
var response = Cloudflare.createTxtRecord(dominio, name, content)

if (response && response["success"]) {
  return "ok - %(debugInfo)"
} else {
  return "error: %( response ) - %(debugInfo)"
}
