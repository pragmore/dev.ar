import "bialet" for Db, User

class Dominio {
  static findByFqdn(fqdn) { Db.one("SELECT * FROM dominios WHERE fqdn = ?", [fqdn]) }
}

class Usuario {
  static guardar(email, password, fqdn, ref) {
    var idUsuario = Db.save("usuarios", {
      "email": email,
      "password": User.hash(password),
      "ref": ref
    })
    Db.save("dominios", {
      "fqdn": fqdn,
      "usuario": idUsuario,
    })
    return idUsuario
  }
  static findByEmail(email) { Db.one("SELECT * FROM usuarios WHERE email = ?", [email]) }
  static iniciar(email, password) {
    var usuario = Db.one("SELECT id, password FROM usuarios WHERE email = ?", [email])
    if (usuario) {
      return User.verify(password, usuario["password"])
    }
    return false
  }
}
