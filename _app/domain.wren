import "bialet" for Db, Util

class Dominio {
  static findByFqdn(fqdn) { Db.one("SELECT * FROM dominios WHERE fqdn = ?", [fqdn]) }
}

class Usuario {
  static guardar(email, password, fqdn, ref) {
    // TODO Hash
    // pass = Util.password(password)
    var pass = {"safe": password, "hash": password}
    var idUsuario = Db.save("usuarios", {
      "email":email,
      "password": pass["safe"],
      "password_hash": pass["hash"],
      "ref": ref
    })
    Db.save("dominios", {
      "fqdn": fqdn,
      "usuario": idUsuario,
    })
    return idUsuario
  } 
  static findByEmail(email) { Db.one("SELECT * FROM usuarios WHERE email = ?", [email]) }
}
