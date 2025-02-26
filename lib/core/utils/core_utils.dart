import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showLoader(BuildContext context, {String? message}) {
    showDialog<void>(
      context: context,
      builder: (_) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColor.darkGreen,
            ),
            if (message != null)
              Text(
                '$message...',
                style: context.theme.textTheme.headlineSmall,
              ),
          ],
        ),
      ),
    );
  }
}
