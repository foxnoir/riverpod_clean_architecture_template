import 'package:flutter/material.dart';

class AppImgContainer extends StatelessWidget {
  const AppImgContainer({
    required this.image,
    this.child,
    super.key,
  });

  final Widget? child;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: .4,
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: child != null ? SafeArea(child: child!) : null,
    );
  }
}
