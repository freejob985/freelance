// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Provider/Khamsatprovider.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:provider/provider.dart' as provider;

void main() => runApp(const MaterialApp(home: Khamsat()));

class Khamsat extends StatefulWidget {
  const Khamsat({super.key});

  @override
  State<Khamsat> createState() => _KhamsatState();
}

class _KhamsatState extends State<Khamsat> {
  late final WebViewController _controller;
  late Khamsatprovider _Khamsatprovider;

  @override
  void initState() {
    super.initState();
    _Khamsatprovider = provider.Provider.of<Khamsatprovider>(context, listen: false);
_Khamsatprovider.initWebView(context);
  }

 void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
    _Khamsatprovider.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
  backgroundColor: Color(0xFFFCB62E), // Set the background color here

          title:  Text('خمسات',
 style: TextStyle_(
              fontSize: 20,
              color: Color.fromARGB(255, 73, 71, 71),
            )),
          actions: <Widget>[
            NavigationControls(webViewController: _Khamsatprovider.WebViewController_),
          ],
        ),
        body: WebViewWidget(controller:_Khamsatprovider.WebViewController_),
       drawer: Drawer_app(),
        floatingActionButton: _Khamsatprovider.favoriteButton(context),
      ),
    );
  }

}
class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});
  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await Provider.of<Khamsatprovider>(context).WebViewController_.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await Provider.of<Khamsatprovider>(context).WebViewController_.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
