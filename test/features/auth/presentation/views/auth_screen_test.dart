import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_manager/core/extensions/localization_extensions.dart';
import 'package:todo_manager/features/auth/data/models/user_model.dart';
import 'package:todo_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_manager/features/auth/presentation/views/auth_screen.dart';
import 'package:todo_manager/features/auth/presentation/widgets/auth_add_user_dialog.dart';
import 'package:todo_manager/global_widgets/app_loading_column.dart';

import '../../../../test_helpers/localization_mock.dart';
import '../../../../test_helpers/mocks.mock.dart';

void main() {
  late MockAuthCubit mockAuthCubit;

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    mockAuthCubit = MockAuthCubit();
  });

  Future<void> pumpAuthScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<AuthCubit>.value(
          value: mockAuthCubit,
          child: const AuthView(),
        ),
      ),
    );
  }

  group('AuthScreen Widget Tests', () {
    final tListUsers = [
      UserModel.empty().copyWith(
        name: 'John Doe',
        avatar:
            'https://redthread.uoregon.edu/files/large/affd16fd5264cab9197da4cd1a996f820e601ee4.jpg',
      ),
      UserModel.empty().copyWith(
        name: 'Jane Doe',
        avatar:
            'https://redthread.uoregon.edu/files/large/affd16fd5264cab9197da4cd1a996f820e601ee4.jpg',
      ),
    ];

    testWidgets('displays [AppLoadingColumn] when state is [GettingUsers]',
        (tester) async {
      // Arrange
      final appLocalizations = await getLocalizations(tester)
          .then((appLocalizations) => appLocalizations);
      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      when(() => mockAuthCubit.state).thenReturn(const GettingUsers());

      // Act
      await pumpAuthScreen(tester);
      await tester.pump(); // Allow the state to be reflected

      // Assert
      expect(find.byType(AppLoadingColumn), findsOneWidget);
      expect(
        find.textContaining(appLocalizations.fetchingUsers),
        findsOneWidget,
      );
    });

    testWidgets('displays [AppLoadingColumn] when state is [CreatingUser]',
        (tester) async {
      // Arrange
      final appLocalizations = await getLocalizations(tester)
          .then((appLocalizations) => appLocalizations);
      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      when(() => mockAuthCubit.state).thenReturn(const CreatingUser());

      // Act
      await pumpAuthScreen(tester);
      await tester.pump();

      // Assert
      expect(find.byType(AppLoadingColumn), findsOneWidget);
      expect(
        find.textContaining(appLocalizations.creatingUser),
        findsOneWidget,
      );
    });

    testWidgets('displays [UserList] when state is [UsersLoaded]',
        (tester) async {
      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      when(() => mockAuthCubit.state)
          .thenReturn(UsersLoaded(users: tListUsers));

      // Act
      await pumpAuthScreen(tester);
      await tester.pump();

      // Assert
      expect(find.byType(ListTile), findsNWidgets(tListUsers.length));
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(tListUsers.length));
    });

    testWidgets('displays [ErrorIcon] when avatar fails to load',
        (tester) async {
      // Arrange
      final errorAvatarListUsers = [
        UserModel.empty().copyWith(
          name: 'Error Avatar',
          avatar: 'https://example.com/invalid_url.jpg',
        ),
      ];

      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      when(() => mockAuthCubit.state)
          .thenReturn(UsersLoaded(users: errorAvatarListUsers));

      // Act
      await pumpAuthScreen(tester);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets(
        'displays [AuthAddUserDialog] when '
        '[FloatingActionButton] is pressed', (tester) async {
      // Arrange
      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      when(() => mockAuthCubit.state).thenReturn(const GettingUsers());

      // Act
      await pumpAuthScreen(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(AuthAddUserDialog), findsOneWidget);
    });

    testWidgets('shows [SnackBar] when state is [AuthError]', (tester) async {
      // Arrange
      const errorMessage = 'Error occurred';
      when(() => mockAuthCubit.getUsers()).thenAnswer((_) async {});
      whenListen(
        mockAuthCubit,
        Stream.fromIterable([const AuthError(message: errorMessage)]),
        initialState: const GettingUsers(),
      );

      // Act
      await pumpAuthScreen(tester);
      await tester.pump();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
