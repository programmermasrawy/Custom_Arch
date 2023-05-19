import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api_manager.dart';
import '../view/widgets/no_connection.dart';
import 'loader.dart';

class GenericErrorHandler {
  GenericErrorHandler._();

  bool isShowing = false;

  static GenericErrorHandler _instance = GenericErrorHandler._();

  @visibleForTesting
  // ignore: prefer_constructors_over_static_methods
  static GenericErrorHandler newInstance() =>
      _instance = GenericErrorHandler._();

  static GenericErrorHandler get instance => _instance;

  Future<void> handle<T extends Bloc>({
    required BuildContext context,
    required Failure failure,
    dynamic event,
    Function? onRetry,
    bool dismissible = true,
  }) async {
    assert((onRetry == null) ^ (event == null),
        'Must provide either onRetry or an event');
    await Loader.instance.waitForLoader.future;
    var retriable = false;
    FocusScope.of(context).unfocus();
    if (failure is ConnectionFailure) retriable = true;
    if (isShowing) return;
    isShowing = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final retry = await showDialog(
              context: context,
              barrierDismissible:
                  failure is SessionEndedFailure ? false : dismissible,
              builder: (context) => NoConnection(
                dismissible: dismissible,
                retriable: retriable,
                failure: failure,
              ),
            ) ??
            false;
        isShowing = false;
        if (retry) {
          if (onRetry == null) {
            context.read<T>().add(event);
          } else {
            onRetry();
          }
        }
      },
    );
  }
}
