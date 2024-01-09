import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/apiclass.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Models/words.dart';

class Wordsprovider with ChangeNotifier {
  List<wordsapp> _wordsapp = [];

  List<wordsapp> get word => _wordsapp;


 Future<void> fetchData() async {
    try {
      List<wordsapp> data = await Apiclass.fetch<wordsapp>('get-all-words',datasql: 'words' ,fromJson: (json) => wordsapp.fromJson(json));
      _wordsapp = data;
      notifyListeners();
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
    }
  }


 Future<void> delate_row(String id,BuildContext context) async {
    try {

// int id_pas=int.parse(id);
   final apiUrl = 'delete-word/delete'; // Replace with your actual API endpoint
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










}
