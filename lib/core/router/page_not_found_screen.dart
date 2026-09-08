import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:book_dragon/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:book_dragon/l10n/app_localizations.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).pageNotFoundTitle),
      ),
      body: AppImgContainer(
        image: AppImg.startBg,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        AppImg.notFound,
                        height: (constraints.maxHeight * 0.55).clamp(160, 400),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: AppElevatedButton(
                        btnText: AppLocalizations.of(context).goToHomepage,
                        onPressed: () {
                          // Korrigierte Navigation
                          // GoRouter.of(context).go(AppRouteNames.auth);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
