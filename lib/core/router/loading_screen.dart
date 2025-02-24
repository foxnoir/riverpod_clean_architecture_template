import 'package:book_lover/core/extensions/context_extensions.dart';
import 'package:book_lover/core/theme/consts.dart';
import 'package:book_lover/core/theme/media_consts.dart';
import 'package:book_lover/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          const AppImgContainer(image: AppImg.splash),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 410.w),
              child: SizedBox(
                width: 65.w,
                height: 65.w,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
