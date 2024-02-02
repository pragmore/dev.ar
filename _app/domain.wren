import "bialet" for Db, Util, Session

class Dominio {
  static findByFqdn(fqdn) { `SELECT * FROM dominios WHERE fqdn = ?`.first(fqdn) }
  static findByUsuario(usuario) { `SELECT * FROM dominios WHERE usuario = ?`.fetch(usuario) }
  static delUsuarioLogueado { findByUsuario(Session.new().get("usuario")) }
  static guardar(dominio){ Db.save("dominios", dominio) }
}

class Usuario {
  static guardar(email, password, fqdn, ref) {
    System.print("%( email ), %( password ), %( fqdn ), %( ref )")
    System.print("%( email.type ), %( password.type ), %( fqdn.type ), %( ref.type )")
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
