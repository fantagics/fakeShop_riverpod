import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

welcomeTitle(){
  return  RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      style: GoogleFonts.notoSans(
        color: Colors.black,
        fontSize: 16,
      ),
      children: [
        TextSpan(text: "환영합니다 !\n",
          style: GoogleFonts.notoSans(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: "\'"),
        TextSpan(text: "페이크샵",
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold
          )
        ),
        TextSpan(text: "\'은 \'"),
        TextSpan(text: "fakestoreapi",
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold
          )
        ),
        TextSpan(text: "\'을 사용한 가짜 쇼핑 앱입니다. "),
        // TextSpan(text: "(개발 이태형)(mor_2314/83r5^_)",
        TextSpan(text: "(mor_2314/83r5^_)",
          style: GoogleFonts.notoSans(
            color: Colors.grey
          )
        ),
      ]
    ),
  );
}