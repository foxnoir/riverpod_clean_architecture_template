// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_dragon/core/di/register_module.dart' as _i400;
import 'package:book_dragon/core/log/logger.dart' as _i673;
import 'package:book_dragon/core/router/app_router.dart' as _i193;
import 'package:book_dragon/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i946;
import 'package:book_dragon/features/auth/data/repositories/auth_repo_impl.dart'
    as _i874;
import 'package:book_dragon/features/auth/domain/repositories/auth_repository.dart'
    as _i1060;
import 'package:book_dragon/features/auth/domain/usecases/send_otp.dart'
    as _i522;
import 'package:book_dragon/features/auth/domain/usecases/verify_otp.dart'
    as _i214;
import 'package:book_dragon/features/on_boarding/data/data_sources/on_boarding_local_data_source.dart'
    as _i126;
import 'package:book_dragon/features/on_boarding/data/repos/on_boarding_repo_impl.dart'
    as _i974;
import 'package:book_dragon/features/on_boarding/domain/repos/on_boarding_repo.dart'
    as _i554;
import 'package:book_dragon/features/on_boarding/domain/usecases/cache_first_timer.dart'
    as _i796;
import 'package:book_dragon/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart'
    as _i765;
import 'package:book_dragon/features/storage/prefs.dart' as _i843;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i673.AppLogger>(() => _i673.AppLogger());
    gh.singleton<_i193.AppRouter>(() => _i193.AppRouter());
    gh.lazySingleton<_i519.Client>(() => registerModule.provideHttpClient());
    gh.lazySingleton<_i1060.AuthRepository>(
        () => _i874.AuthRepositoryImpl(gh<_i946.AuthRemoteDataSource>()));
    gh.factory<_i214.VerifyOTP>(
        () => _i214.VerifyOTP(repository: gh<_i1060.AuthRepository>()));
    gh.factory<_i522.SendOTP>(
        () => _i522.SendOTP(repository: gh<_i1060.AuthRepository>()));
    gh.lazySingleton<_i843.Prefs>(
        () => _i843.Prefs(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i126.OnBoardingLocalDataSource>(
        () => _i126.OnBoardingLocalDataSrcImpl(gh<_i843.Prefs>()));
    gh.lazySingleton<_i554.OnBoardingRepo>(
        () => _i974.OnBoardingRepoImpl(gh<_i126.OnBoardingLocalDataSource>()));
    gh.factory<_i796.CacheFirstTimer>(
        () => _i796.CacheFirstTimer(gh<_i554.OnBoardingRepo>()));
    gh.factory<_i765.CheckIfUserIsFirstTimer>(
        () => _i765.CheckIfUserIsFirstTimer(gh<_i554.OnBoardingRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i400.RegisterModule {}
