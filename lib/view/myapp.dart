import 'package:fit_board/backend/app_theme/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/app_theme/app_theme_provider.dart';
import '../backend/board/board_provider.dart';
import '../backend/navigation/navigation_controller.dart';
import '../configs/app_theme.dart';
import 'common/screens/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeProvider>(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider<BoardProvider>(create: (_) => BoardProvider()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (BuildContext context, AppThemeProvider appThemeProvider, Widget? child) {
        if(isFirst) {
          isFirst = false;
          AppThemeController(appThemeProvider: appThemeProvider).init();
        }

        return MaterialApp(
          navigatorKey: NavigationController.mainScreenNavigator,
          debugShowCheckedModeBanner: false,
          /*theme: AppTheme.getThemeFromThemeMode(false),
          darkTheme: AppTheme.getThemeFromThemeMode(true),*/
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: appThemeProvider.darkThemeMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
          onGenerateRoute: NavigationController().getMainGeneratedRoutes,
        );
      },
    );
  }
}
