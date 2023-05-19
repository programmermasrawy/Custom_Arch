import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import '../app_router.dart';
import '../di/injection_container.dart';
import '../l10n/l10n.dart';
import 'constants/app_theme.dart';
import 'data/request/base_request.dart';
import 'logic/preferences_cubit/preferences_cubit.dart';
import 'services/alert.dart';
import 'services/app_locale.dart';
import 'services/app_logger.dart';
import 'services/remote_config.dart';
import 'view/screens/splash.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key, this.home}) : super(key: key);
  final Widget? home;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di<PreferencesCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => di<HomeCubit>(),
        // ),
        // BlocProvider(
        //   create: (context) => di<ConstantsCubit>(),
        // ),
        // BlocProvider(
        //   create: (context) => di<CategoriesCubit>(),
        // ),
        // BlocProvider(
        //   create: (context) => di<HomeCubit>(),
        // ),

        // BlocProvider(
        //   create: (context) => di<ProfileCubit>(),
        // ),
        // BlocProvider(
        //   create: (context) => SearchHistoryCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => di<NotificationsCubit>(),
        // ),
      ],
      child: App(home: home),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key, this.home}) : super(key: key);

  final Widget? home;

  @override
  _AppState createState() => _AppState();

  static Future<void> rebirth(BuildContext context) async {
    context.findAncestorStateOfType<_AppState>()?.restart();
  }
}

class _AppState extends State<App> {
  Key _key = UniqueKey();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // context.read<UserCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PreferencesCubit, PreferencesState>(
          listenWhen: (previous, current) =>
              previous.language != null &&
              previous.language != current.language,
          listener: (context, state) => restart(),
        ),
        // BlocListener<UserCubit, UserState>(
        //   listenWhen: (previous, current) =>
        //       previous.token != null && current.token == null,
        //   listener: (context, state) => restart(),
        // ),
      ],
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, widget) => MaterialApp(
              debugShowCheckedModeBanner: false,
              key: _key,
              builder: builder,
              title: 'AppFlavor.title',
              theme: state.darkTheme
                  ? AppTheme.dark.copyWith(
                      // textTheme: GoogleFonts.cairoTextTheme(
                      //   Theme.of(context).textTheme,
                      // ),
                      )
                  : AppTheme.light.copyWith(
                      // textTheme: GoogleFonts.cairoTextTheme(
                      //   Theme.of(context).textTheme,
                      // ),
                      ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              localeResolutionCallback: (locale, supportedLocales) =>
                  AppLocale.setAppLocale(
                      locale, supportedLocales, context, state.language),
              onGenerateRoute: AppRouter.onGenerateRoute,
              // navigatorKey: AppLogger.instance.navigatorKey,
              home: widget,
            ),
            child: _Home(home: widget.home),
          );
        },
      ),
    );
  }

  Widget builder(BuildContext context, Widget? widget) {
    if (widget == null) return Container();
    // ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    //   return CustomError(errorDetails: errorDetails);
    // };
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget,
    );
  }

  void restart() {
    setState(() {
      Alert.newInstance();
      AppLogger.newInstance();
      _key = UniqueKey();
    });
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key, this.home}) : super(key: key);

  final Widget? home;

  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  final deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = languageCode;
    Intl.systemLocale = languageCode;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // log(AppFlavor.title);
    // log(AppFlavor.baseUrl);
    // BaseRequestDefaults.instance.setBaseUrl(AppFlavor.baseUrl);
    FirebaseRemoteConfig.instance.setupRemoteConfig(context);

    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
      if (Platform.isAndroid) {
        BaseRequestDefaults.instance.addHeader('operating_system', 'android');
        _setSSID();
      } else if (Platform.isIOS) {
        BaseRequestDefaults.instance.addHeader('operating_system', 'ios');
        deviceInfo.iosInfo.then((IosDeviceInfo? iosDeviceInfo) {
          BaseRequestDefaults.instance.addHeader('ssid', iosDeviceInfo?.identifierForVendor ?? "");
        });
      }
    }

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String version = packageInfo.buildNumber;
      BaseRequestDefaults.instance.addHeader('appname', appName);

      // BaseRequestDefaults.instance.addHeader('version', "version");
      // BaseRequestDefaults.instance.addHeader('version', "50");
      BaseRequestDefaults.instance.addHeader('version', version);
    });

    context.read<PreferencesCubit>().setLanguage("ar");

    // localizations.addAll(AppLocalizations.localizationsDelegates);

    WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
        // await requestNotificationPermession(context: context);

        // FirebaseDynamicLinksService().handleDynamicLink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.home ?? const Splash();
  }
  void _setSSID() async {
    const androidIdPlugin = AndroidId();

    String? ssid = await androidIdPlugin.getId();
    BaseRequestDefaults.instance.addHeader('ssid', "$ssid");
  }
}
