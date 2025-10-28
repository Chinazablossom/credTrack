import 'helper_functions.dart';

class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required.";
    }

    return null;
  }

  static String? validateName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return "Name is required.";
    }

    if (userName.length < 3) {
      return "Name must be at least 3 characters long.";
    }

    if (userName.length > 50) {
      return "Name must be less than 50 characters long.";
    }

    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(userName)) {
      return "Name can only contain letters and spaces.";
    }

    return null;
  }


  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required.";
    }

    final emailRegex = RegExp(
      r"^(?!\.)[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
      r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
      r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailRegex.hasMatch(email)) {
      return "Invalid email address.";
    }

    return null;
  }

  static String? validateDOB(String? dob) {
    if (dob == null || dob.isEmpty) {
      return "Date of Birth is required.";
    }

    final date = convertStringToDate(dob);
    if (date == null) {
      return "Invalid date format.";
    }

    if (date.isAfter(DateTime.now())) {
      return "Date of Birth cannot be in the future.";
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "Phone number is required.";
    }

    final phoneRegex = RegExp(r"^\+\d{1,3}\d{10}$");

    if (!phoneRegex.hasMatch(phoneNumber)) {
      return "Invalid phone number format";
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required.";
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters long.";
    }

    if (!password.contains(RegExp(r"[A-Z]"))) {
      return "Password must contain at least one uppercase letter.";
    }

    if (!password.contains(RegExp(r"[0-9]"))) {
      return "Password must contain at least one number.";
    }

    if (!password.contains(RegExp(r"[!@#$%^&*()_+-,.{|}<>~`\[\]]"))) {
      return "Password must contain at least one special character.";
    }

    return null;
  }

  static String? validateURL(String? url) {
    if (url == null || url.isEmpty) {
      return "URL is required.";
    }

    final urlRegex = RegExp(
      r"^(http|https):\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\/?.*$",
    );
    if (!urlRegex.hasMatch(url)) {
      return "Invalid URL format.";
    }

    return null;
  }
}
