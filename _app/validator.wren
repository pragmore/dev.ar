class Validator {
  static MINIMO_PASSWORD { 8 }
  static email(email) { email.contains("@") && email.contains(".") && !email.contains("+") }
  static password(password) { password.count >= Validator.MINIMO_PASSWORD }
  static required(field) { field.trim() != "" }
  
  // Valida si es una dirección IP válida (IPv4)
  static esIp(valor) {
    var partes = valor.split(".")
    if (partes.count != 4) return false
    for (parte in partes) {
      var num = Num.fromString(parte)
      if (num == null || num < 0 || num > 255) return false
    }
    return true
  }
  
  // Valida si es un dominio válido (CNAME)
  static esDominio(valor) {
    // No puede ser una URL (no debe tener http://, https://, ni barras)
    if (valor.contains("http://") || valor.contains("https://") || valor.contains("/")) {
      return false
    }
    // Debe contener al menos un punto
    if (!valor.contains(".")) return false
    // No debe empezar o terminar con punto o guión
    if (valor.startsWith(".") || valor.endsWith(".") || valor.startsWith("-") || valor.endsWith("-")) {
      return false
    }
    // Solo puede contener letras, números, puntos y guiones
    var permitidos = "abcdefghijklmnopqrstuvwxyz0123456789.-"
    for (caracter in valor) {
      if (!permitidos.contains(caracter)) return false
    }
    // Debe tener al menos un carácter antes y después del punto
    var partes = valor.split(".")
    for (parte in partes) {
      if (parte.count == 0) return false
    }
    return true
  }
  
  // Valida DNS: debe ser IP o dominio válido
  static dnsValido(valor) {
    if (valor.trim() == "") return false
    return esIp(valor) || esDominio(valor)
  }
}
