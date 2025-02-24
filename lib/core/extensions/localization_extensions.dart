import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension on AppLocalizations to provide fallback strings
extension AppLocalizationsWithFallback on AppLocalizations? {
  String get fetchingUsers => 'Fetching users';

  String get creatingUser => 'Creating user';

  String get addUser => 'Add user';

  String get pageNotFound => 'Page not found';
}
