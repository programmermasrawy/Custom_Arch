import 'dart:io';

import 'package:dio/dio.dart';

import '../services/crashlytics.dart';
import 'api_manager.dart';

class FailureHandler {
  FailureHandler();

  final StatusChecker _statusChecker = StatusChecker();

  Failure handle({
    Request? request,
    dynamic exception,
    Response? response,
  }) {
    final failureInfo = FailureInfo(
      request: request,
      exception: exception,
      response: response,
    );
    Failure? failure;
    if (exception is ErrorException) {
      failure = ErrorFailure(
        errorStatus: _statusChecker.getErrorState(exception.statusCode),
        error: exception.error,
      );
    } else if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectionError:
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.badCertificate:
        case DioErrorType.receiveTimeout:
          failure = ConnectionFailure();
          break;
        case DioErrorType.cancel:
          failure = RequestCanceledFailure();
          break;
        case DioErrorType.badResponse:
        case DioErrorType.unknown:
          {
            final socketException = exception.message?.contains('SocketException');
            final getRequest = request?.method == 'GET';
            final httpException =
                exception.message!.contains('HttpException') || exception.message!.contains('Connection');

            if (socketException! || (httpException && getRequest)) {
              failure = ConnectionFailure();
            }
            failure = UnkownFailure(failureInfo);
          }
      }
    } else if (exception is ServerException) {
      final status = _statusChecker(exception.response?.statusCode);
      switch (status) {
        case HTTPCodes.invalidToken:
          failure = SessionEndedFailure();
          break;
        case HTTPCodes.serviceNotAvailable:
          failure = ServiceNotAvailableFailure(failureInfo);
          break;
        case HTTPCodes.unknown:
          failure = UnkownFailure(failureInfo);
          break;
        default:
          break;
      }
    } else if (exception is SocketException) {
      failure = ConnectionFailure();
    } else if (exception is FormatException) {
      failure = ServiceNotAvailableFailure(failureInfo);
    } else if (exception is ValidationException) {
      failure = ValidationFailure(exception.value, exception.value);
    } else if (exception is TypeError) {
      failure = TypeFailure(failureInfo);
    }
    if (failure is ReportableFailure) {
      Crashlytics.instance.recordError(failure);
    }
    return failure ?? UnkownFailure(failureInfo);
  }
}
