import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // // bloc
    // // to refactor bloc
    // sl.registerFactory(() => MoviesBloc(sl(),sl(),sl()));
    // sl.registerFactory(() => MovieDetailsBloc(sl(),sl()));
    // // use cases
    // sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
    // sl.registerLazySingleton(() => GetPupulareMoviesUseCase(sl()));
    // sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    // sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
    // sl.registerLazySingleton(() => GetRecommendationUsecase(sl()));
    // // Repository
    // sl.registerLazySingleton<BaseMovieRepository>(() => MoviesReository(sl()));
    // // data source
    // sl.registerLazySingleton<BaseMovieRemoteDataSource>(
    //     () => MovieRemoteDataSource());
  }
}
