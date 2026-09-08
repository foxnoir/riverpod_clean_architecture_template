import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          localization.signUpWith,
          style: textStyle.headlineSmall,
        ),
        Text(
          localization.bookDragon,
          style: textStyle.headlineLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          decoration: InputDecoration(
            hintText:
                '${localization.enter}  ${localization.email} / ${localization.username}',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: localization.password,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: 210.w,
          child: AppElevatedButton(
            btnText: localization.signUp,
            onPressed: () {
              // TODO(sign-up-btn): login
            },
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class SignUpOption extends StatelessWidget {
  const SignUpOption({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          localization.or,
          style: textStyle.headlineMedium!.copyWith(color: AppColor.darkBrown),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        AppElevatedButton(
          btnText: localization.signUp,
          isEnabled: false,
          onPressed: () {
            // TODO(get-started-btn): signup
          },
        ),
      ],
    );
  }
}
