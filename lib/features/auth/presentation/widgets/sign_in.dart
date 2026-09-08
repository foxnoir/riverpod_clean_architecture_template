import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/router/app_router.dart';
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

    // Auth State als AsyncValue abrufen
    final authState = ref.watch(authControllerProvider);

    // Country Code abrufen
    final countryCode = ref.watch(countryCodeControllerProvider);

    // Fehler überwachen und Snackbar anzeigen
    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      if (!state.isLoading && state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error.toString())),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(localization.welcome, style: textStyle.headlineSmall),
        Text(localization.bookDragon, style: textStyle.headlineLarge),
        Text(localization.enterNumberForCode, style: textStyle.headlineSmall),
        const SizedBox(height: 16),

        // Telefonnummer Input
        AppTextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          readOnly: countryCode == null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 8, left: 14),
            child: GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  onSelect: (code) {
                    ref
                        .read(countryCodeControllerProvider.notifier)
                        .changeCountry(code);
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
                padding:
                    EdgeInsets.only(top: countryCode == null ? 6.h : 1.5.h),
                child: Text(
                  countryCode == null
                      ? localization.pickYourCode
                      : '${countryCode.flagEmoji} +${countryCode.phoneCode} ',
                  style: textStyle.headlineSmall!.copyWith(
                    color: countryCode == null
                        ? AppColor.creme
                        : AppColor.lightYellow,
                    fontSize: countryCode == null ? 13.sp : 18.sp,
                    fontWeight: countryCode == null
                        ? AppFontWeight.medium
                        : AppFontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Senden-Button mit Auth-Status
        SizedBox(
          width: 210,
          child: AppElevatedButton(
            btnText: localization.sendCode,
            isEnabled: countryCode != null &&
                phoneController.text.isNotEmpty &&
                !authState.isLoading,
            isLoading: authState.isLoading,
            onPressed: authState.isLoading
                ? null
                : () {
                    if (countryCode == null || phoneController.text.isEmpty) {
                      return;
                    }

                    ref.read(authControllerProvider.notifier).sendOTP(
                          '+${countryCode.phoneCode}${phoneController.text}',
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
