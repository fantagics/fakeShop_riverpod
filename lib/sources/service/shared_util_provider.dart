import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/constants.dart';
import '../model/login_type.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  void setAuthInfo(String token, LoginType loginType){
    sharedPreferences.setString(sharedUserToken, token);
    sharedPreferences.setString(sharedLoginType, loginType.str);
  }
  void removeAuthInfo(){
    sharedPreferences.remove(sharedUserToken);
    sharedPreferences.remove(sharedLoginType);
  }
  String? getUserToken(){
    return sharedPreferences.getString(sharedUserToken);
  }
  LoginType getLoginType(){
    return LoginType.getByString(sharedPreferences.getString(sharedLoginType) ?? 'none');
  }

}
