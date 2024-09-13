// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:kacs/models/view_model_country_code.dart';

// class BaseApiService {
//   @override
//   void onInit() {}
// }

// class ApiService extends BaseApiService {
//   Future<CountryCodeData?> getCountryCode() async {
//     var token =
//         '''d2af211e09cd42823dd5c7d74bc5007ecb561e82d1c6cc7c1a325d5be9eb29aee81ecf671ce842e42acc3263c2f10271bc74cc365e363c7e3c9e79eb04058b75ca6d933503363c768a225acc8d868c7ae90796820910eb01f4c6df2995453f781c1d4458b6e9d366cfe879d720b83306526b5b5eeb44cab52f5f4c0d3427c686''';
//     token = token.replaceAll('\n', '');
//     var headers = {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

//     final response = await http.get(Uri.https("test-api.kacs.my", "/api/countryCode"), headers: headers);

//     if (response.statusCode == 200) {
//       return countryCodeDataFromJson(response.body);
//     } else {
//       throw Exception('Failed to load data!');
//     }
//     return null;
//   }
// }
