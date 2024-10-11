import '../model/login_type.dart';

class Common{
	static Common shared = Common();
  
  String userToken = '';
  LoginType loginType = LoginType.none;
}