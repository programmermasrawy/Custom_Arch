import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../data/request/base_request.dart';

part 'preferences_state.dart';

class PreferencesCubit extends HydratedCubit<PreferencesState> {
  PreferencesCubit() : super(PreferencesState()) {
    BaseRequestDefaults.instance
        .setLanguage(state.language == 'ar' ? 'ar-eg' : 'en-us');
    _currentLanguage =
        state.language == 'ar' ? Language.arabic : Language.english;
  }

  void setLanguage(String code) {
    final language = AppLocalizations.supportedLocales
                .indexWhere((element) => element.languageCode == code) ==
            -1
        ? 'en'
        : code;
    BaseRequestDefaults.instance
        .setLanguage(language == 'ar' ? 'ar-eg' : 'en-us');

    emit(state.copyWith(language: language));
  }

  void clearUserData() {
    emit(PreferencesState());
  }

  void toggleLanguage() {
    setLanguage(state.language == 'ar' ? 'en' : 'ar');
  }

  void toggleTheme() {
    emit(state.copyWith(darkTheme: !state.darkTheme));
  }

  @override
  PreferencesState? fromJson(Map<String, dynamic> json) =>
      PreferencesState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(PreferencesState state) => state.toMap();
}
