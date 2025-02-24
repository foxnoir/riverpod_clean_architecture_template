import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_manager/core/di/di.dart';
import 'package:todo_manager/core/extensions/localization_extensions.dart';
import 'package:todo_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_manager/features/auth/presentation/widgets/auth_add_user_dialog.dart';
import 'package:todo_manager/features/auth/presentation/widgets/auth_user_list.dart';
import 'package:todo_manager/global_widgets/app_loading_column.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    required this.isRouteTesting,
    super.key,
  });
  final bool isRouteTesting;

  @override
  Widget build(BuildContext context) {
    return isRouteTesting
        ? Container()
        : BlocProvider(
            create: (context) => DI.getIt<AuthCubit>(),
            child: const AuthView(),
          );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? AppLoadingColumn(message: localization.fetchingUsers)
              : state is CreatingUser
                  ? AppLoadingColumn(message: localization.creatingUser)
                  : const AuthUserList(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => AuthAddUserDialog(
                  nameController: nameController,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text(localization.addUser),
          ),
        );
      },
    );
  }
}
