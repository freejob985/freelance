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
import 'package:freelance/Provider/nafezlyprovider.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:provider/provider.dart' as provider;

void main() => runApp(const MaterialApp(home: Nafezly()));

class Nafezly extends StatefulWidget {
  const Nafezly({Key? key}) : super(key: key);

  @override
  State<Nafezly> createState() => _NafezlyState();
}

class _NafezlyState extends State<Nafezly> {
  late final WebViewController _controller;

  @override


  late Nafezlyprovider _Nafezlyprovider;

  @override
  void initState() {
    _Nafezlyprovider = provider.Provider.of<Nafezlyprovider>(context, listen: false);
_Nafezlyprovider.initWebView(context);
    super.initState();

  }

 void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
    _Nafezlyprovider.dispose();
 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title:  Text('نفذلي',
 style: TextStyle_(
              fontSize: 20,
              color: const Color.fromARGB(255, 255, 255, 255),
            )),
          actions: <Widget>[
            NavigationControls(webViewController: _Nafezlyprovider.WebViewController_),
          ],
        ),
        body: WebViewWidget(controller:_Nafezlyprovider.WebViewController_),
       drawer: Drawer_app(),
        floatingActionButton: _Nafezlyprovider.favoriteButton(context),
      ),
    );
  }

}

class NavigationControls extends StatelessWidget {
  const NavigationControls({Key? key, required this.webViewController})
      : super(key: key);

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
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
            if (await webViewController.canGoForward()) {
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
