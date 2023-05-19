import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/api_manager.dart';
import '../logic/preferences_cubit/preferences_cubit.dart';

class CoreDI {
  CoreDI(this.di) {
    call();
  }

  final GetIt di;

  void call() {
    final List<Interceptor> interceptors = [];
    // if (AppLogger.instance.aliceInterceptor != null) {
    //   interceptors.add(AppLogger.instance.aliceInterceptor!);
    // }
    di
      ..registerLazySingleton(
        () => APIsManager(
          interceptors: interceptors,
        ),
      )
      ..registerLazySingleton(() => PreferencesCubit());
  }
}
