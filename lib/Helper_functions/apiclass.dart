import 'dart:convert';
import 'package:http/http.dart' as http;

class Apiclass {
  // ----- STRINGS ------
  static const baseURL = 'https://bb.egyticsports.com/public/api';

  // ----- Errors -----
  static const serverError = 'Server error';
  static const unauthorized = 'Unauthorized';
  static const somethingWentWrong = 'Something went wrong, try again!';

  static Future<List<T>> fetch<T>(
    String url, {
    String? datasql,
    T Function(dynamic)? fromJson,
    String? token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/$url"),
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      print('Test point 1 ::=> ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          dynamic responseData = json.decode(response.body);

          if (datasql != null &&
              responseData is Map<String, dynamic> &&
              responseData.containsKey(datasql)) {
            List<dynamic> data = responseData[datasql] is List
                ? responseData[datasql]
                : [responseData[datasql]];
            List<T> processedData =
                data.map<T>((item) => fromJson!(item)).toList();
            print('Test point 1 ::=> $processedData');
            return processedData;
          } else if (responseData is List) {
            // If the data is a list directly
            List<T> processedData =
                responseData.map<T>((item) => fromJson!(item)).toList();
            print(processedData);
            return processedData;
          } else {
            throw Exception('Invalid data format');
          }
        } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error in fetch function: $error');
      throw Exception('An error occurred while fetching data');
    }
  }

/*
اضافة بيانات 
*/
  static Future<Map<String, dynamic>> manageRecordInDatabase(
      String apiUrl, Map<String, dynamic> data,
      {bool? func}) async {
    try {
      if (func == true) {
        final response = await http.put(
          Uri.parse("$baseURL/$apiUrl"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          return handleSuccessResponse(response);
        } else {
          return handleErrorResponse(response);
        }
      } else if (func == false) {
        print('Test point 1 ::=> 111');
        final response = await http.delete(
          Uri.parse("$baseURL/$apiUrl"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        print('Raw API Response: ${response.body}');
        print('Content-Type: ${response.headers['content-type']}');
        if (response.statusCode == 200) {
          return handleSuccessResponse(response);
        } else {
          return handleErrorResponse(response);
        }
        // الحالة عندما يكون func هو false  delete
      } else {
        final response = await http.post(
          Uri.parse("$baseURL/$apiUrl"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
        print('Raw API Response: ${response.body}');
        print('Content-Type: ${response.headers['content-type']}');
        if (response.statusCode == 200) {
          return handleSuccessResponse(response);
        } else {
          return handleErrorResponse(response);
        }
      }
    } catch (error) {
      print('Exception during API call: $error');
      return {'message': 'An error occurred', 'status': false};
    }
  }

  static Map<String, dynamic> handleSuccessResponse(http.Response response) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final successMessage = responseData['message'] as String?;
    return {
      'message': successMessage ?? 'Success',
      'status': true,
      'data': responseData
    };
  }

  static Map<String, dynamic> handleErrorResponse(http.Response response) {
    final Map<String, dynamic> errorData = jsonDecode(response.body);
    final errorMessage = errorData['error'] as String?;
    print('Failed to add data. Error: $errorMessage');
    return {'message': errorMessage ?? 'An error occurred', 'status': false};
  }

/*
اضافة بيانات 
*/
  static Future<ApiResponse<T>> createRow<T>({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    String? tableName,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final uri = Uri.parse("$baseURL/$url");
    ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;

        if (tableName != null) {
          final decodedData = jsonDecode(responseData);
          apiResponse.data = decodedData[tableName] != null
              ? fromJson(decodedData[tableName])
              : null; // Handle the case where the table name is not present in the response.
        } else {
          apiResponse.data = fromJson(jsonDecode(responseData));
        }
      } else {
        switch (response.statusCode) {
          case 401:
            apiResponse.error = ApiError.unauthorized;
            break;
          default:
            apiResponse.error = ApiError.somethingWentWrong;
            break;
        }
      }
    } catch (error) {
      apiResponse.error = "An error occurred: $error";
    }

    return apiResponse;
  }
}

class ApiResponse<T> {
  T? data;
  String? error;

  ApiResponse({this.data, this.error});
}

class ApiError {
  static const unauthorized = "Unauthorized";
  static const somethingWentWrong = "Something went wrong";
}
