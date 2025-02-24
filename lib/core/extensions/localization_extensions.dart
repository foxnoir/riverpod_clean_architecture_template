import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension on AppLocalizations to provide fallback strings
extension AppLocalizationsWithFallback on AppLocalizations? {
  String get getStarted => this?.getStarted ?? 'Get started';

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
      this?.yesterdayDifferentPerson ?? 'Yesterday I was someone else.';

  String get curiouser =>
      this?.curiouser ?? 'This is getting stranger and stranger.';

  String get whoAmI => this?.whoAmI ?? 'Who am I? That’s a tricky question.';

  String get doubtFlying =>
      this?.doubtFlying ?? 'If you doubt it, you can’t fly.';

  String get bigAdventure =>
      this?.bigAdventure ?? 'Death is the greatest adventure.';

  String get faithTrustPixieDust =>
      this?.faithTrustPixieDust ?? 'Believe in magic and yourself.';
}
