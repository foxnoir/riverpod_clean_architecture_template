import 'package:book_lover/core/theme/media_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.onPressed,
    required this.btnText,
    super.key,
  });

  final VoidCallback onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210.w,
      height: 44.w,
      child: ElevatedButton(
        onPressed: onPressed,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(
                text: btnText,
                style: DefaultTextStyle.of(context).style,
              ),
              maxLines: 1,
              textDirection: TextDirection.ltr,
            )..layout();

            final textWidth = textPainter.width;

            return Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  child: Text(
                    btnText,
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  left: textWidth / 2 + 85.w,
                  child: Image.asset(
                    AppImg.btnIcon,
                    fit: BoxFit.cover,
                    width: 28.w,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
