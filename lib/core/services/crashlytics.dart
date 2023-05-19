import '../data/api_manager.dart';

class Crashlytics {
  Crashlytics._();

  static final _instance = Crashlytics._();
  static Crashlytics get instance => _instance;

  Future<void> recordError(ReportableFailure? failure) async {
    if (failure == null) return;
    final request = failure.failureInfo.request;
    final response = failure.failureInfo.response;
    final exception = failure.failureInfo.exception;
    final type = failure.type;

    // if (Firebase.apps.isNotEmpty) {
    //   final userId = currentUser?.id;
    //   if (userId != null) {
    //     FirebaseCrashlytics.instance.setUserIdentifier(userId.toString());
    //   }
    //   //? Request
    //   if (request != null) {
    //     FirebaseCrashlytics.instance.setCustomKey('URL', request.url);
    //     FirebaseCrashlytics.instance.setCustomKey('Method', request.method);
    //     FirebaseCrashlytics.instance.setCustomKey(
    //         'Query Parameters', '${await request.queryParameters}');
    //     FirebaseCrashlytics.instance
    //         .setCustomKey('Request data', '${await request.data}');
    //     if (response?.requestOptions == null) {
    //       FirebaseCrashlytics.instance
    //           .setCustomKey('Request Headers', '${request.headers}');
    //       FirebaseCrashlytics.instance
    //           .setCustomKey('CURL', await request2curl(request) ?? '');
    //     }
    //   }
    //   //? Reponse
    //   if (response != null) {
    //     FirebaseCrashlytics.instance.setCustomKey(
    //         'Request Headers', '${response.requestOptions.headers}');
    //     FirebaseCrashlytics.instance
    //         .setCustomKey('CURL', dio2curl(response.requestOptions) ?? '');
    //     FirebaseCrashlytics.instance
    //         .setCustomKey('Response', '${response.data}');
    //     FirebaseCrashlytics.instance.log('${response.data}');
    //     Analytics.instance.logFailedRequest(
    //       type: type,
    //       statusCode: response.statusCode.toString(),
    //       timeStamp: failure.id,
    //       url: response.requestOptions.uri.toString(),
    //     );
    //   }
    //   FirebaseCrashlytics.instance.setCustomKey('Type', type);
    //   FirebaseCrashlytics.instance.setCustomKey(failure.id, 'FailureId');
    //   FirebaseCrashlytics.instance.recordError(
    //     exception,
    //     StackTrace.current,
    //     printDetails: AppFlavor.appFlavor == Flavors.development,
    //   );
    // }
  }

  Future<void> recordTypeError(TypeFailure? failure) async {
    if (failure == null) return;
    // FirebaseCrashlytics.instance.setCustomKey('Response', '${failure.data}');
    // FirebaseCrashlytics.instance.log('${failure.data}');
    // FirebaseCrashlytics.instance.setCustomKey('Type', 'Product Fialure');
    // FirebaseCrashlytics.instance.setCustomKey(failure.id, 'FailureId');
    // FirebaseCrashlytics.instance.recordError(
    //   failure.failureInfo.exception,
    //   StackTrace.current,
    //   printDetails: AppFlavor.appFlavor == Flavors.development,
    // );
  }
}
