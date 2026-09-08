import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.onPressed,
    required this.btnText,
    this.isEnabled = true,
    this.backgroundColor,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final String btnText;
  final bool isEnabled;
  final bool isLoading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AbsorbPointer(
      absorbing:
          !isEnabled || isLoading, // Deaktiviert Button während isLoading
      child: SizedBox(
        width: 210.w,
        height: 44.w,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ??
                theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.creme),
                  ),
                )
              else
                Text(
                  btnText,
                  textAlign: TextAlign.center,
                ),
              if (!isLoading) SizedBox(width: 8.w),
              if (!isLoading)
                Image.asset(
                  AppImg.btnIcon,
                  fit: BoxFit.cover,
                  width: 20.w,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
