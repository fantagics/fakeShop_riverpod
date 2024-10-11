enum LoginType{
  kakao('kakao'), 
  google('google'), 
  apple('apple'), 
  email('email'), 
  none('none');

  const LoginType(this.str);
  final String str;

  factory LoginType.getByString(String str){
    return LoginType.values.firstWhere((value) => value.str == str,
    orElse: () => LoginType.none);
  }
}