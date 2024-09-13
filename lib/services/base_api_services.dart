import 'package:get/get.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/controllers/auth/http/service_url.dart';

abstract class BaseApiService {
  Future<ApiResponse<dynamic>> getApi(String url);
  Future<ApiResponse<dynamic>> postApi(dynamic data, String url);
}

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

class NetworkApiService extends GetConnect implements BaseApiService {
  NetworkApiService() {
    onInit();
  }

  @override
  void onInit() {
    var token =
        '''d2af211e09cd42823dd5c7d74bc5007ecb561e82d1c6cc7c1a325d5be9eb29aee81ecf671ce842e42acc3263c2f10271bc74cc365e363c7e3c9e79eb04058b75ca6d933503363c768a225acc8d868c7ae90796820910eb01f4c6df2995453f781c1d4458b6e9d366cfe879d720b83306526b5b5eeb44cab52f5f4c0d3427c686''';
    token = token.replaceAll('\n', '');

    httpClient.baseUrl = ServiceUrl.baseApiUrl;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);

    var headers = {
      'Authorization': 'Bearer $token',
    };

    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers.addAll(headers);
      print('Request headers: ${request.headers}');
      return request;
    });
  }

  @override
  Future<ApiResponse<dynamic>> getApi(String url) async {
    try {
      final response = await get(url);
      return returnResponse(response);
    } catch (e) {
      return ApiResponse.error("Unexpected error: $e");
    }
  }

  @override
  Future<ApiResponse<dynamic>> postApi(dynamic data, String url) async {
    try {
      final response = await post(url, data);
      return returnResponse(response);
    } catch (e) {
      return ApiResponse.error("Unexpected error: $e");
    }
  }

  ApiResponse<dynamic> returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse.completed(response.bodyString);
      case 400:
        return ApiResponse.error("Bad Request: ${response.bodyString}");
      case 401:
        return ApiResponse.error("Unauthorized: ${response.bodyString}");
      case 403:
        return ApiResponse.error("Forbidden: ${response.bodyString}");
      case 404:
        return ApiResponse.error("Not Found: ${response.bodyString}");
      case 500:
        return ApiResponse.error("Internal Server Error: ${response.bodyString}");
      case 502:
        return ApiResponse.error("Bad Gateway: ${response.bodyString}");
      case 503:
        return ApiResponse.error("Service Unavailable: ${response.bodyString}");
      case 504:
        return ApiResponse.error("Gateway Timeout: ${response.bodyString}");
      default:
        return ApiResponse.error("Unknown Error: ${response.statusCode}");
    }
  }
}
