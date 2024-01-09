import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/SessionManager.dart';
import 'package:freelance/Helper_functions/apiclass.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Models/presentation.dart';
import 'package:http/http.dart' as http;




class Presentationprovider with ChangeNotifier {
  static const baseURL = 'https://bb.egyticsports.com/public/api';

  List<presentation> _presentation = [];

  List<presentation> get pres => _presentation;

  Future<void> fetchData() async {
    try {


    String? Presentation = await SessionManager.getSession('Presentation');

      List<presentation> data = await Apiclass.fetch<presentation>(
          'presentations/$Presentation',
          fromJson: (json) => presentation.fromJson(json));
      _presentation = data;
      notifyListeners();
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
    }
  }

  Future<void> createData(String? offer, BuildContext context) async {
    final apiUrl = 'presentation';

    String? Presentation = await SessionManager.getSession('Presentation');
    final data = {
      'Semantic_word': Presentation,
      'offer': offer
    }; // Replace with your actual data
    try {
      Map<String, dynamic> result =
          await Apiclass.manageRecordInDatabase(apiUrl, data);
      if (result['status']) {
        fetchData();
        showNotification(context, title: "", message: result['message']);
      } else {
        showNotification(context,
            title: "", message: result['message'], success: false);
      }
      notifyListeners();
    } catch (error) {
      print('Error: $error');
      // Handle exception case in your Flutter UI
    }
    // Notify listeners to trigger a rebuild if necessary
    notifyListeners();
  }

 Future<Map<String, dynamic>> addPresentation( String offer, BuildContext context) async {
    final String url = 'presentation'; // Replace with your API endpoint
    String? Presentation = await SessionManager.getSession('Presentation');

    Map<String, String> data = {
      'Semantic_word': Presentation!,
      'offer': offer,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseURL/$url'),
        body: data,
      );

      if (response.statusCode == 200) {
        // Successful addition
        final responseData = json.decode(response.body);
        print('Presentation added successfully: $responseData');
      
        return responseData;
      } else if (response.statusCode == 400) {
        // Validation error
        final errorMessage = json.decode(response.body)['message'];
        print('Validation Error: $errorMessage');
        // Handle validation error
        return {'error': errorMessage};
      } else {
        print('Failed to add presentation. Status code: ${response.statusCode}');
        // Handle other errors
        return {'error': 'Failed to add presentation'};
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors
      return {'error': 'An error occurred'};
    }
  }

Future<void> updatePresentation( String offer, int id,BuildContext context) async {


final response = await http.put(
    Uri.parse('$baseURL/presentation/$id'),
    body: jsonEncode({
      'offer': offer,
 'id': id,
    }),
    headers: {
    'Content-Type': 'application/json; charset=UTF-8',

    },
  );
  if (response.statusCode == 200) {
   fetchData();
  print(' ${response.body}');
       Navigator.pop(context); // يُغلق الشاشة الحالية

  } else {
    print('${response.body}');

  showNotification(context,
            title: "", message: "Error updating presentation", success: false);

  }
}



 Future<void> delate_row(String id,BuildContext context) async {
    try {

// int id_pas=int.parse(id);
   final apiUrl = 'deletePresentation'; // Replace with your actual API endpoint
    final data = {'id': id}; // Replace with your actual data
    try {
      Map<String, dynamic> result =
          await Apiclass.manageRecordInDatabase(apiUrl, data,func: false);
      if (result['status']) {
fetchData();
        showNotification(context, title: "", message: result['message']);
      } else {
        showNotification(context,
            title: "", message: result['message'], success: false);
      }
notifyListeners();
    } catch (error) {
      print('Error: $error');
      // Handle exception case in your Flutter UI
    }    
      notifyListeners();
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
    }
  }



}
