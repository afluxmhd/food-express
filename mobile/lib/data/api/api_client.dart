import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  ApiClient({required this.appBaseUrl});

  final String appBaseUrl;

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(appBaseUrl + uri);
      return response;
    } catch (e) {
      print('Error: $e');
      return const Response(statusCode: 1);
    }
  }

  Future<Response> postData(String uri, Map<String, dynamic> body) async {
    try {
      Response response = await post(appBaseUrl + uri, body);
      print(response.body);
      return response;
    } catch (e) {
      print('Error: $e');
      return const Response(statusCode: 1);
    }
  }

  Future<Response> patchData(String uri, Map<String, dynamic> body) async {
    try {
      Response response = await patch(appBaseUrl + uri, body);
      print(response.body);
      return response;
    } catch (e) {
      print('Error: $e');
      return const Response(statusCode: 1);
    }
  }
}
