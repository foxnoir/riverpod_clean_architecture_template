import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/features/on_boarding/domain/entities/on_boarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.content, super.key});

  final OnBoardingContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, bottom: 20),
          child: Image.asset(content.image, height: 310.w),
        ),
        Padding(
          padding: const EdgeInsets.all(25).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                content.title,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 20.h),
              Text(
                content.description,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
