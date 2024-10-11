import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../resources/color_asset/colors.dart';
import '../../../model/login_type.dart';
import '../../../model/request_result.dart';
import '../../../network/network_service.dart';
import '../../../service/auth_provider.dart';
import '../../subviews/app_dialoges.dart';


ElevatedButton logInButton({
  required BuildContext context, 
  required WidgetRef ref,
  required String username,
  required String password,
}) {
  // final prefs = ref.watch(sharedPreferencesProvider);
  final isLogined = ref.watch(isLoginedProvider.notifier);
  final isChecked = ref.watch(termsAgreementPorvider);
  final ns = NetworkService();
  
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CsColors.cs.accentColor,
        minimumSize: Size(100, 45)
      ),
      onPressed: () async {
        if(username.isEmpty || password.isEmpty){
          justConfirmDialog(context: context,
            description: "user name 및 password를 입력해주세요.",
          );
          return;
        }
        if(!isChecked){
          justConfirmDialog(context: context,
            description: "이용약관 및 개인정보약관 동의에 체크해주세요.",
          );
          return;
        }

        ref.read(authLoading.notifier).update((state) => true);
        final res = await ns.getUserToken(username, password);
        // final res = await ns.getUserToken('mor_2314', '83r5^_');
        ref.read(authLoading.notifier).update((state) => false);
        switch(res.result){
          case Result.success:
            isLogined.updateAuthInfo(res.data, LoginType.email);
            Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
            break;
          case Result.failed:
            networkErrorDialog(res.data);
            break;
        }

      },
      child: Text("로그인",
        style: GoogleFonts.notoSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
}


TextButton signInButton(BuildContext context) {
  return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.all(4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
      onPressed: (){
        Navigator.pushNamed(context, '/signup');
      },
      child: Text("회원가입",
        style: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: CsColors.cs.accentColor
        ),
      ),
    );
}
