part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangeE extends ThemeEvent {
  final MyThemeMode theme;

  const ThemeChangeE(this.theme);

  @override
  List<Object> get props => [theme];
}
