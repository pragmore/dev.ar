import "bialet" for Response
import "_app/domain" for Dominio

Response.json({"total": Dominio.total, "quedan": Dominio.quedan})
