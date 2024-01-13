import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/apiclass.dart';
import 'package:freelance/Models/fun.dart';
import 'package:freelance/Models/words.dart';
import 'package:http/http.dart' as http;

class Settingsprovider  with ChangeNotifier {

List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> get data_ => data;

  static const String baseUrl = 'https://bb.egyticsports.com/public/api'; // قم بتغيير الرابط إلى رابط API الخاص بك
  int _totalRecords = 0;

  int get totalRecords => _totalRecords;


  List<dynamic> results = [];
  int count = 0;

  List<Fun> _Fun = [];

  List<Fun> get fun => _Fun;



 Future<void> fetchDatax() async {
    try {
      List<Fun> data = await Apiclass.fetch<Fun>('fun',datasql: 'words' ,fromJson: (json) => Fun.fromJson(json));
      _Fun = data;
      notifyListeners();
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
    }
  }



Future<int?> fetchTotalRecords() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/count/all'));
      
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> && responseData.containsKey('total_records')) {
          _totalRecords = responseData['total_records'] as int;
return _totalRecords;

        } else {
          throw Exception('Invalid data format received from the server');
        }
      } else {
        throw Exception('Failed to load data');
      }

      
    } catch (e) {
      print('Error fetching data: $e');
    }
  }






Future<int?> fetchTotalRecords2() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/count/all'));
      
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> && responseData.containsKey('total_records')) {
          _totalRecords = responseData['total_records'] as int;
return _totalRecords;

        } else {
          throw Exception('Invalid data format received from the server');
        }
      } else {
        throw Exception('Failed to load data');
      }

      
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }


  Future<Map<String, dynamic>> deleteAllData(String endpoint) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(uri);
print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }



  Future<Map<String, dynamic>> api(String endpoint) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }






}
  
