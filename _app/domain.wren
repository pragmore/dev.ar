import "bialet" for Db, Util, Session, Config

class Dominio {
  static init {
    // Configuración
    __DOMINIOS_GRATIS = Config.num("DOMINIOS_GRATIS")
    __SUFIJO = ".dev.ar"
    __MINIMO = 6
    __CARACTERES_PERMITIDOS = "abcdefghijklmnopqrstuvwxyz0123456789-"
  }
  static MINIMO { __MINIMO }
  static CARACTERES_PERMITIDOS { __CARACTERES_PERMITIDOS }

  static findByFqdn(fqdn) { `SELECT * FROM dominios WHERE fqdn = ?`.first(fqdn.lower) }
  static findByUsuario(usuario) { `SELECT * FROM dominios WHERE usuario = ?`.fetch(usuario) }
  static delUsuarioLogueado { findByUsuario(Session.new().get("usuario")) }
  static guardar(dominio){ Db.save("dominios", dominio) }
  static total { Num.fromString(`SELECT COUNT(*) as total FROM dominios`.first()["total"]) }
  static quedan { __DOMINIOS_GRATIS - total }
  static normalizarDominio(dominio) { (dominio.endsWith(__SUFIJO) ? dominio : dominio + __SUFIJO).lower }
  static normalizarDns(dns) { 
    dns = dns.trim().lower
    if (dns.startsWith("http://")) {
      return dns.replace("http://", "")
    }
    if (dns.startsWith("https://")) {
      return dns.replace("https://", "")
    }
    return dns
  }
  static valido(dominio) {
    if (dominio.count < __MINIMO + __SUFIJO.count) {
      return false
    }
    for (caracter in dominio[0..(dominio.count - __SUFIJO.count - 1)]) {
      if (!__CARACTERES_PERMITIDOS.contains(caracter)) {
        return false
      }
    }
    return true
  }
}
Dominio.init

class Usuario {
  static guardar(email, password, fqdn, ref) {
    var idUsuario = Db.save("usuarios", {
      "email": email.lower,
      "password": Util.hash(password),
      "ref": ref,
      "created_at": `CURRENT_TIMESTAMP`,
    })
    Db.save("dominios", {
      "fqdn": fqdn.lower,
      "usuario": idUsuario,
      "created_at": `CURRENT_TIMESTAMP`,
    })
    Session.new().set("usuario", idUsuario)
    return idUsuario
  }
  static findByEmail(email) { `SELECT * FROM usuarios WHERE email = ?`.first(email.lower) }
  static iniciar(email, password) {
    var usuario = `SELECT * FROM usuarios WHERE email = ?`.first(email.lower)
    if (usuario) {
      // Restablecer password
      if (usuario["password"] == "") {
        usuario["password"] = Util.hash(password)
        Db.save("usuarios", usuario)
        System.print("Se ha restablecido la password del usuario %( email )")
        Session.new().set("usuario", usuario["id"])
        return usuario["id"]
      }
      if (Util.verify(password, usuario["password"])) {
        Session.new().set("usuario", usuario["id"])
        return usuario["id"]
      }
    }
    return false
  }
  static estaLogueado { Session.new().get("usuario") != null }
  static cerrarSesion { Session.destroy() }
}
