part of 'theme_bloc.dart';

@immutable
class ThemeState {
  final ThemeData themeData;
  final ThemeMode themeMode;

  const ThemeState({required this.themeData, required this.themeMode});
}
