import 'package:book_lover/core/extensions/localization_extensions.dart';
import 'package:book_lover/features/on_boarding/domain/entities/on_boarding_content.dart';
import 'package:book_lover/global_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.content, super.key});

  final OnBoardingContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, bottom: 20),
          child: Image.asset(content.image, height: 310.w),
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                content.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                child: Text(
                  content.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              AppElevatedButton(
                btnText: AppLocalizations.of(context).getStarted,
                onPressed: () {
                  // TODO(get-started-btn): go to auth
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
