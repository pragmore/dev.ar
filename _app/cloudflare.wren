import "bialet" for Http, Config, Json

class Cloudflare {
  static actualizarDns(dominio) {
    var records = Cloudflare.listRecords(dominio)
    if (records && records["success"]) {
      System.print("Dominio %(dominio["fqdn"]) encontró %( records["result"].count ) registros: %( records )")
      records["result"].each{|record| Cloudflare.deleteRecord(record["id"]) }
    } else {
      System.print("Dominio %(dominio["fqdn"]) (%(dominio["id"])) no encontró registros previos")
    }
    var response = Cloudflare.createRecord(dominio)
    System.print("Dominio %(dominio["fqdn"]): %( response )")
    return response["success"]
  }

  static esGitHub(dominio) { dominio["dns"].contains("github.io") }

  static createRecord(domain) {
    var data = Json.stringify({
      "type": type(domain["dns"]),
      "name": domain["fqdn"],
      "content": domain["dns"],
      "comment": "devar-app:%(domain["id"]):%(domain["fqdn"])",
      "ttl": 1, // automatic
      "proxied": !esGitHub(domain)
    })
    return Http.post(urlZoneRecords, data, options)
  }
  static createWwwRecord(domain) {
    var www = domain
    www["fqdn"] = "www." + domain["fqdn"]
    return createRecord(www)
  }
  static listRecords(domain) { Http.get(urlZoneRecords + "?comment.startswith=devar-app:%(domain["id"]):", options) }
  static deleteRecord(record) { Http.delete("%(urlZoneRecords)/%(record)", options) }

  static url(path) { "https://api.cloudflare.com/client/v4/%(path)" }
  static urlZoneRecords { url("zones/%( Config.get("CLOUDFLARE_ZONE_ID") )/dns_records") }
  static options {{
    "headers": {
      "Authorization": "Bearer %( Config.get("CLOUDFLARE_API_TOKEN" ))",
      "Content-Type": "application/json"
    }
  }}
  static type(dns) {
    var ip = dns.split(".")
    return (ip.count == 4 && Num.fromString(ip[3])) ? "A" : "CNAME"
  }
}
