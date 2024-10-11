import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkErrors{
  wrongData(401, 'user name 또는 password가 일치하지 않습니다.'),
  wrongUrl(404, '페이지를 찾을 수 없습니다.'),
  unConnected(-1, '서비스에 연결할 수 없습니다. 네트워크 연결을 확인해주세요.'),
  underfriend(-2, '서비스에 연결할 수 없습니다. 잠시 후 다시 시도해 보세요.\n(이와 같은 증상이 계속 되는 경우 고객센터에 문의해주세요.)(-2)'),
  criticalError(-3, '서비스에 연결할 수 없습니다. 잠시 후 다시 시도해 보세요.\n(이와 같은 증상이 계속 되는 경우 고객센터에 문의해주세요.)(-3)');

  const NetworkErrors(this.code, this.description);
  final int code;
  final String description;

  factory NetworkErrors.getByCode(int? code, ConnectivityResult ns){
    if(code == null){
      if (ns == ConnectivityResult.mobile || ns == ConnectivityResult.wifi) {
          return NetworkErrors.criticalError;
      }
      return NetworkErrors.unConnected;
    }
    return NetworkErrors.values.firstWhere((element) => element.code == code,
    orElse: () => NetworkErrors.underfriend);
  }
}
