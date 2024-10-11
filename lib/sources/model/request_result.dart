enum Result{ success, failed }
class RequestResult{
  Result result;
  dynamic data;
  RequestResult(this.result, this.data);
}