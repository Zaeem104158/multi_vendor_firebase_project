import 'dart:io';

final passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
final emailpattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
final regPassExp = RegExp(passwordPattern);
final regEmailExp = RegExp(emailpattern);

bool isSignUpValidated(
    {String? fullName, String? email, String? password, File? imageFile}) {
  if (regEmailExp.hasMatch(email!) &&
      regPassExp.hasMatch(password!) &&
      fullName != null &&
      imageFile != null) {
    return true;
  }

  return false;
}

bool isLoginValidated({String? email, String? password}) {
  if (regEmailExp.hasMatch(email!) && regPassExp.hasMatch(password!)) {
    return true;
  }
  return false;
}

bool isForgetPasswordValidated({String? email}) {
  if (regEmailExp.hasMatch(email!)) {
    return true;
  }
  return false;
}
