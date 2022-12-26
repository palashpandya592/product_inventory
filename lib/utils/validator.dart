class AppValidation {
  static String? validateEmail(value) {
    Pattern patten = r"^[a-z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(patten.toString());
    if (value.length == 0) {
      return "Enter Your Email";
    } else if (!regex.hasMatch(value)) {
      return 'Please enter valid email ';
    } else if (value.length == 1) {
      return null;
    }
    return null;
  }

  static String? nameValidation(value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Field Is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String? numberValidation1(value) {
    String pattern = r'(^[1-9 ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Field Is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Number Must Be 1 to 9";
    }
    return null;
  }

  static String? validatePassword(value) {
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    var minLength = 8;
    bool hasMinLength = value.length >= minLength;
    if (value.isEmpty) {
      return 'Enter Password';
    }
    if (!hasDigits) {
      return 'Use minimum 8 characters, and at least one letter and one number with special character';
    }
    if ((!hasUppercase) && (!hasLowercase)) {
      return 'Use minimum 8 characters, and at least one letter and one number with special character';
    }
    if (!hasMinLength) {
      return 'Use minimum 8 characters, and at least one letter and one number with special character';
    }
    if (!hasSpecialCharacters) {
      return 'Use minimum 8 characters, and at least one letter and one number with special character';
    }
    return null;
  }

  static String? password(value) {
    if (value.isEmpty) {
      return 'Enter Password';
    }
    if (value.length < 8) {
      return 'Enter At Least 8 Character';
    }
    return null;
  }
}
