import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:book_dragon/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          localization.welcome,
          style: textStyle.headlineSmall,
        ),
        Text(
          localization.bookDragon,
          style: textStyle.headlineLarge,
        ),
        Text(
          localization.pleaseSignIn,
          style: textStyle.headlineSmall,
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: '${localization.email} / ${localization.username}',
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
            btnText: localization.signIn,
            onPressed: () {
              // TODO(sign-in-btn): login
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          localization.forgotPassword,
          style:
              textStyle.headlineSmall!.copyWith(fontWeight: AppFontWeight.bold),
        ),
      ],
    );
  }
}

class SignInOption extends StatelessWidget {
  const SignInOption({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          localization.existingUser,
          style:
              textStyle.headlineSmall!.copyWith(fontWeight: AppFontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        AppElevatedButton(
          btnText: localization.signIn,
          backgroundColor: AppColor.lightGreen,
          isEnabled: false,
          onPressed: () {
            // TODO(get-started-btn): signup
          },
        ),
      ],
    );
  }
}
