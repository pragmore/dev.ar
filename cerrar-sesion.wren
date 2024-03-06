import "bialet" for Response, Session
import "_app/domain" for Usuario

Usuario.cerrarSesion
Response.redirect("/")
