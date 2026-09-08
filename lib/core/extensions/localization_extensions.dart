import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension on AppLocalizations to provide fallback strings
extension AppLocalizationsWithFallback on AppLocalizations? {
  String get getStarted => this?.getStarted ?? 'Get Started';

  String get theBookWasBetter =>
      this?.theBookWasBetter ?? 'The book was better.';

  String get readMoreBooks => this?.readMoreBooks ?? 'Read more books!';

  String get booksAreBetterThanPeople =>
      this?.booksAreBetterThanPeople ?? 'Books are better than people.';

  String get pageNotFoundTitle => this?.pageNotFoundTitle ?? 'Page not found';

  String get pageNotFoundScreenMessage =>
      this?.pageNotFoundScreenMessage ??
      'The page you are looking for does not exist or has been moved.';

  String get goToHomepage => this?.goToHomepage ?? 'Go to homepage';

  String get yesterdayDifferentPerson =>
      this?.yesterdayDifferentPerson ??
      "It's no use going back to yesterday, "
          'because I was a different person then.';

  String get curiouser => this?.curiouser ?? 'Curiouser and curiouser!';

  String get whoAmI =>
      this?.whoAmI ?? "Who in the world am I? Ah, that's the great puzzle.";

  String get doubtFlying =>
      this?.doubtFlying ??
      'The moment you doubt whether you can fly, you cease forever '
          'to be able to do it.';

  String get bigAdventure =>
      this?.bigAdventure ?? 'To die will be an awfully big adventure.';

  String get faithTrustPixieDust =>
      this?.faithTrustPixieDust ??
      'All you need is faith, trust, and a little bit of pixie dust.';

  String get authentication => this?.authentication ?? 'Authentication';

  String get signIn => this?.signIn ?? 'Sign In';

  String get logout => this?.logout ?? 'Logout';

  String get signUp => this?.signUp ?? 'Sign Up';

  String get forgotPassword => this?.forgotPassword ?? 'Forgot Password?';

  String get resetPassword => this?.resetPassword ?? 'Reset Password';

  String get email => this?.email ?? 'Email';

  String get password => this?.password ?? 'Password';

  String get confirmPassword => this?.confirmPassword ?? 'Confirm Password';

  String get username => this?.username ?? 'Username';

  String get rememberMe => this?.rememberMe ?? 'Remember Me';

  String get signInFailed => this?.signInFailed ?? 'Sign In failed';

  String get invalidCredentials =>
      this?.invalidCredentials ?? 'Invalid credentials';

  String get accountLocked => this?.accountLocked ?? 'Account locked';

  String get successfulRegistration =>
      this?.successfulRegistration ?? 'Successful registration';

  String get welcome => this?.welcome ?? 'Welcome to';

  String get pleaseSignIn => this?.pleaseSignIn ?? 'Please sign in to continue';

  String get existingUser => this?.existingUser ?? 'Existing user?';

  String get enter => this?.enter ?? 'Enter';

  String get bookDragon => this?.bookDragon ?? 'Book Dragon';

  String get signUpWith => this?.signUpWith ?? 'Sign up with';

  String get orAuthWith => this?.orAuthWith ?? 'Or auth with';

  String get or => this?.or ?? 'OR';

  String get enterNumberForCode =>
      this?.enterNumberForCode ??
      'Please enter your number to get the verification code.';

  String get search => this?.search ?? 'Search';

  String get pickYourCode => this?.pickYourCode ?? 'Pick your code';

  String get sendCode => this?.sendCode ?? 'Send Code';
}
