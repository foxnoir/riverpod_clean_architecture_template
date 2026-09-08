import 'package:book_dragon/core/theme/consts.dart';
import 'package:flutter/material.dart';

class AuthCurvePainter extends CustomPainter {
  AuthCurvePainter({required this.outterCurve});

  final bool outterCurve;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.lightYellow.withAlpha((0.4 * 255).toInt())
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
