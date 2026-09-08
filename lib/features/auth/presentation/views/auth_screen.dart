import 'package:book_dragon/core/theme/media_consts.dart';
import 'package:book_dragon/features/auth/presentation/widgets/auth_curve_painter.dart';
import 'package:book_dragon/features/auth/presentation/widgets/sign_in.dart';
import 'package:book_dragon/features/auth/presentation/widgets/signup.dart';
import 'package:book_dragon/global_widgets/app_img_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppImgContainer(
        image: AppImg.startBg,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    signIn = true;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: signIn ? 400.h : 300.h,
                  child: CustomPaint(
                    painter: AuthCurvePainter(outterCurve: signIn),
                    child: Container(
                      padding: EdgeInsets.only(bottom: signIn ? 0 : 55),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            child:
                                signIn ? const SignIn() : const SignInOption(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    signIn = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: signIn ? 350.h : 550.h,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: signIn ? 55 : 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child:
                              !signIn ? const SignUp() : const SignUpOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
