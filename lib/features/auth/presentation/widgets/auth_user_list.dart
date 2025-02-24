import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_manager/features/auth/presentation/cubit/auth_cubit.dart';

class AuthUserList extends StatelessWidget {
  const AuthUserList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;

    if (state is UsersLoaded) {
      return ListView.builder(
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          final user = state.users[index];
          return ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: Image.network(
                user.avatar,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.createdAt.substring(10)),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
