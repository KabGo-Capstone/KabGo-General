bool validatePhoneNumber(String phone) {
  final phoneRegExp = RegExp(r'^\+?\d{10,11}$');
  return phoneRegExp.hasMatch(phone);
}
