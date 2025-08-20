import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_posts/core/internet_checker/network_info.dart';
import 'package:flutter_posts/features/posts/data/datasource/post_local_data_source.dart';
import 'package:flutter_posts/features/posts/data/datasource/post_remote_data_source.dart';
import 'package:flutter_posts/features/posts/data/repository/post_repository_impl.dart';
import 'package:flutter_posts/features/posts/domain/usecase/delete_post.dart';
import 'package:flutter_posts/features/posts/domain/usecase/get_all_posts.dart';
import 'package:flutter_posts/features/posts/domain/usecase/update_post.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/posts/domain/usecase/add_post.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initCoreModule();
  initExternalDependenciesModule();
  initPostsBlocModule();
}

initCoreModule() {
  GetIt.I.registerLazySingleton(() => NetworkInfoImpl(sl()));
}

initExternalDependenciesModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

initPostsBlocModule() {
  // Bloc
  GetIt.I.registerLazySingleton(() => PostsBloc(GetAllPostsUseCase(sl())));
  GetIt.I.registerLazySingleton(
    () => AddUpdateDeletePostBloc(sl(), sl(), sl()),
  );

  // Usecases
  GetIt.I.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  GetIt.I.registerLazySingleton(() => AddPostUseCase(sl()));
  GetIt.I.registerLazySingleton(() => DeletePostUseCase(sl()));
  GetIt.I.registerLazySingleton(() => UpdatePostUseCase(sl()));

  // Repository
  GetIt.I.registerLazySingleton(() => PostRepositoryImpl(sl(), sl(), sl()));

  // Datasource
  GetIt.I.registerLazySingleton(() => PostRemoteDataSourceImpl(sl()));
  GetIt.I.registerLazySingleton(() => PostLocalDataSourceImpl(sl()));
}
