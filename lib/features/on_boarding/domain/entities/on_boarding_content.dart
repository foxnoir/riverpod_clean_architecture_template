import 'package:book_dragon/core/extensions/localization_extensions.dart';
import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:book_dragon/l10n/app_localizations.dart';

class OnBoardingContent extends Equatable {
  const OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  factory OnBoardingContent.first(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return OnBoardingContent(
      image: AppImg.page1,
      title: localizations.theBookWasBetter,
      description: localizations.bigAdventure,
    );
  }

  factory OnBoardingContent.second(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return OnBoardingContent(
      image: AppImg.page2,
      title: localizations.readMoreBooks,
      description: localizations.curiouser,
    );
  }

  factory OnBoardingContent.third(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return OnBoardingContent(
      image: AppImg.page3,
      title: localizations.booksAreBetterThanPeople,
      description: localizations.yesterdayDifferentPerson,
    );
  }

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
