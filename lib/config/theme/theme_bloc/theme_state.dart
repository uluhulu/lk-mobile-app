part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
  String get stateName => 'NotificationState';

  Map<String, dynamic> toJson() {
    final state = this;
    if (state is ThemeS) {
      return {
        'theme': state.theme.index,
        'stateName': state.stateName,
      };
    }
    return {
      'stateName': stateName,
    };
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    switch (json['stateName'] as String) {
      case 'ThemeInitial':
        return ThemeInitial();
      case 'ThemeS':
        final numOfMode = json['theme'] as int?;
        final MyThemeMode myTheme =
            MyThemeModeExtension.fromIndex(numOfMode ?? 0);
        return ThemeS(myTheme);
      default:
        return ThemeInitial();
    }
  }
}

class ThemeInitial extends ThemeState {
  @override
  String get stateName => 'ThemeInitial';
}

class ThemeS extends ThemeState {
  final MyThemeMode theme;

  @override
  List<Object> get props => [theme];
  @override
  String get stateName => 'ThemeS';

  const ThemeS(this.theme);
}
