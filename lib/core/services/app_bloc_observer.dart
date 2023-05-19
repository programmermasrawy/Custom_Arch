import 'package:bloc/bloc.dart';

import 'app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.instance.log(
      'onChange(${bloc.runtimeType}, $change)',
      logLevel: LogLevel.debug,
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.instance.log(
      'onError(${bloc.runtimeType}, $error, $stackTrace)',
      logLevel: LogLevel.error,
    );
    super.onError(bloc, error, stackTrace);
  }
}
