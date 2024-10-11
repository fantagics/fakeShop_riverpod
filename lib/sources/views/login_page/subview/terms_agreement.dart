import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../resources/color_asset/colors.dart';
import '../../../service/auth_provider.dart';

termsAgreementBox(WidgetRef ref) {
  final isChecked = ref.read(termsAgreementPorvider);
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked, 
          onChanged: (value){
            ref.read(termsAgreementPorvider.notifier).update((state) => value!);
          },
          activeColor: CsColors.cs.accentColor,
          checkColor: Colors.white,
          side: BorderSide(width: 1.4, color: CsColors.cs.accentColor),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity(
            horizontal: -2,
            vertical: -2,
          ),
        ),
        renderAgreementText(),
      ],
    );
}

renderAgreementText(){
  return RichText(
    text: TextSpan(
      style: GoogleFonts.notoSans(
        color: Colors.black,
        fontSize: 14
      ),
      children: [
        TextSpan(text: "이용약관",
          style: GoogleFonts.notoSans(
            color: CsColors.cs.accentColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline
          ),
          recognizer: TapGestureRecognizer()..onTap = () async{
            await launchUrl(Uri.parse("https://www.google.co.kr/"));
          }
        ),
        TextSpan(text: "과 "),
        TextSpan(text: "개인정보약관",
          style: GoogleFonts.notoSans(
            color: CsColors.cs.accentColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline
          ),
          recognizer: TapGestureRecognizer()..onTap = () async{
            await launchUrl(Uri.parse("https://www.google.co.kr/"));
          }
        ),
        TextSpan(text: "에 동의합니다."),
      ]
    )
  );
}