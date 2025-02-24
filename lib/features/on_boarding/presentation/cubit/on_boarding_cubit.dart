import 'package:bloc/bloc.dart';
import 'package:book_dragon/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:book_dragon/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'on_boarding_state.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingUserIsFirstTimer());

    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
