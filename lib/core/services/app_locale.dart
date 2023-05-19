import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/preferences_cubit/preferences_cubit.dart';

class AppLocale {
  static Locale setAppLocale(Locale? locale, Iterable<Locale> supportedLocales,
      BuildContext context, String? currentLanguage) {
    if (currentLanguage != null) {
      for (var supportedLocale in supportedLocales) {

        var code = supportedLocale.countryCode ?? "EG";
        if(code.isEmpty) {
          code = "EG";
        }
        
        if (supportedLocale.languageCode == currentLanguage||
            supportedLocale.countryCode == locale?.countryCode){
          supportedLocale = Locale(supportedLocale.languageCode,code);
          return supportedLocale;
        }
      }
    }

    if (locale != null) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode||
            supportedLocale.countryCode == locale.countryCode){
          context
              .read<PreferencesCubit>()
              .setLanguage(supportedLocale.languageCode);
          return supportedLocale;
        }
      }
    }
    return supportedLocales.first;
  }
}
