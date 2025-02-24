import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_manager/core/extensions/localization_extensions.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).pageNotFound),
      ),
      body: const Placeholder(),
    );
  }
}
