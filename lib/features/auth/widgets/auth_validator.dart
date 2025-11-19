class AuthValidator {
  static String? validateName(String name) {
    if (name.isEmpty) return "الاسم مطلوب";
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) return "البريد الإلكتروني مطلوب";
    return null;
  }

  static String? validatePassword(String pass) {
    if (pass.length < 6) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    }
    return null;
  }

  static String? validateConfirmPassword(String pass, String confirm) {
    if (pass != confirm) return "كلمتا المرور غير متطابقتين";
    return null;
  }

  //  دوال خاصة بالـ Login
  static String? validateLoginEmail(String email) {
    if (email.isEmpty) return "البريد الإلكتروني مطلوب";
    return null;
  }

  static String? validateLoginPassword(String pass) {
    if (pass.isEmpty) return "كلمة المرور مطلوبة";
    return null;
  }
}
