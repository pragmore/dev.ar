import "bialet" for Db, Util

class Dominio {
  static findByFqdn(fqdn) { `SELECT * FROM dominios WHERE fqdn = ?`.first(fqdn) }
  static findByUsuario(usuario) { `SELECT * FROM dominios WHERE usuario = ?`.fetch(usuario) }
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
        return usuario["id"]
      }
    }
    return false
  }
}
