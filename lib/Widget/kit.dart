import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Screens/Customlink.dart';




void showNotification(BuildContext context,
    {required String title, required String message, bool success = true}) {
  Flushbar(
    messageText: Directionality(
textDirection: TextDirection.rtl,
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16, // تغيير حجم الخط
          color: Colors.white, // تغيير لون النص
          fontWeight: FontWeight.bold,
              fontFamily: 'Al-Jazeera',
        ),
      ),
    ),
    icon: success ? const Icon(Icons.check) : const Icon(Icons.error),
    backgroundColor: success ? Colors.green : Colors.red,
    duration: success ? Duration(seconds: 6) : Duration(seconds: 6),
  ).show(context);
}




TextField Field(
  TextEditingController _itemController,
  String labelText,
  String hintText, {
  TextInputType? keyboardType,
  String? Function(String?)?
      validator, // إضافة معامل اختياري لنوع لوحة المفاتيح
}) {
  return TextField(
    controller: _itemController,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle_(fontSize: 15, color: Colors.white),
      border: InputBorder.none,
      filled: true,
      fillColor: pr,
      hintText: hintText,
      hintStyle: TextStyle_(fontSize: 15, color: Colors.white),
    ),
    style: TextStyle(fontSize: 15, color: Colors.white),
    keyboardType: keyboardType,

// تعيين نوع لوحة المفاتيح
  );
}

TextStyle? TextStyle_({
  int fontSize = 10,
  Color color = const Color.fromARGB(255, 70, 69, 69),
  TextDecoration? decoration, // جعل القيمة اختيارية بواسطة TextDecoration?
}) {
  return TextStyle(
    fontSize: fontSize.toDouble(),
    fontFamily: 'Al-Jazeera',
    fontWeight: FontWeight.normal,
    color: color,
    decorationThickness: 2,
    decoration: decoration, // استخدام القيمة الاختيارية هنا
  );
}


/*


  هذا هو تعليق متعدد الأسطر.
*/
  void scren_webview(BuildContext context, String url, String text ,Color col) {
    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomLink(url: url,text:text ,backgroundColor:col,),
                              ),
                            );
  }



