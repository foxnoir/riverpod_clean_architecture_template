import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.onPressed,
    required this.btnText,
    this.isEnabled = true,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback? onPressed;
  final String btnText;
  final bool isEnabled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AbsorbPointer(
      absorbing: !isEnabled,
      child: SizedBox(
        width: 210.w,
        height: 44.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ??
                theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText,
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 8.w),
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
