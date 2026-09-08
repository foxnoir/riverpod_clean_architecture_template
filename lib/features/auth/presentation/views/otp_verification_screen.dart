import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:book_dragon/core/utils/core_utils.dart';
import 'package:book_dragon/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AppImgContainer(
        image: AppImg.startBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImg.otp),
              SizedBox(height: 26.h),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(context);
                  // await ref.read(authControllerProvider).verifyOTP(
                  //       context: context,
                  //       verificationId: verificationId,
                  //       otp: pin,
                  //     );
                },
                defaultPinTheme: PinTheme(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
