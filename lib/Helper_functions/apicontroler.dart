import 'dart:convert';

import 'package:freelance/Helper_functions/apiclass.dart';
import 'package:http/http.dart' as http;

class Apicontroler {
  // ----- STRINGS ------
  static const baseURL = 'https://bb.egyticsports.com/public/api';

  // ----- Errors -----
  static const serverError = 'Server error';
  static const unauthorized = 'Unauthorized';
  static const somethingWentWrong = 'Something went wrong, try again!';

static Future<ApiResponse> fetchData<T>(String url,
    {String? token,
    String? tableName,
    required T Function(Map<String, dynamic>) fromJson}) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse("$baseURL/$url"),
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = response.body;
      if (tableName != null) {
        apiResponse.data = jsonDecode(data)[tableName];
      } else {
        apiResponse.data = jsonDecode(data);
      }
    } else {
      print("${response.body}");
      switch (response.statusCode) {
        case 200:
          if (tableName != null) {
            apiResponse.data = jsonDecode(response.body)[tableName].map<T>((p) {
              return fromJson(p);
            }).toList();
          } else {
            apiResponse.data = jsonDecode(response.body).map<T>((p) {
              return fromJson(p);
            }).toList();
          }
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;

          break;
      }
    }
  } catch (e) {
    print("ERR:::::$e");
    apiResponse.error = serverError;
  }

  return apiResponse;
}

  static Future<ApiResponse?> createRow<T>(
      {required String url,
      required Map<String, dynamic> data,
      String? token,
      String? tableName,
      required T Function(Map<String, dynamic>) fromJson}) async {
    final uri = Uri.parse("$baseURL/$url");
    ApiResponse apiResponse = ApiResponse();
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = response.body;
      if (tableName != null) {
        apiResponse.data = jsonDecode(data)[tableName];
        print("${response.body}");
      } else {
        apiResponse.data = jsonDecode(data);
      }
    } else {
      print("${response.body}");
      switch (response.statusCode) {
        case 200:
          if (tableName != null) {
            apiResponse.data =
                jsonDecode(response.body)[tableName].map<T>((p) {
              return fromJson(p);
            }).toList();
          } else {
            apiResponse.data = jsonDecode(response.body).map<T>((p) {
              return fromJson(p);
            }).toList();
          }
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;

          break;
      }
      print('Failed to create task');
    }
  }

  static Future<void> deleteRecord(String urlx) async {
    print("$baseURL/$urlx");
    final url = Uri.parse('$baseURL/$urlx');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('تم حذف السجل بنجاح');
      } else if (response.statusCode == 404) {
        print('السجل غير موجود');
      } else {
        print('حدث خطأ: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ: $e');
    }
  }

  static Future<ApiResponse> updatadataget<T>(String url,
      {String? token,
      String? tableName,
      required T Function(Map<String, dynamic>) fromJson}) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.get(
        Uri.parse("$baseURL/$url"),
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = response.body;
        if (tableName != null) {
          apiResponse.data = jsonDecode(data)[tableName];
        } else {
          apiResponse.data = jsonDecode(data);
        }
      } else {
        print("${response.body}");
        switch (response.statusCode) {
          case 200:
            if (tableName != null) {
              apiResponse.data =
                  jsonDecode(response.body)[tableName].map<T>((p) {
                return fromJson(p);
              }).toList();
            } else {
              apiResponse.data = jsonDecode(response.body).map<T>((p) {
                return fromJson(p);
              }).toList();
            }
            break;
          case 401:
            apiResponse.error = unauthorized;
            break;
          default:
            apiResponse.error = somethingWentWrong;

            break;
        }
      }
    } catch (e) {
      print("ERR:::::$e");
      apiResponse.error = serverError;
    }

    return apiResponse;
  }

  static Future<Object> sendHttpRequestAndResponse<T>({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    String? tableName,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final uri = Uri.parse("$baseURL/$url");
    ApiResponse apiResponse = ApiResponse();
    String responseBody = "";

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      responseBody = response.body;

      if (response.statusCode == 200) {
        if (tableName != null) {
          apiResponse.data = jsonDecode(responseBody)[tableName];
          print("Response Body: $responseBody");
        } else {
          apiResponse.data = jsonDecode(responseBody);
        }
      } else {
        print("Response Body: $responseBody");
        switch (response.statusCode) {
          case 200:
            if (tableName != null) {
              apiResponse.data =
                  jsonDecode(responseBody)[tableName].map<T>((p) {
                return fromJson(p);
              }).toList();
            } else {
              apiResponse.data = jsonDecode(responseBody).map<T>((p) {
                return fromJson(p);
              }).toList();
            }
            break;
          case 401:
            apiResponse.error = unauthorized;
            break;
          default:
            apiResponse.error = somethingWentWrong;

            break;
        }
        return apiResponse;
      }
    } catch (e) {
      print('Error: $e');
      apiResponse.error = e.toString();
    }

    return ApiResponseAndResponseBody(apiResponse, responseBody);
  }

  static Future<List<Map<String, dynamic>>> fetchDataapp(String apiUrl, {List<String>? variables}) async {
    List<String> wordsArray;

    final wordsResponse = await http.get(Uri.parse('$apiUrl/words'));
    if (wordsResponse.statusCode == 200) {
      final Map<String, dynamic> wordsData = jsonDecode(wordsResponse.body);
      wordsArray = List<String>.from(wordsData['data']);
    } else {
      print('Failed to load words. Status code: ${wordsResponse.statusCode}');
      return [];
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'keywords': wordsArray, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return data;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      return [];
    }
  }



}

class ApiResponseAndResponseBody {
  final ApiResponse apiResponse;
  final String responseBody;

  ApiResponseAndResponseBody(this.apiResponse, this.responseBody);
}
