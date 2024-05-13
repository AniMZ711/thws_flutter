part of 'themes_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}
