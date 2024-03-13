import "bialet" for Http, Config, Json

class Cloudflare {
  static createRecord(domain) {
    var data = Json.stringify({
        "type": type(domain["dns"]),
        "name": domain["fqdn"],
        "content": domain["dns"],
        "comment": "devar-app:%(domain["id"]):%(domain["fqdn"])",
        "ttl": 1, // automatic
        "proxied": true
    })
    return Http.post(urlZoneRecords, data, options)
  }
  static url(path) { "https://api.cloudflare.com/client/v4/%(path)" }
  static urlZoneRecords { url("zones/%( Config.get("CLOUDFLARE_ZONE_ID") )/dns_records") }
  static options { {
        "headers": {
            "X-Auth-Email": Config.get("CLOUDFLARE_EMAIL"),
            "X-Auth-Key": Config.get("CLOUDFLARE_API_KEY"),
            "Content-Type": "application/json"
        }
  } }
  static type(dns) {
    var ip = dns.split(".")
    return (ip.count == 4 && Num.fromString(ip[3])) ? "A" : "CNAME"
  }
}
