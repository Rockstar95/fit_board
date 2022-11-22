import 'dart:io';

import 'package:fit_board/utils/my_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'my_print.dart';

class MyUtils {
  static Future<void> openMap(double latitude,double longitude) async {
    String url = !kIsWeb && Platform.isIOS
        ? "https://maps.apple.com/?q=$latitude,$longitude"
        : 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if(await url_launcher.canLaunchUrl(Uri.parse(url))) {
      //await url_launcher.launchUrl(Uri.parse(url));
      await url_launcher.launch(url);
    }
    else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> launchMobileNumber(String mobile) async {
    if (await url_launcher.canLaunchUrl(Uri.parse("tel://$mobile"))) {
      // await url_launcher.launchUrl(Uri.parse("tel://$mobile"));
      await url_launcher.launch("tel://$mobile");
    }
    else {
      throw 'Could not launch $mobile';
    }
  }

  static Future<void> launchEmail(String email) async {
    if (await url_launcher.canLaunchUrl(Uri.parse("mailto://$email"))) {
      // await url_launcher.launchUrl(Uri.parse("tel://$mobile"));
      await url_launcher.launch("mailto:$email");
    }
    else {
      throw 'Could not launch $email';
    }
  }

  static Future<void> launchUrl(String url, {bool isAppendHttps = false}) async {
    MyPrint.printOnConsole("launchUrl called with:$url");
    if(!url.startsWith("https://") && !url.startsWith("http://") && isAppendHttps) {
      url = "https://$url";
    }

    if (await url_launcher.canLaunch((url))) {
      await url_launcher.launch(("$url"));
    }
    else {
      MyPrint.printOnConsole("Failed To Launch URL:'$url'");
    }
  }

  static Future<void> copyToClipboard(BuildContext? context, String string) async {
    if(string.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: string));
      if(context != null) {
        MyToast.showSuccess(context: context, msg: "Copied");
      }
    }
  }
}