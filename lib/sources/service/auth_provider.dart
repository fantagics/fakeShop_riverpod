import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_type.dart';
import './shared_util_provider.dart';
import '../shared/common.dart';


// final userTokenProvider = StateProvider<String?>((ref)=> null);
// final loginTypeProvider = StateProvider<LoginType>((ref)=> LoginType.none);
final termsAgreementPorvider = StateProvider<bool>((ref) => false);
final authLoading = StateProvider<bool>((ref) => false);

final isLoginedProvider = StateNotifierProvider<IsLoginedNotifier, bool>((ref) {
  return IsLoginedNotifier(ref: ref);
});

class IsLoginedNotifier extends StateNotifier<bool>{
  IsLoginedNotifier({required this.ref}) : super(false) {
    state = (ref.watch(sharedUtilityProvider).getUserToken() != null) && (ref.watch(sharedUtilityProvider).getLoginType() != LoginType.none);
  }
  Ref ref;

  void updateAuthInfo(String token, LoginType loginType){
    if(loginType == LoginType.none){
      Common.shared.userToken = '';
      Common.shared.loginType = LoginType.none;
      ref.watch(sharedUtilityProvider).removeAuthInfo();
    } else{
      Common.shared.userToken = token;
      Common.shared.loginType = loginType;
      ref.watch(sharedUtilityProvider).setAuthInfo(token, loginType);
    }
  }

  LoginType getLoginType(){
    return ref.watch(sharedUtilityProvider).getLoginType();
  }
}