import 'package:kacs/constants/enum.dart';
import 'package:kacs/constants/http/service_url.dart';

import 'package:kacs/models/view_model_novel.dart';
import 'package:kacs/models/view_model_country_code.dart';
import 'package:kacs/models/view_model_user.dart';
import 'package:kacs/services/base_api_services.dart';
import 'package:kacs/utils/exception_handler.dart';
import 'package:kacs/views/pages/NovelDetailScreen/model/view_model_novel_details.dart';

class ApiService {
  final _apiService = NetworkApiService();

  Future<UserLoginData?> loginApi(var data) async {
    try {
      final response = await _apiService.postApi(data, ServiceUrl.loginUrl);
      if (response.status == Status.COMPLETED) {
        return userDataFromJson(response.data);
      } else {
        throw Exception(response);
      }
    } catch (e, stacktrace) {
      print(stacktrace);
      handleApiException(e);
    }
    return null;
  }

  Future<UserLoginData?> registerApi(var data) async {
    try {
      final response = await _apiService.postApi(data, ServiceUrl.registerUrl);
      if (response.status == Status.COMPLETED) {
        return userDataFromJson(response.data);
      } else {
        throw Exception(response);
      }
    } catch (e, stacktrace) {
      print(stacktrace);
      handleApiException(e);
    }
    return null;
  }

  Future<NovelData?> fetchNovel() async {
    try {
      final response = await _apiService.getApi(ServiceUrl.novelUrl);
      if (response.status == Status.COMPLETED) {
        return novelDataFromJson(response.data);
      } else {
        throw Exception(response);
      }
    } catch (e, stacktrace) {
      print(stacktrace);
      handleApiException(e);
    }
    return null;
  }

  Future<NovelDetailsData?> fetchNovelByID(int id) async {
    try {
      final response = await _apiService.getApi('${ServiceUrl.novelIdUrl}/$id');
      if (response.status == Status.COMPLETED) {
        return novelDetailsDataFromJson(response.data);
      } else {
        throw Exception(response);
      }
    } catch (e, stacktrace) {
      print(stacktrace);
      handleApiException(e);
    }
    return null;
  }

  Future<CountryCodeData?> getCountryCodes() async {
    try {
      final response = await _apiService.getApi(ServiceUrl.countryCodeUrl);
      if (response.status == Status.COMPLETED) {
        return countryCodeDataFromJson(response.data);
      } else {
        throw Exception(response);
      }
    } catch (e, stacktrace) {
      print(stacktrace);
      handleApiException(e);
    }
    return null;
  }
}
