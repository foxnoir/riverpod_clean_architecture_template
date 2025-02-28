import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:book_dragon/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Verhindert Überlauf
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset(AppImg.notFound, height: 510.w),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
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
      ),
    );
  }
}
