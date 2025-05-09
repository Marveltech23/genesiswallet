class Mvalidation {
  static String? validationEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    //Regular expression for email validtion
    RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

//check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 character long.';
    }

    //check for upppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
// check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contains at least one number';
    }

// check for special character
    if (!value.contains(RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'))) {
      return 'Password must contain  at least one special character';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // regular expression for phone number validation (assuming a 10- digit US phone format)

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number formate(10 digits required)';
    }
    return null;
  }

  //
}
