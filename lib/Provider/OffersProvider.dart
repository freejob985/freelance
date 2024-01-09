import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/ApiResponse.dart';
import 'package:freelance/Helper_functions/apiclass.dart';
import 'package:freelance/Helper_functions/apicontroler.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Models/freelancing.dart';
import 'package:http/http.dart' as http;

class OffersProvider with ChangeNotifier {
  List<freelancing> _freelancing = [];
  static const baseURL = 'https://bb.egyticsports.com/public/api';

  List<freelancing> get free => _freelancing;

  bool _isUpdating = false;

  bool get isUpdating => _isUpdating;

  set isUpdating(bool value) {
    _isUpdating = value;
    notifyListeners();
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




  Future<void> fetchData() async {
    try {
      List<freelancing> data = await Apiclass.fetch<freelancing>('order',
          datasql: 'results', fromJson: (json) => freelancing.fromJson(json));
      _freelancing = data;
      notifyListeners();
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
    }
  }


  Future<void> executeFreelancingOrderKhamsat() async {
    final String apiUrl = 'khamsat'; // Replace with your API endpoint URL

    try {
      final response = await http.get(Uri.parse("$baseURL/$apiUrl"));

      if (response.statusCode == 200) {
        print('Function executed successfully');
        // Notify listeners if needed
        notifyListeners();
      } else {
        print('Failed to execute function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  Future<void> executeFreelancingOrdermostaql() async {
    final String apiUrl = 'mostaql'; // Replace with your API endpoint URL

    try {
      final response = await http.get(Uri.parse("$baseURL/$apiUrl"));

      if (response.statusCode == 200) {
        print('Function executed successfully');
        // Notify listeners if needed
        notifyListeners();
      } else {
        print('Failed to execute function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateFreelancing(int? id) async {
    try {
      // freelancingProvider.isUpdating = true;
      final response = await http.post(
        Uri.parse('$baseURL/update-freelancing/$id'),
        // يمكنك تخصيص رؤوس الطلب حسب الحاجة
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
print(response.body);
      if (response.statusCode == 200) {
        // تحديث الحالة أو قم بالتعامل مع الاستجابة حسب الحاجة
        print('تم التحديث بنجاح');
      } else {
        print('فشل في التحديث');
      }
    } finally {
      // freelancingProvider.isUpdating = false;
    }
  }

  Future<void> executeFreelancingOrdernafezly() async {
    final String apiUrl = 'nafezly'; // Replace with your API endpoint URL

    try {
      final response = await http.get(Uri.parse("$baseURL/$apiUrl"));

      if (response.statusCode == 200) {
        print('Function executed successfully');
        // Notify listeners if needed
        notifyListeners();
      } else {
        print('Failed to execute function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> executeFreelancingOrderkafiil() async {
    final String apiUrl = 'kafiil'; // Replace with your API endpoint URL

    try {
      final response = await http.get(Uri.parse("$baseURL/$apiUrl"));

      if (response.statusCode == 200) {
        print('Function executed successfully');
        // Notify listeners if needed
        notifyListeners();
      } else {
        print('Failed to execute function. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> createData(String? words, BuildContext context) async {
    final apiUrl = 'words'; // Replace with your actual API endpoint
    final data = {'words': words}; // Replace with your actual data
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





Future<List<String>> fetchOffer(String word) async {
  final response = await http.get(
    Uri.parse('$baseURL/keyword/$word'),
  );

print(response.body);
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final List<dynamic> jsonResponse = json.decode(response.body);

    // Assuming each element in the JSON response has an "offer" field
    List<String> offers = jsonResponse.map((item) => item.toString()).toList();

    return offers;
  } else {
    // If the server did not return a 200 OK response,
    // throw an exception.
    throw Exception('Failed to load offer');
  }
}

  void showDialogx(
      TextEditingController _keywordController, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Keyword Dialog'),
          content: Container(
            width: double.maxFinite, // تعيين عرض الفورم
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _keywordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Keywords',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // تعيين زاوية البوردر
                      borderSide: BorderSide(
                        color: Colors.grey, // لون البوردر
                        style: BorderStyle.solid, // نمط البوردر
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.all(10.0), // تعيين هامش الداخلي للحقل
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                String keywords = _keywordController.text;
                print(keywords);
                createData(keywords, context);
                // Navigator.of(context).pop();  // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetch() async {
    final response = await http
        .get(Uri.parse('https://u6m.3d7.mywebsitetransfer.com/api/order'));

    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
        List<dynamic> data = responseData['data'] is List
            ? responseData['data']
            : [responseData['data']];
        // التحقق من نوع البيانات وتحويلها إلى List من الكائنات Order
        _freelancing = data.map((item) => freelancing.fromJson(item)).toList();
        // notifyListeners();
      } else if (responseData is List) {
        // إذا كانت البيانات عبارة عن List مباشرة
        _freelancing =
            responseData.map((item) => freelancing.fromJson(item)).toList();
        // notifyListeners();
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }


String getLimitedWordsText(String text, int numberOfWords) {
  List<String> words = text.split(' ');

  if (words.length <= numberOfWords) {
    return text; // النص أقل من العدد المحدد من الكلمات
  }

  List<String> selectedWords = words.sublist(0, numberOfWords);
  return selectedWords.join(' ');
}




  Future<void> count() async {
    final response = await http.get(Uri.parse('http://bb.egyticsports.com/public/api/count'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
 return    data['count'];
  
  
    } else {
      throw Exception('Failed to load data');
    }
  }


}
