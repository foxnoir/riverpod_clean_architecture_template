import 'package:book_dragon/core/di/di.dart';
import 'package:book_dragon/core/extensions/context_extensions.dart';
import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/router/app_router.dart';
import 'package:book_dragon/core/router/app_router_names.dart';
import 'package:book_dragon/core/theme/consts.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:book_dragon/features/on_boarding/domain/entities/on_boarding_content.dart';
import 'package:book_dragon/features/on_boarding/presentation/views/widgets/on_boarding_body.dart';
import 'package:book_dragon/global_widgets/app_elevated_button.dart';
import 'package:book_dragon/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppImgContainer(
        image: AppImg.startBg,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                OnBoardingBody(
                  content: OnBoardingContent.first(context),
                ),
                OnBoardingBody(
                  content: OnBoardingContent.second(context),
                ),
                OnBoardingBody(
                  content: OnBoardingContent.third(context),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                onDotClicked: (index) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 40,
                  activeDotColor: context.theme.colorScheme.secondary,
                  dotColor: AppColor.lightGrey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: AppElevatedButton(
                  btnText: AppLocalizations.of(context).getStarted,
                  onPressed: () {
                    DI
                        .getIt<AppRouter>()
                        .router
                        .pushNamed(AppRouteNames.signUp);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
