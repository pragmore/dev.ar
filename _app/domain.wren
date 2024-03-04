import "bialet" for Db, Util, Session

var SUFIJO = ".dev.ar"
var DOMINIOS_GRATIS = 200
var MINIMO = 6

class Dominio {
  static findByFqdn(fqdn) { `SELECT * FROM dominios WHERE fqdn = ?`.first(fqdn) }
  static findByUsuario(usuario) { `SELECT * FROM dominios WHERE usuario = ?`.fetch(usuario) }
  static delUsuarioLogueado { findByUsuario(Session.new().get("usuario")) }
  static guardar(dominio){ Db.save("dominios", dominio) }
  static total { Num.fromString(`SELECT COUNT(*) as total FROM dominios`.first()["total"]) }
  static quedan { DOMINIOS_GRATIS - total }
  static normalizarDominio(dominio) { dominio.endsWith(SUFIJO) ? dominio : dominio + SUFIJO }
  static valido(dominio) { dominio.count >= MINIMO + SUFIJO.count }
}

class Usuario {
  static guardar(email, password, fqdn, ref) {
    var idUsuario = Db.save("usuarios", {
      "email": email,
      "password": Util.hash(password),
      "ref": ref
    })
    Db.save("dominios", {
      "fqdn": fqdn,
      "usuario": idUsuario,
    })
    return idUsuario
  }
  static findByEmail(email) { `SELECT * FROM usuarios WHERE email = ?`.first(email) }
  static iniciar(email, password) {
    var usuario = `SELECT id, password FROM usuarios WHERE email = ?`.first(email)
    if (usuario) {
      if (Util.verify(password, usuario["password"])) {
        Session.new().set("usuario", usuario["id"])
        return usuario["id"]
      }
    }
    return false
  }
  static estaLogueado { Session.new().get("usuario") != null }
}
