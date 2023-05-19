import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';

class Loader {
  Loader._();

  late BuildContext _context;
  late BuildContext _dismissingContext;
  Completer waitForLoader = Completer()..complete();

  static Loader _instance = Loader._();

  static Loader get instance => _instance;

  static void newInstance() => _instance = Loader._();

  void hide() {
    if (!waitForLoader.isCompleted) {
      try {
        if (Navigator.of(_dismissingContext).canPop()) {
          Navigator.of(_dismissingContext).pop(true);
        }
      } catch (_) {}
    }
  }

  void show(BuildContext context) {
    _context = context;
    if (waitForLoader.isCompleted) {
      waitForLoader = Completer();
      showDialog<dynamic>(
        context: _context,
        barrierDismissible: kDebugMode,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () async => false,
            child: const LoadingImage(),
          );
        },
      );
    }
  }
}

class LoadingImage extends StatefulWidget {
  const LoadingImage({Key? key}) : super(key: key);

  @override
  State<LoadingImage> createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        size: 75,
        color: AppColors.primary,
      ),
    );
  }

  @override
  void dispose() {
    if (!Loader.instance.waitForLoader.isCompleted) {
      Loader.instance.waitForLoader.complete();
    }
    super.dispose();
  }
}
