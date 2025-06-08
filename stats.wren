import "_app/domain" for Dominio

Response.json({
  "total": Dominio.total,
  "quedan": Dominio.quedan,
  "ultimos": `SELECT fqdn FROM dominios ORDER BY id DESC LIMIT 10`.fetch().map{|d| d["fqdn"]}.toList
})
