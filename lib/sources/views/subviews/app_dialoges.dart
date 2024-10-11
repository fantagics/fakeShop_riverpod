import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../resources/color_asset/colors.dart';
import '../../service/navigation_key.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/auth_provider.dart';
import '../../model/login_type.dart';

void justConfirmDialog({
  required BuildContext context,
  String? title,
  String? description,
  }){
  showDialog(context: context, 
    builder: (context){
      return AlertDialog(
        title: title == null ? null : Text(title,
          style: GoogleFonts.notoSans(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        content: description == null ? null : Text(description,
          style: GoogleFonts.notoSans(
            fontSize: 18
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("확인",
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: CsColors.cs.accentColor
              ),
            ),
          )
        ],
      );
    }
  );
}

void logoutDialog({required BuildContext context, required WidgetRef ref}){
  final prefs = ref.read(isLoginedProvider.notifier);
  showDialog(context: context, builder: ((context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 30, bottom: 20),
      title: Center(
        child: Text('로그아웃 하시겠습니까?',
          style: GoogleFonts.notoSans(
            fontSize: 18
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context),
          child: Text('취소',
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.pink
            ),
          )
        ),
        TextButton(
          onPressed: () async{
            switch(prefs.getLoginType()){
              case LoginType.kakao:
                try {
                  await UserApi.instance.logout();
                  print('로그아웃 성공, SDK에서 토큰 삭제');
                } catch (error) {
                  print('로그아웃 실패, SDK에서 토큰 삭제 $error');
                }
                break;
              default:
                break;
            }
            prefs.updateAuthInfo('', LoginType.none);
            Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
          },
          child: Text('로그아웃',
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: CsColors.cs.accentColor
            ),
          )
        ),
      ],
    );
  }));
}

void networkErrorDialog(String description){
  final context = NavigationService.shared.navigationState.currentContext;
  if(context != null){
    showDialog(context: context, 
      builder: (context){
        return AlertDialog(
          content: Text(description,
            style: GoogleFonts.notoSans(
              fontSize: 18
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("확인",
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: CsColors.cs.accentColor
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
//Dialog -> Stack(children:[,reload View])