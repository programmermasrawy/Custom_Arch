import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import 'buttons/app_back_button.dart';

class AppScreen extends StatelessWidget {
  const AppScreen(
      {Key? key,
      required this.child,
      this.bottomNavigationBar,
      this.appBar,
      this.title,
      this.lightStatusBar = false,
      // this.transparentStatusBar,
      this.displayActions = false,
      this.actions,
      this.leading,
      this.floatingActionButton,
      // this.lightToolbar = true,
      // this.lightNavigationbar = true,
      this.backgroundColor = AppColors.athensGray,
      this.drawer})
      : super(key: key);

  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final String? title;
  final bool lightStatusBar;
  // final bool? transparentStatusBar;
  final bool displayActions;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  // final bool lightToolbar;
  // final bool lightNavigationbar;
  final Color backgroundColor;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    final uiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: lightStatusBar
          ? Brightness.light
          : Brightness.dark, // For Android (dark icons)
      statusBarBrightness: lightStatusBar
          ? Brightness.dark
          : Brightness.light, // For iOS (dark icons)
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          lightStatusBar ? Brightness.light : Brightness.dark,
    );

    // final uiOverlayStyle = SystemUiOverlayStyle(
    // statusBarColor: Colors.transparent,
    // statusBarIconBrightness:
    //     lightToolbar ? Brightness.light : Brightness.dark,
    // statusBarBrightness: lightToolbar ? Brightness.dark : Brightness.light,
    // systemNavigationBarColor: Colors.transparent,
    // systemNavigationBarDividerColor: Colors.transparent,
    // systemNavigationBarIconBrightness:
    //     lightNavigationbar ? Brightness.light : Brightness.dark,
    // );

    return SafeArea(
      child: AnnotatedRegion(
        value: uiOverlayStyle,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: child,
          appBar: appBar, //?? buildAppBar(context),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
        ),
      ),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    if (actions != null) {
      return actions!;
    }
    // if (displayActions) {
    //   return [
    //     const CartIcon(color: AppColors.black),
    //     if (signedInUser)
    //       IconButton(
    //         onPressed: () =>
    //             Navigator.of(context).pushNamed(NotificationsScreen.id),
    //         icon: SvgPicture.asset(Assets.notification),
    //       ),
    //   ];
    // }
    return [];
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    if (appBar != null) {
      return appBar!;
    }
    if (title != null || lightStatusBar) {
      return getAppbar(
        context,
        title: title,
        leading: leading,
        transparent: lightStatusBar,
        actions: buildActions(context),
      );
    }
    return null;
  }
}

AppBar getAppbar(
  BuildContext context, {
  String? title,
  List<Widget>? actions,
  bool? transparent,
  Widget? leading,
}) {
  return AppBar(
    backgroundColor:
        transparent == null ? AppColors.white : AppColors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: transparent ?? false
          ? Brightness.light
          : Brightness.dark, // For Android (dark icons)
      statusBarBrightness: transparent ?? false
          ? Brightness.dark
          : Brightness.light, // For iOS (dark icons)
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          transparent ?? false ? Brightness.light : Brightness.dark,
    ),

    // SystemUiOverlayStyle.dark.copyWith(
    //   statusBarColor:
    //       transparent == null ? AppColors.white : AppColors.transparent,
    //   statusBarIconBrightness: transparent == null
    //       ? Brightness.light
    //       : Brightness.dark, // For Android (dark icons)
    //   statusBarBrightness: transparent == null
    //       ? Brightness.dark
    //       : Brightness.light, // For iOS (dark icons)
    //   systemStatusBarContrastEnforced: false,
    // ),
    leading:
        leading ?? (Navigator.canPop(context) ? const AppBackButton() : null),
    title: Text(
      title ?? '',
      style: const TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        height: 1.0,
        fontSize: 18.0,
      ),
    ),
    centerTitle: true,
    actions: actions,
    elevation: 0,
  );
}
