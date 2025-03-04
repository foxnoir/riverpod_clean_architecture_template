import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/features/auth/presentation/controllers/auth_controller.dart';
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

    final router = ref.read(goRouterProvider);
    const verificationId = '1234';
    final code = ref.watch(countryCodeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(localization.welcome, style: textStyle.headlineSmall),
        Text(localization.bookDragon, style: textStyle.headlineLarge),
        Text(localization.enterNumberForCode, style: textStyle.headlineSmall),
        const SizedBox(height: 16),
        AppTextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          readOnly: code == null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 8, left: 14),
            child: GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (code) {
                    ref.read(countryCodeProvider.notifier).changeCountry(code);
                  },
                  countryListTheme: CountryListThemeData(
                    backgroundColor: AppColor.lightBrown,
                    bottomSheetHeight: 600.h,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    textStyle: textStyle.labelMedium!
                        .copyWith(fontWeight: AppFontWeight.medium),
                    searchTextStyle: textStyle.labelMedium,
                    inputDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: localization.search,
                      hintStyle: textStyle.labelMedium,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: code == null ? 6.h : 1.5.h),
                child: Text(
                  code == null
                      ? localization.pickYourCode
                      : '${code.flagEmoji} +${code.phoneCode} ',
                  style: textStyle.headlineSmall!.copyWith(
                    color: code == null ? AppColor.creme : AppColor.lightYellow,
                    fontSize: code == null ? 13.sp : 18.sp,
                    fontWeight: code == null
                        ? AppFontWeight.medium
                        : AppFontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 210,
          child: AppElevatedButton(
            btnText: localization.sendCode,
            onPressed: () {
              router.pushNamed(
                AppRouteNames.otp,
                queryParameters: {
                  'verification_Id': verificationId,
                },
              );
            },
          ),
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
