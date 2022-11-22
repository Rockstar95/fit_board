
import 'package:fit_board/view/authentication/login_screen.dart';
import 'package:fit_board/view/common/screens/splashscreen.dart';
import 'package:fit_board/view/home_screen/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/my_print.dart';

//To Provider Navigation Throught the app
class NavigationController {
  static final GlobalKey<NavigatorState> mainScreenNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldState> homeScreenNavigator = GlobalKey<ScaffoldState>();

  static bool isFirst = true;

  static bool checkDataAndNavigateToSplashScreen() {
    MyPrint.printOnConsole("checkDataAndNavigateToSplashScreen called, isFirst:$isFirst");

    if(isFirst) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        isFirst = false;
        Navigator.pushNamedAndRemoveUntil(mainScreenNavigator.currentContext!, SplashScreen.routeName, (route) => false);
      });
    }

    return isFirst;
  }

  Route? getMainGeneratedRoutes(RouteSettings settings) {
    MyPrint.printOnConsole("Main Generated Routes Called For:${settings.name} with argument:${settings.arguments}");

    if(kIsWeb) {
      if(!["/", SplashScreen.routeName].contains(settings.name) && NavigationController.checkDataAndNavigateToSplashScreen()) {
        return null;
      }
    }

    Widget? widget;

    switch(settings.name) {
      case SplashScreen.routeName: {
        widget = const SplashScreen();
        break;
      }
      case LoginScreen.routeName: {
        widget = const LoginScreen();
        break;
      }
      case HomeScreen.routeName: {
        widget = const HomeScreen();
        break;
      }
    }

    if(widget != null) {
      return MaterialPageRoute(builder: (_) => widget!);
    }

    return null;
  }

  //region Navigation Methods
  Future<void> navigateToSplashScreen({BuildContext? context}) async {
    MyPrint.printOnConsole("navigateToSplashScreen called");

    Navigator.pushNamed(
      context ?? NavigationController.mainScreenNavigator.currentContext!,
      SplashScreen.routeName,
    );
  }

  Future<void> navigateToLoginScreen({BuildContext? context}) async {
    MyPrint.printOnConsole("navigateToLoginScreen called");

    Navigator.pushNamed(
      context ?? NavigationController.mainScreenNavigator.currentContext!,
      LoginScreen.routeName,
    );
  }

  Future<void> navigateToHomeScreen({BuildContext? context}) async {
    MyPrint.printOnConsole("navigateToHomeScreen called");

    Navigator.pushNamed(
      context ?? NavigationController.mainScreenNavigator.currentContext!,
      HomeScreen.routeName,
    );
  }
  //endregion

  void changeStatusBarTheme(SystemUiOverlayStyle style, {String? printMessage}) {
    SystemChrome.setSystemUIOverlayStyle(style);
    if(printMessage != null) MyPrint.printOnConsole(printMessage);
  }

  static void resetAllNavigatorKeys() {
    homeScreenNavigator = GlobalKey<ScaffoldState>();
  }
}