import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../model/login_type.dart';
import '../../../service/auth_provider.dart';
import '../../subviews/app_dialoges.dart';

circleShadow({
  required Widget child
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.7),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(1, 2),
        )
      ]
    ),
    child: child
  );
}

kakaoLoginButton({
  required BuildContext context,
  required WidgetRef ref,
}){
  final isChecked = ref.watch(termsAgreementPorvider);
  return circleShadow(
    child: GestureDetector(
      onTap: () async{
        if(!isChecked){
          justConfirmDialog(context: context,
            description: "이용약관 및 개인정보약관 동의에 체크해주세요.",
          );
          return;
        }
        if (await isKakaoTalkInstalled()) { //login for logined app
          try {
              OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
              changeLoginToken(ref, token.accessToken, LoginType.kakao);
              print('카카오톡으로 로그인 성공');
              Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
          } catch (error) {
              print('카카오톡으로 로그인 실패 $error');
              if (error is PlatformException && error.code == 'CANCELED') {
                  return; // 의도적인 로그인 취소
              }
            // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
            try {
                OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
                changeLoginToken(ref, token.accessToken, LoginType.kakao);
                print('카카오계정으로 로그인 성공');
                Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
            } catch (error) {
                print('카카오계정으로 로그인 실패 $error');
            }
          }
        } else { //login for account
          try {
            OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
            changeLoginToken(ref, token.accessToken, LoginType.kakao);
            print('카카오계정으로 로그인 성공');
            Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      }, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset('assets/Kakao_logo.png',
          width: 36, height: 36,
          fit: BoxFit.cover,
        ),
      )
    )
  );
}

googleLoginButton({
  required BuildContext context,
  required WidgetRef ref,
}){
  final isChecked = ref.watch(termsAgreementPorvider);
  return circleShadow(
    child: GestureDetector(
      onTap: () async{
        if(!isChecked){
          justConfirmDialog(context: context,
            description: "이용약관 및 개인정보약관 동의에 체크해주세요.",
          );
          return;
        }
        print("google login sdk");
      }, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset('assets/google_logo.png',
          width: 36, height: 36,
          fit: BoxFit.cover,
        ),
      )
    )
  );
}

appleLoginButton({
  required BuildContext context,
  required WidgetRef ref,
}){
  final isChecked = ref.watch(termsAgreementPorvider);
  return circleShadow(
    child: GestureDetector(
      onTap: () async{
        if(!isChecked){
          justConfirmDialog(context: context,
            description: "이용약관 및 개인정보약관 동의에 체크해주세요.",
          );
          return;
        }
        print("apple login sdk");
      }, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset('assets/apple_logo.png',
          width: 36, height: 36,
          fit: BoxFit.cover,
        ),
      )
    )
  );
}

void changeLoginToken(WidgetRef ref, String token, LoginType loginType){
  final isLogined = ref.watch(isLoginedProvider.notifier);
  isLogined.updateAuthInfo(token, loginType);
}