import 'package:bloc/bloc.dart';
import 'package:themes/app_themes.dart';
import 'package:flutter/material.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: AppThemes.lightTheme, themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) {
      if (state.themeMode == ThemeMode.light) {
        emit(ThemeState(
            themeData: AppThemes.darkTheme, themeMode: ThemeMode.dark));
      } else {
        emit(ThemeState(
            themeData: AppThemes.lightTheme, themeMode: ThemeMode.light));
      }
    });
  }
}
