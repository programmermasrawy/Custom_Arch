import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../constants/app_colors.dart';
import '../utils/utils.dart';
import 'loader.dart';

class Alert {
  Alert._();

  Flushbar? current;

  static Alert _instance = Alert._();

  static Alert get instance => _instance;

  static void newInstance() => _instance = Alert._();

  void error(
    BuildContext context,
    String? message, {
    bool isNavigating = true,
  }) {
    if (isNavigating) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showError(context, message));
    } else {
      _showError(context, message);
    }
  }

  Future<void> _showError(BuildContext context, String? message) async {
    await Loader.instance.waitForLoader.future;
    await current?.dismiss();
    current = Flushbar(
      title: context.l10n.error,
      message:
          isNullOrEmpty(message) ? context.l10n.some_thing_went_wrong : message,
      backgroundColor: AppColors.cherryRed,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: kDebugMode ? 3 : 3),
      animationDuration: const Duration(milliseconds: 500),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) current = null;
      },
    )..show(context);
  }

  void success(BuildContext context, String? message,
      {bool isNavigating = true}) {
    if (isNavigating) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showSuccess(context, message));
    } else {
      _showSuccess(context, message);
    }
  }

  Future<void> _showSuccess(BuildContext context, String? message) async {
    await Loader.instance.waitForLoader.future;
    await current?.dismiss();
    current = Flushbar(
      title: context.l10n.success,
      message: isNullOrEmpty(message) ? ' ' : message,
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: kDebugMode ? 1 : 3),
      animationDuration: const Duration(milliseconds: 500),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) current = null;
      },
    )..show(context);
  }

  Future<void> showNotification(
    BuildContext context,
    String? title,
    String? body,
    VoidCallback? onTap,
  ) async {
    await Loader.instance.waitForLoader.future;
    await current?.dismiss();
    current = Flushbar(
      title: title,
      message: isNullOrEmpty(body) ? ' ' : body,
      backgroundColor: AppColors.white,
      titleColor: AppColors.cloudBurst,
      messageColor: AppColors.cloudBurst,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) current = null;
      },
      // icon: SvgPicture.asset(Assets.logo),
      onTap: (_) => onTap?.call(),
    )..show(context);
  }
}
