class Validator {
  static MINIMO_PASSWORD { 8 }
  static email(email) { email.contains("@") && email.contains(".") && !email.contains("+") }
  static password(password) { password.count >= Validator.MINIMO_PASSWORD }
  static required(field) { field.trim() != "" }
}
