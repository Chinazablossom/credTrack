class AuthExceptions implements Exception {
  final String errCode;

  AuthExceptions(this.errCode);

  String get message {
    switch (errCode) {
      // SIGN IN WITH EMAIL AND PASSWORD
      case "invalid-email":
        return "The email address you entered is not valid. Please check the format and try again.";

      case "invalid-password":
        return "The password you entered is incorrect. Please try again.";

      case "user-disabled":
        return "Your account has been temporarily disabled. Please contact support for assistance.";

      case "user-not-found":
        return "No account found with the email address you provided. Please check your email or create a new account.";

      case "wrong-password":
        return "The password you entered is incorrect. Please check your password and try again.";

      case "too-many-requests":
        return "Too many failed login attempts. Please wait a few minutes before trying again.";

      case "user-token-expired":
        return "Your login session has expired. Please sign in again to continue.";

      case "network-request-failed":
        return "Network connection failed. Please check your internet connection and try again.";

      case "invalid-credential":
        return "Invalid credentials. Please check your email and password.";

      case "operation-not-allowed":
        return "This sign-in method is not enabled. Please contact support for assistance.";

      // CREATE USER WITH EMAIL AND PASSWORD
      case "email-already-in-use":
        return "An account with this email address already exists. Please sign in instead or use a different email.";

      case "weak-password":
        return "The password you entered is too weak. Please choose a password with at least 8 characters, including letters, numbers, and symbols.";

      case "invalid-email":
        return "The email address you entered is not valid. Please check the format and try again.";

      case "operation-not-allowed":
        return "Email and password sign-up is not enabled. Please contact support for assistance.";

      // SIGN IN WITH CREDENTIAL
      case "account-exists-with-different-credential":
        return "An account already exists with this email address using a different sign-in method. Please try signing in with the original method.";

      case "invalid-verification-code":
        return "The verification code you entered is invalid or has expired. Please request a new code.";

      case "invalid-verification-id":
        return "The verification ID is invalid. Please request a new verification code.";

      case "credential-already-in-use":
        return "This account is already linked to another user. Please use a different account.";

      // REAUTHENTICATE WITH CREDENTIAL
      case "user-mismatch":
        return "The account you're trying to verify doesn't match the currently signed-in user. Please sign in with the correct account.";

      case "requires-recent-login":
        return "This action requires recent authentication. Please sign in again to continue.";

      // PROVIDER OPERATIONS
      case "provider-already-linked":
        return "This account is already linked to the selected sign-in method.";

      case "no-such-provider":
        return "This account is not linked to the selected sign-in method.";

      case "unverified-email":
        return "Please verify your email address before proceeding. Check your inbox for a verification link.";

      // SIGN IN WITH EMAIL LINK
      case "expired-action-code":
        return "The sign-in link has expired. Please request a new one.";

      case "invalid-action-code":
        return "The sign-in link is invalid or has already been used. Please request a new one.";

      // PASSWORD RESET
      case "expired-action-code":
        return "The password reset link has expired. Please request a new one.";

      case "invalid-action-code":
        return "The password reset link is invalid or has already been used. Please request a new one.";

      case "user-not-found":
        return "No account found with this email address. Please check your email or create a new account.";

      // EMAIL VERIFICATION
      case "too-many-requests":
        return "Too many verification attempts. Please wait before requesting another verification email.";

      case "quota-exceeded":
        return "Verification email quota exceeded. Please try again later.";

      // GOOGLE SIGN IN
      case "popup-closed-by-user":
        return "Sign-in was cancelled. Please try again.";

      case "popup-blocked":
        return "Sign-in popup was blocked. Please allow popups for this site and try again.";

      case "cancelled-popup-request":
        return "Sign-in was cancelled. Please try again.";

      case "network-error":
        return "Network error occurred during sign-in. Please check your connection and try again.";

      // PHONE AUTHENTICATION
      case "invalid-phone-number":
        return "The phone number you entered is not valid. Please check the format and try again.";

      case "invalid-verification-code":
        return "The SMS verification code you entered is incorrect. Please check the code and try again.";

      case "quota-exceeded":
        return "SMS verification quota exceeded. Please try again later.";

      case "app-not-authorized":
        return "This app is not authorized to send SMS messages. Please contact support.";

      // GENERAL ERRORS
      case "app-deleted":
        return "This app has been deleted. Please contact support for assistance.";

      case "app-disabled":
        return "This app is currently disabled. Please try again later.";

      case "app-not-authorized":
        return "This app is not authorized to access Firebase. Please contact support.";

      case "configuration-not-found":
        return "App configuration not found. Please contact support for assistance.";

      case "internal-error":
        return "An internal error occurred. Please try again or contact support if the problem persists.";

      case "invalid-api-key":
        return "App configuration error. Please contact support for assistance.";

      case "invalid-app":
        return "Invalid app configuration. Please contact support for assistance.";

      case "invalid-user-token":
        return "Your session is invalid. Please sign in again.";

      case "keychain-error":
        return "Secure storage error. Please try again or restart the app.";

      case "network-error":
        return "Network connection error. Please check your internet connection and try again.";

      case "quota-exceeded":
        return "Service quota exceeded. Please try again later.";

      case "retry-password":
        return "Please try entering your password again.";

      case "session-expired":
        return "Your session has expired. Please sign in again.";

      case "timeout":
        return "The operation timed out. Please check your connection and try again.";

      case "unauthorized-domain":
        return "This domain is not authorized. Please contact support for assistance.";

      case "unsupported-persistence-type":
        return "Unsupported persistence type. Please contact support for assistance.";

      case "web-storage-unsupported":
        return "Web storage is not supported in this environment. Please contact support.";

      //  CUSTOM ERROR CODES
      case "user-cancelled":
        return "Operation was cancelled by the user.";

      case "permission-denied":
        return "You don't have permission to perform this action.";

      case "resource-exhausted":
        return "System resources are exhausted. Please try again later.";

      case "failed-precondition":
        return "Operation cannot be completed in the current state.";

      case "aborted":
        return "Operation was aborted. Please try again.";

      case "out-of-range":
        return "The operation is out of the valid range.";

      case "unimplemented":
        return "This feature is not yet implemented.";

      case "unavailable":
        return "Service is currently unavailable. Please try again later.";

      case "data-loss":
        return "Data loss occurred during the operation.";

      case "unauthenticated":
        return "You must be signed in to perform this action.";

      // ADDITIONAL FIREBASE AUTH ERRORS
      case "invalid-tenant-id":
        return "Invalid tenant ID. Please contact support for assistance.";

      case "tenant-id-mismatch":
        return "Tenant ID mismatch. Please contact support for assistance.";

      case "unsupported-tenant-operation":
        return "This operation is not supported for your account type.";

      case "invalid-recaptcha-token":
        return "Invalid reCAPTCHA token. Please try again.";

      case "missing-recaptcha-token":
        return "reCAPTCHA verification required. Please complete the verification.";

      case "invalid-recaptcha-action":
        return "Invalid reCAPTCHA action. Please try again.";

      case "missing-recaptcha-action":
        return "reCAPTCHA action required. Please try again.";

      case "invalid-recaptcha-score":
        return "reCAPTCHA score too low. Please try again.";

      case "invalid-recaptcha-secret":
        return "reCAPTCHA configuration error. Please contact support.";

      case "invalid-recaptcha-response":
        return "reCAPTCHA response invalid. Please try again.";

      case "invalid-recaptcha-site-key":
        return "reCAPTCHA site key invalid. Please contact support.";

      case "invalid-recaptcha-version":
        return "reCAPTCHA version not supported. Please contact support.";

      case "invalid-recaptcha-request":
        return "Invalid reCAPTCHA request. Please try again.";

      case "invalid-recaptcha-response-token":
        return "Invalid reCAPTCHA response token. Please try again.";

      case "invalid-recaptcha-response-action":
        return "Invalid reCAPTCHA response action. Please try again.";

      case "invalid-recaptcha-response-score":
        return "reCAPTCHA response score too low. Please try again.";

      case "invalid-recaptcha-response-secret":
        return "reCAPTCHA response secret invalid. Please contact support.";

      case "invalid-recaptcha-response-site-key":
        return "reCAPTCHA response site key invalid. Please contact support.";

      case "invalid-recaptcha-response-version":
        return "reCAPTCHA response version not supported. Please contact support.";

      case "invalid-recaptcha-response-request":
        return "Invalid reCAPTCHA response request. Please try again.";

      //  MULTI-FACTOR AUTHENTICATION
      case "multi-factor-auth-required":
        return "Multi-factor authentication is required. Please complete the verification.";

      case "multi-factor-auth-enrolled-claims-required":
        return "Multi-factor authentication enrollment required. Please complete the setup.";

      case "multi-factor-auth-unenrolled":
        return "Multi-factor authentication is not enabled for your account.";

      case "multi-factor-auth-invalid-enrollment-id":
        return "Invalid multi-factor authentication enrollment. Please try again.";

      case "multi-factor-auth-invalid-factor-id":
        return "Invalid multi-factor authentication factor. Please try again.";

      case "multi-factor-auth-invalid-session-info":
        return "Invalid multi-factor authentication session. Please try again.";

      case "multi-factor-auth-invalid-verification-code":
        return "Invalid multi-factor authentication code. Please try again.";

      case "multi-factor-auth-invalid-verification-id":
        return "Invalid multi-factor authentication verification. Please try again.";

      case "multi-factor-auth-max-exceeded":
        return "Maximum multi-factor authentication factors reached.";

      case "multi-factor-auth-second-factor-already-in-use":
        return "This multi-factor authentication method is already in use.";

      case "multi-factor-auth-unsupported-first-factor":
        return "This multi-factor authentication method is not supported as a first factor.";

      case "multi-factor-auth-unsupported-second-factor":
        return "This multi-factor authentication method is not supported as a second factor.";

      // PHONE AUTHENTICATION EXTENDED
      case "sms-quota-exceeded":
        return "SMS quota exceeded. Please try again later.";

      case "app-not-verified":
        return "This app is not verified. Please contact support.";

      case "captcha-check-failed":
        return "Captcha verification failed. Please try again.";

      case "invalid-app-credential":
        return "Invalid app credentials. Please contact support.";

      case "session-expired":
        return "Phone authentication session expired. Please try again.";

      case "blocking-function-error":
        return "Authentication blocked by security rules. Please contact support.";

      // EMAIL VERIFICATION EXTENDED
      case "email-change-needs-verification":
        return "Email change requires verification. Please check your inbox.";

      case "email-already-verified":
        return "This email is already verified.";

      case "verification-email-sent":
        return "Verification email sent. Please check your inbox.";

      case "verification-email-failed":
        return "Failed to send verification email. Please try again.";

      // PASSWORD OPERATIONS EXTENDED
      case "password-change-requires-recent-login":
        return "Password change requires recent authentication. Please sign in again.";

      case "password-too-weak":
        return "Password is too weak. Please choose a stronger password.";

      case "password-too-short":
        return "Password is too short. Please use at least 8 characters.";

      case "password-too-common":
        return "Password is too common. Please choose a unique password.";

      case "password-contains-personal-info":
        return "Password contains personal information. Please choose a different password.";

      // ACCOUNT OPERATIONS EXTENDED
      case "account-deleted":
        return "Your account has been deleted. Please contact support for assistance.";

      case "account-disabled":
        return "Your account has been disabled. Please contact support for assistance.";

      case "account-locked":
        return "Your account has been locked due to security concerns. Please contact support.";

      case "account-suspended":
        return "Your account has been suspended. Please contact support for assistance.";

      case "account-pending-verification":
        return "Your account is pending verification. Please complete the verification process.";

      case "account-needs-setup":
        return "Your account setup is incomplete. Please complete the setup process.";

      // SESSION MANAGEMENT
      case "session-invalid":
        return "Your session is invalid. Please sign in again.";

      case "session-expired":
        return "Your session has expired. Please sign in again.";

      case "session-revoked":
        return "Your session has been revoked. Please sign in again.";

      case "session-too-old":
        return "Your session is too old. Please sign in again.";

      case "session-not-found":
        return "Session not found. Please sign in again.";

      // RATE LIMITING
      case "rate-limit-exceeded":
        return "Too many requests. Please wait before trying again.";

      case "quota-exceeded":
        return "Service quota exceeded. Please try again later.";

      case "daily-limit-exceeded":
        return "Daily limit exceeded. Please try again tomorrow.";

      case "hourly-limit-exceeded":
        return "Hourly limit exceeded. Please wait before trying again.";

      case "minute-limit-exceeded":
        return "Too many requests per minute. Please wait before trying again.";

      default:
        return "An unexpected error occurred. Please try again or contact support if the problem persists. (Error: $errCode)";
    }
  }

}
