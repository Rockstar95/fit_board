import '../../configs/constants.dart';
import '../../utils/shared_pref_manager.dart';

class AuthenticationController {
  Future<bool> isUserLoggedIn() async {
    bool isLoggedIn = await getIsUserLoggedInFromSharedPreferences();

    return isLoggedIn;
  }

  Future<void> setIsUserLoggedInInSharedPreferences({bool isLoggedIn = false}) async {
    await SharedPrefManager().setBool(SharedPreferenceVariables.isUserLoggedIn, isLoggedIn);
  }

  Future<bool> getIsUserLoggedInFromSharedPreferences() async {
    return (await SharedPrefManager().getBool(SharedPreferenceVariables.isUserLoggedIn)) ?? true;
  }
}