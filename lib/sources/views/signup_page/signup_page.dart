import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/color_asset/colors.dart';
import 'subview/signup_page_subviews.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController pwTxController = TextEditingController();
  bool firstHidden = true;
  bool secondHidden = true;

  String firstName = "";
  String lastName = "";
  String username = "";
  String password = "";
  String passwordC = "";
  String email = "";
  String address = "";
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("회원가입",
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        backgroundColor: CsColors.cs.accentColor,
      ),
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus(); },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Theme(
                    data: signInFieldTheme,
                    child: Column(
                      children: [
                        renderTextFormField(
                          context: context,
                          label: "first name", 
                          onSaved: (val){firstName = val;}, 
                          validator: (val){
                            return val.length < 20 ? null : "영문 20자 이내로 입력해주세요";
                          },
                          placeholder: "이름"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "last name", 
                          onSaved: (val){lastName = val;}, 
                          validator: (val){
                            return val.length < 20 ? null : "영문 20자 이내로 입력해주세요";
                          },
                          placeholder: "성"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "user name", 
                          onSaved: (val){username = val;}, 
                          validator: (val){
                            if(RegExp(r'^[a-zA-Z0-9]+$').hasMatch(val)){
                              return null;
                            }
                            return val.length < 1 ? "필수 입력란입니다." : "영문 대소문자, 숫자 조합으로 입력해주세요.";
                          },
                          placeholder: "영문 대소문자, 숫자 조합"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "password", 
                          onSaved: (val){password = val;}, 
                          validator: (val){
                            if(val.length < 1){ return "필수 입력란입니다."; }
                            if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)){
                              return "영어 대소문자, 숫자, 특수문자 포함 8자 이상 입력해주세요.";
                            }
                            return null;
                          },
                          isHidden: firstHidden,
                          visableSuffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: (){
                              setState(() {
                                firstHidden = !firstHidden;
                              });
                            },
                          ),
                          placeholder: "영어 대소문자, 숫자, 특수문자 포함 8자 이상"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "confirm password", 
                          onSaved: (val){passwordC = val;}, 
                          validator: (val){
                            if(val.length < 1){ return "필수 입력란입니다."; }
                            return password == passwordC ? null : "비밀번호가 일치하지 않습니다.";
                          },
                          isHidden: secondHidden,
                          visableSuffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: (){
                              setState(() {
                                secondHidden = !secondHidden;
                              });
                            },
                          ),
                          placeholder: "한번 더 입력해주세요."
                        ),

                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "email", 
                          onSaved: (val){email = val;}, 
                          validator: (val){
                            if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                              return null;
                            }
                            return val.length < 1 ? null : "올바른 형식으로 입력해주세요.";
                          },
                          keyboardType: TextInputType.emailAddress,
                          placeholder: "example@site.type"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(  //city, street, number,zipcode, geolocation(lat,long)
                          context: context,
                          label: "address", 
                          onSaved: (val){address = val;}, 
                          validator: (val){
                            return val.length < 60 ? null : "60자 이내로 입력해주세요";
                          },
                          placeholder: "주소"
                        ),
                        SizedBox(height: 20),
                        renderTextFormField(
                          context: context,
                          label: "phone", 
                          onSaved: (val){phone = val;},
                          validator: (val){
                            if(RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(val)){
                              return null;
                            }
                            return val.length < 1 ? "필수 입력란입니다." : "올바른 형식으로 입력해주세요.";
                          },
                          keyboardType: TextInputType.number,
                          placeholder: "010-0000-0000",
                          textFormat: [
                            PhoneFormatter(
                              sample: 'xxx-xxxx-xxxx',
                              separator: '-'
                            )
                          ]
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text("실제로 회원가입이 되지 않습니다.",
                  style: GoogleFonts.notoSans(
                    color: Colors.grey
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CsColors.cs.accentColor,
                    minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      Navigator.pop(context);
                    }
                  },
                  child: Text("회원가입",
                    style: GoogleFonts.notoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 100,)
              ]
            ),
          ),
        ),
      )
    );
  }
}


