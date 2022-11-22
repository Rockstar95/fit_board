import 'package:fit_board/backend/authentication/authentication_controller.dart';
import 'package:fit_board/utils/my_toast.dart';
import 'package:fit_board/view/home_screen/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../configs/app_theme.dart';
import '../common/components/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ThemeData themeData;

  bool isFirst = true, isLoading = false;

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    if(isFirst) {
      isFirst = false;
      // AppUpdateController().checkAppVersion(context);
    }

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: Container(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeData.backgroundColor.withOpacity(0.9),
              border: Border.all(color: themeData.backgroundColor)
            ),
            child: SpinKitFadingCircle(color: themeData.colorScheme.primary,),
          ),
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            // color: Colors.blue,
            padding: const EdgeInsets.only(top: 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  getLogo(),
                  getLoginText(),
                  getLoginText2(),
                  getUserNameTextField(),
                  getPasswordTextField(),
                  getContinueButton(),
                  //getTermsAndConditionsLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 34),
      width: 300,
      height: 100,
      child: Image.asset("assets/images/logo.png"),
    );
  }

  Widget getLoginText() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: Text(
          "Log In",
          style: AppTheme.getTextStyle(
              themeData.textTheme.headline5!,
              fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget getLoginText2() {
    return Container(
      margin: const EdgeInsets.only(left: 48, right: 48, top: 40),
      child: Text(
        "Enter your login details to access your account",
        softWrap: true,
        style: AppTheme.getTextStyle(
            themeData.textTheme.bodyText1!,
            fontWeight: FontWeight.w500,
            height: 1.2,
            color: themeData.colorScheme.onBackground
                .withAlpha(200)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getUserNameTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
      child: TextFormField(
        controller: userNameController,
        style: AppTheme.getTextStyle(
            themeData.textTheme.bodyText1!,
            letterSpacing: 0.1,
            color: themeData.colorScheme.onBackground,
            fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Username",
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0),),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          // filled: true,
          // fillColor: themeData.colorScheme.background,
          // isDense: true,
          contentPadding: const EdgeInsets.all(10),
        ),
        keyboardType: TextInputType.name,
        autofocus: false,
        validator: (val) {
          if(val?.trim().isEmpty ?? true) {
            return "Username Cannot be empty";
          }
          else {
            return null;
          }
        },
      ),
    );
  }

  Widget getPasswordTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
      child: TextFormField(
        controller: passwordController,
        style: AppTheme.getTextStyle(
            themeData.textTheme.bodyText1!,
            letterSpacing: 0.1,
            color: themeData.colorScheme.onBackground,
            fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Password",
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0),),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(color: themeData.colorScheme.onBackground),
          ),
          // filled: true,
          // fillColor: themeData.colorScheme.background,
          // isDense: true,
          contentPadding: const EdgeInsets.all(10),
        ),
        keyboardType: TextInputType.visiblePassword,
        autofocus: false,
        validator: (val) {
          if(val?.trim().isEmpty ?? true) {
            return "Password Cannot be empty";
          }
          else {
            return null;
          }
        },
      ),
    );
  }

  Widget getTermsAndConditionsLink() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Center(
          child: Text(
            "Terms and Conditions",
            style: AppTheme.getTextStyle(
                themeData.textTheme.bodyText2!,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Widget getContinueButton() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
      decoration: const BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(48)),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: themeData.colorScheme.primary,
        highlightColor: themeData.colorScheme.primary,
        splashColor: Colors.white.withAlpha(100),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        onPressed: () {
          if(_formKey.currentState?.validate() ?? false) {
            String userName = userNameController.text.trim();
            String password = passwordController.text.trim();

            if(userName == "meet" && password == 'admin123') {
              AuthenticationController().setIsUserLoggedInInSharedPreferences(isLoggedIn: true);
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
            }
            else {
              MyToast.showError(context: context, msg: "Wrong username and password");
            }
          }
        },
        child: Stack(
          //overflow: Overflow.visible,
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "CONTINUE",
                style: AppTheme.getTextStyle(
                    themeData.textTheme.bodyText2!,
                    color: themeData.colorScheme.onPrimary,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: ClipOval(
                child: Container(
                  color: themeData.colorScheme.primary,
                  // button color
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.arrow_forward,
                        color: themeData.colorScheme.onPrimary,
                        size: 18,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
