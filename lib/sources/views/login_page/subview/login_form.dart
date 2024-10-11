import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/color_asset/colors.dart';
import 'terms_agreement.dart';
import 'email_login_button.dart';
import 'sns_login_buttons.dart';

loginForm(BuildContext context, WidgetRef ref, TextEditingController idTextFieldControl, TextEditingController pwTextFieldControl){

  return Column(
    children: [
      Form(
        child: Theme(
          data: loginFieldTheme,
          child: Column(
            children:[
              renderLoginField(
                context: context,
                label: "user name",
                controller: idTextFieldControl,
                secure: false,
                next: true
              ),
              SizedBox(height: 16),
              renderLoginField(
                context: context,
                label: "password",
                controller: pwTextFieldControl,
                secure: true,
                next: false
              ),
            ]
          ),
        ),
      ),
      SizedBox(height: 10,),
      termsAgreementBox(ref),
      SizedBox(height: 8),
      logInButton(
        context: context,
        ref: ref,
        username: idTextFieldControl.text,
        password: pwTextFieldControl.text,
      ),
      SizedBox(height: 8),
      signInButton(context),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kakaoLoginButton(context: context, ref: ref),
          SizedBox(width: 10),
          googleLoginButton(context: context, ref: ref),
          SizedBox(width: 10),
          appleLoginButton(context: context, ref: ref),
        ],
      ),
    ],
  );
}

ThemeData loginFieldTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: CsColors.cs.accentColor,
      fontSize: 16,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 2, color: CsColors.cs.accentColor)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 2, color: CsColors.cs.accentColor)
    ),
    suffixIconColor: CsColors.cs.accentColor,
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(21, 20, 20, 12),
  )
);

renderLoginField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required bool secure,
  required bool next
}){
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    style: GoogleFonts.notoSans(
      fontSize: 16
    ),
    cursorColor: CsColors.cs.accentColor,
    obscureText: secure,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: IconButton(
        icon: Icon(Icons.clear, size: 20,),
        onPressed: controller.clear,
      )
    ),
    textInputAction: next ? TextInputAction.next : TextInputAction.done,
    onSubmitted: (_){
      if(next){
        FocusScope.of(context).nextFocus();
      } else{
        FocusScope.of(context).unfocus();
      }
    },
  );
}