import 'package:fit_board/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';
import '../../utils/my_print.dart';
import 'app_theme_provider.dart';

class AppThemeController {
  final AppThemeProvider appThemeProvider;
  const AppThemeController({required this.appThemeProvider});

  Future<void> init() async {
    bool isDarkThemeEnabled = await getDarkThemeEnabledFromSharedPreferences();

    appThemeProvider.setDarkThemeMode(isDarkThemeEnabled: isDarkThemeEnabled);
    MyPrint.printOnConsole("init themeMode $isDarkThemeEnabled");
  }

  Future<void> updateTheme(bool isDarkThemeEnabled) async {
    MyPrint.printOnConsole("updateTheme called with isDarkThemeEnabled:'$isDarkThemeEnabled'");
    appThemeProvider.setDarkThemeMode(isDarkThemeEnabled: isDarkThemeEnabled);
    setDarkThemeEnabledInSharedPreferences(isEnabled: isDarkThemeEnabled);
  }

  Future<void> setDarkThemeEnabledInSharedPreferences({bool isEnabled = true}) async {
    await SharedPrefManager().setBool(SharedPreferenceVariables.darkThemeModeEnabled, isEnabled);
  }

  Future<bool> getDarkThemeEnabledFromSharedPreferences() async {
    return (await SharedPrefManager().getBool(SharedPreferenceVariables.darkThemeModeEnabled)) ?? true;
  }

}