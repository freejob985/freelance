import 'dart:math';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


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

void navigateToPage(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return Scaffold(
      body: page,
    );
  }));
}

String generateRandomNumber(int length) {
  final random = Random();

  // حدود القيمة المسموح بها تبدأ من 1 وليست من 0
  final max = pow(10, length).toInt() - 1;

  int randomInt = random.nextInt(max); // توليد رقم عشوائي

  // يجب التحقق من أن الرقم المولد له الطول المطلوب
  String randomString =
      randomInt.toString().padLeft(length, '0'); // استخدام padLeft لتكوين الرقم

  String n = "check:$randomString";
  return n;
}

