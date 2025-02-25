import 'package:book_dragon/core/di/di.dart';
import 'package:book_dragon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:book_dragon/features/auth/presentation/widgets/auth_add_user_dialog.dart';
import 'package:book_dragon/features/auth/presentation/widgets/auth_user_list.dart';
import 'package:book_dragon/global_widgets/app_loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    required this.isRouteTesting,
    super.key,
  });
  final bool isRouteTesting;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.isRouteTesting
        ? Container()
        : Scaffold(
            body: Placeholder(),
          );
  }
}
