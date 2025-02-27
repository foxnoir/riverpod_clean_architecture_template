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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final textStyle = context.theme.textTheme;

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
          hintText: localization.pickYourCode,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (code) {
                    // ref.read(countryCodeProvider.notifier).changeCountry(code);
                  },
                  countryListTheme: CountryListThemeData(
                    backgroundColor: AppColor.darkBrown,
                    bottomSheetHeight: MediaQuery.of(context).size.height * .6,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppConst.kBorderRadius * 3),
                    ),
                    textStyle: textStyle.labelMedium,
                    searchTextStyle: textStyle.labelMedium,
                    inputDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: localization.search,
                      hintStyle: textStyle.labelMedium!.copyWith(
                        color: AppColor.lightGrey,
                      ),
                      hintText: localization.search,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.5.h),
                child: Text(
                  localization.pickYourCode,
                  // style: GoogleFonts.poppins(
                  //   fontSize: code == null ? 13 : 18,
                  //   color: code == null
                  //       ? Colours.lightBlue
                  //       : Colours.darkBackground,
                  //   fontWeight:
                  //       code == null ? FontWeight.w500 : FontWeight.bold,
                  // ),
                ),
              ),
            ),
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
          onPressed: () {
            // TODO(get-started-btn): signup
          },
        ),
      ],
    );
  }
}
