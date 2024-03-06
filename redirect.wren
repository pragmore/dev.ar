import "bialet" for Response, Request
import "_app/domain" for Dominio

var fqdn = Request.get("fqdn")
var uri = Request.get("uri")
var dominio = Dominio.findByFqdn(fqdn)

if (dominio && dominio["redirect"].count > 0) {
  var url = dominio["redirect"].trimEnd("/")
  if (!url.contains("://")) {
    url = "http://" + url
  }
  return Response.redirect("%(url)%(uri)")
}

Response.redirect("https://home.dev.ar")
