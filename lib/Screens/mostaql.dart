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
import 'package:freelance/Provider/Mostaqlprovider.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:provider/provider.dart' as provider;

void main() => runApp(const MaterialApp(home: Mostaql()));

class Mostaql extends StatefulWidget {
  const Mostaql({super.key});

  @override
  State<Mostaql> createState() => _MostaqlState();
}

class _MostaqlState extends State<Mostaql> {
  late final WebViewController _controller;
  late Mostaqlprovider _Mostaqlprovider;

  @override
  void initState() {
    _Mostaqlprovider = provider.Provider.of<Mostaqlprovider>(context, listen: false);
_Mostaqlprovider.initWebView(context);
    super.initState();

  }
 void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
    _Mostaqlprovider.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
  backgroundColor: Color(0xFF2486C8), // Set the background color here

          title:  Text('مستقل',
 style: TextStyle_(
              fontSize: 20,
              color: const Color.fromARGB(255, 255, 255, 255),
            )),
          actions: <Widget>[
            NavigationControls(webViewController: _Mostaqlprovider.WebViewController_),
          ],
        ),
        body: WebViewWidget(controller:_Mostaqlprovider.WebViewController_),
       drawer: Drawer_app(),
        floatingActionButton: _Mostaqlprovider.favoriteButton(context),
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
