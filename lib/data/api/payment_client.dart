import 'package:get/get.dart';

class PaymentClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  late Map<String,String> _mainHeaders;
  PaymentClient({required this.appBaseUrl,}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-Type' : 'application/json',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers})async{
    try{
      Response response = await get(uri,
          headers: headers??_mainHeaders
      );
      return response;
    }catch(e){
      return  Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri , dynamic body) async{
    try{
      Response response = await post(uri, body,headers: _mainHeaders);
      return response;
    }catch(e){
      return  Response(statusCode: 1,statusText: e.toString());
    }
  }
}
