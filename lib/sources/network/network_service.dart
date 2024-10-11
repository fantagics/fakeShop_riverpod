import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/request_result.dart';
import '../network/network_error.dart';
import '../model/products.dart';

class NetworkService{
  final domain = 'https://fakestoreapi.com/';
  String reqUrl(String path){return domain+path;}

//Auth
  Future<RequestResult> getUserToken(String username, String password) async{
    try{
      Response res = await Dio().post(
        reqUrl("auth/login"),
        data: {
          'username' : username,
          'password' : password
        }
      );
      String token = res.data['token'];
      return RequestResult(Result.success, token);
    } on DioException catch (e){
      print(e.response?.statusCode);
      print(e.response?.data);
      var connectivityResult = await (Connectivity().checkConnectivity());
      String msg = NetworkErrors.getByCode(e.response?.statusCode, connectivityResult).description;
      return RequestResult(Result.failed, msg);
    }
  }

//Products
  Future<RequestResult> getCategories() async{
    try{
      Response resCate = await Dio().get(reqUrl("products/categories"));
      return RequestResult(Result.success, List<String>.from(resCate.data));
    } on DioException catch (e){
      String msg = await errorHandler(e);
      return RequestResult(Result.failed, msg);
    }
  }
  Future<RequestResult> getRecommendItemsEachCategory(List<String> categories) async{
    Map<String,List<Product>> result = {};
    try{
      for(String c in categories){
        Response resItems = await Dio().get(reqUrl("products/category/$c?limit=3"));
        List<Product> cateItem = List<Product>.from(resItems.data.map((p){return Product.fromJson(p);}).toList());
        result[c] = cateItem;
      }
      return RequestResult(Result.success, result);
    } on DioException catch (e){
      String msg = await errorHandler(e);
      return RequestResult(Result.failed, msg);
    }
  }

  Future<RequestResult> getAllProducts()async{
    try{
      Response res = await Dio().get(reqUrl('products?sort=desc'));
      return RequestResult(Result.success, List<Product>.from(res.data.map((p){return Product.fromJson(p);}).toList() ?? []));
    } on DioException catch (e){
      String msg = await errorHandler(e);
      return RequestResult(Result.failed, msg);
    }
  }
  Future<RequestResult> getProductsOf({required String category})async{
     try{
      Response res = await Dio().get(reqUrl('products/category/$category?sort=desc'));
      return RequestResult(Result.success, List<Product>.from(res.data.map((p){return Product.fromJson(p);}).toList() ?? []));
    } on DioException catch (e){
      String msg = await errorHandler(e);
      return RequestResult(Result.failed, msg);
    }
  }

  Future<String> errorHandler(DioException e) async{
    print(e.response?.statusCode);
    print(e.response?.data);
    var connectivityResult = await (Connectivity().checkConnectivity());
    String msg = NetworkErrors.getByCode(e.response?.statusCode, connectivityResult).description;
    return msg;
  }

}