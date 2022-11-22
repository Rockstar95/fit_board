import 'dart:io';
import 'dart:typed_data';

import 'package:fit_board/backend/app/app_controller.dart';
import 'package:fit_board/backend/app_theme/app_theme_provider.dart';
import 'package:fit_board/backend/board/board_controller.dart';
import 'package:fit_board/backend/board/board_provider.dart';
import 'package:fit_board/utils/my_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../backend/authentication/authentication_controller.dart';
import '../../../backend/navigation/navigation_controller.dart';
import '../../authentication/login_screen.dart';
import '../../home_screen/screens/home_screen.dart';
import '../components/common_bold_text.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late ThemeData themeData;
  bool isFirst = true;

  void startListeners() async {
    NavigationController.isFirst = false;

    BoardProvider provider = Provider.of<BoardProvider>(NavigationController.mainScreenNavigator.currentContext!, listen: false);
    BoardController(boardProvider: provider).startBoardsListening();
    await Future.delayed(const Duration(seconds: 1));

    if(AppController().isAdminApp) {
      bool isUserLoggedIn = await AuthenticationController().isUserLoggedIn();
      MyPrint.printOnConsole("isUserLoggedIn:$isUserLoggedIn");
      if(isUserLoggedIn) {
        Navigator.pop(context);
        NavigationController().navigateToHomeScreen();
      }
      else {
        Navigator.pop(context);
        NavigationController().navigateToLoginScreen();
      }
    }
    else {
      Navigator.pop(context);
      NavigationController().navigateToHomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    if(isFirst) {
      isFirst = false;
      startListeners();
    }

    return Container(
      color: themeData.backgroundColor,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   // border: Border.all(color: Colors.black,width: 2),
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: Image.asset(
                   "images/logo.png",
                   // color: themeData.primaryColor,
                   width: 580,
                   height: 480,
                 ),
             ),
             const SizedBox(height: 18),
             // CommonBoldText(text: "Hospital Management \n System",fontSize: 20,textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }

}
