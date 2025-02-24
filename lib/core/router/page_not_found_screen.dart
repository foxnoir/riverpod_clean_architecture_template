import 'package:book_lover/core/extensions/localization_extensions.dart';
import 'package:book_lover/core/theme/media_consts.dart';
import 'package:book_lover/global_widgets/app_elevated_button.dart';
import 'package:book_lover/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({
    required this.isRouteTesting,
    super.key,
  });
  final bool isRouteTesting;

  @override
  Widget build(BuildContext context) {
    return isRouteTesting
        ? Container()
        : Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).pageNotFoundTitle),
            ),
            body: Stack(
              children: [
                const AppImgContainer(image: AppImg.notFound),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 410.w),
                    child: AppElevatedButton(
                      btnText: AppLocalizations.of(context).goToHomepage,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
