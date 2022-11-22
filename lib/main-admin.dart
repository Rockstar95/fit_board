import 'dart:async';

import 'package:fit_board/backend/app/app_controller.dart';
import 'package:fit_board/utils/my_print.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/myapp.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      AppController().isAdminApp = true;
      runApp(const MyApp());
    },
    (e, s) {
      MyPrint.printOnConsole("Error in runZonedGuarded:$e");
      MyPrint.printOnConsole(s);
    },
  );
}

