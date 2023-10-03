class Validator {
  static email(email) {
    return true
  }
  static domain(domain) {
    return true
  }
  static required(field) { field.trim() != "" }
}
