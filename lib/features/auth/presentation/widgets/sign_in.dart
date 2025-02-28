import 'package:book_dragon/core/di/di.dart';
import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:book_dragon/global_widgets/app_text_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;

    final phoneController = useTextEditingController();
    final code = '+49';

    const verificationId = '1234';

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
          localization.enterNumberForCode,
          style: textStyle.headlineSmall,
        ),
        const SizedBox(
          height: 16,
        ),
        AppTextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          readOnly: true,
          hintText: localization.pickYourCode,
          onTap: () {
            showCountryPicker(
              context: context,
              onSelect: (code) {},
              countryListTheme: CountryListThemeData(
                bottomSheetHeight: MediaQuery.of(context).size.height * .6,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                inputDecoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: localization.search,
                  hintText: localization.search,
                ),
              ),
            );
          },
          suffixIcon: const Padding(
            padding: EdgeInsets.only(left: 14),
            child: Icon(Icons.arrow_drop_down, color: AppColor.creme),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: 210.w,
          child: AppElevatedButton(
            btnText: localization.sendCode,
            onPressed: () {
              DI.getIt<AppRouter>().router.pushNamed(
                AppRouteNames.otp,
                queryParameters: {
                  if (verificationId != null) 'verification_Id': verificationId,
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
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
          onPressed: () {},
        ),
      ],
    );
  }
}
