part of 'preferences_cubit.dart';

bool get ltr => _currentLanguage == Language.english;
bool get rtl => _currentLanguage == Language.arabic;

String get languageCode => ltr ? 'en-us' : 'ar-eg';
String get languageName => ltr ? 'en' : 'ar';

Language? _currentLanguage;
Language? get currentLanguage => _currentLanguage;

@immutable
class PreferencesState extends Equatable {
  PreferencesState({
    this.language,
    this.darkTheme = false,
  }) {
    _currentLanguage = language == 'ar' ? Language.arabic : Language.english;
  }

  factory PreferencesState.fromMap(Map<String, dynamic> map) {
    final language = map['language'] as String?;
    _currentLanguage = language == 'ar' ? Language.arabic : Language.english;

    return PreferencesState(
      language: language,
      darkTheme: map['darkTheme'] as bool,
    );
  }

  final String? language;
  final bool darkTheme;

  PreferencesState copyWith({
    String? language,
    bool? darkTheme,
  }) {
    return PreferencesState(
      language: language ?? this.language,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'darkTheme': darkTheme,
    };
  }

  @override
  List<Object?> get props => [
        language,
        darkTheme,
      ];
}

enum Language { english, arabic }
