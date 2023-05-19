
import '../utils/utils.dart';

class Analytics {
  Analytics._();

  static final _instance = Analytics._();
  static Analytics get instance => _instance;

  // final _firebaseAnalytics = testMode ? null : FirebaseAnalytics.instance;

  void logScreen({String? screenName, dynamic argments}) {
    if (screenName == null) return;
    //?Firebase Analytics
    // _firebaseAnalytics?.logScreenView(screenName: screenName);

    // //CartScreen
    // if (screenName == CartScreen.id) {
    //   //?Firebase Analytics
    //   _firebaseAnalytics?.logViewCart();
    // } else if (screenName == ProductDetailsScreen.id && argments is Product) {
    //   //?Firebase Analytics
    //   logViewItem(product: argments);
    // }
  }

  // void logSucceededReqeustOTP({
  //   required int numberOfAccounts,
  // }) {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'succeeded_request_otp',
  //     parameters: {
  //       'number_of_accounts': numberOfAccounts,
  //     },
  //   );
  // }

  // void logRequestOTP() {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'request_otp',
  //   );
  // }

  // void logResendOTP() {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'resend_otp',
  //   );
  // }

  // void logLogin({required String method}) {
  //   _firebaseAnalytics?.logLogin(
  //     loginMethod: method,
  //   );
  // }

  // void logVerifyOTP() {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'verify_otp',
  //   );
  // }

  // void logSignUp() {
  //   _firebaseAnalytics?.logSignUp(
  //     signUpMethod: 'OTP',
  //   );
  // }

  // void logSigupWithReferral(String code) {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'referral_signup',
  //     parameters: {
  //       'code': code,
  //     },
  //   );
  // }

  // void logShowLoginDialog({
  //   required String source,
  // }) {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'show_login_dialog',
  //     parameters: {
  //       'source': source,
  //     },
  //   );
  // }

  // void logEnterOTP() {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'enter_otp',
  //   );
  // }

  // Future<void> resetAnalyticsData() async {
  //   await _firebaseAnalytics?.resetAnalyticsData();
  // }

  // void logStartShopping() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'start_shopping',
  //   );
  // }

  // void logLoginFromWalkThrough() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'login_from_walk_through',
  //   );
  // }

  // //* Cart
  // void logAddToCart(
  //     // {
  //     // required Product product,
  //     // required int quantity,
  //     // }
  //     ) {
  //   //?Firebase Analytics
  //   // _firebaseAnalytics?.logAddToCart(
  //   //   items: [
  //   //     productToAnalyticsEventItem(product: product, quantity: quantity),
  //   //   ],
  //   //   currency: 'EGP',
  //   //   value: product.price.toDouble(),
  //   // );
  // }

  // void logRemoveFromCart(
  //     //   {
  //     //   required Product product,
  //     //   int? quantity,
  //     // }
  //     ) {
  //   //?Firebase Analytics
  //   // _firebaseAnalytics?.logRemoveFromCart(
  //   //   items: [
  //   //     productToAnalyticsEventItem(product: product, quantity: quantity),
  //   //   ],
  //   //   currency: 'EGP',
  //   //   value: product.price.toDouble() * (quantity ?? 1),
  //   // );
  // }

  // void logNotifyMe(
  //     //   {
  //     //   required Product? product,
  //     // }
  //     ) {
  //   // if (product == null) return;
  //   // _firebaseAnalytics?.logEvent(
  //   //   name: 'notify_me',
  //   //   parameters: product.toAnalyticsMap(),
  //   // );
  // }

  // void logDiabledLocation() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'disabled_location',
  //   );
  // }

  // void logLocationPermissionDenied() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'location_permission_denied',
  //   );
  // }

  // void logOpenSettings() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'open_settings',
  //   );
  // }

  // void logProceedAnyway() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'proceed_anyway',
  //   );
  // }

  // void logDetermineLocation() {
  //   _firebaseAnalytics?.logEvent(
  //     name: 'determine_location',
  //   );
  // }

  // void logSkipLogin() {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(name: 'skip_login');
  // }

  // void logComingSoon({
  //   required String feature,
  // }) {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'coming_soon',
  //     parameters: {
  //       'feature': feature,
  //     },
  //   );
  // }

  // void logFailedRequest({
  //   required String type,
  //   required String timeStamp,
  //   required String statusCode,
  //   required String url,
  // }) {
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'failed_request',
  //     parameters: {
  //       'type': type,
  //       'statusCode': statusCode,
  //       'timeStamp': timeStamp,
  //       'url': url,
  //     },
  //   );
  // }

  // void logErrorMessageShown({
  //   required String? message,
  // }) {
  //   if (testMode || isNullOrEmpty(message)) return;
  //   //?Firebase Analytics
  //   _firebaseAnalytics?.logEvent(
  //     name: 'error_message_shown',
  //     parameters: {
  //       'message': message,
  //     },
  //   );
  // }
}
