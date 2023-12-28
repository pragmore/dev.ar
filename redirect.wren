import "bialet" for Response, Request
import "_app/domain" for Dominio

var fqdn = Request.get("fqdn")
var uri = Request.get("uri")
var dominio = Dominio.findByFqdn(fqdn)

if (dominio) {
  return Response.redirect("%(dominio["redirect"])/%(uri)")
}

Response.redirect("https://home.dev.ar")
