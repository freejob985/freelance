// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs


import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Provider/kafiilprovider.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:provider/provider.dart' as provider;

void main() => runApp(const MaterialApp(home: Kafiil()));

class Kafiil extends StatefulWidget {
  const Kafiil({super.key});

  @override
  State<Kafiil> createState() => _KafiilState();
}

class _KafiilState extends State<Kafiil> {
  late final WebViewController _controller;
  late Kafiilprovider _Kafiilprovider;

  @override
   void initState() {
    super.initState();
    _Kafiilprovider = provider.Provider.of<Kafiilprovider>(context, listen: false);
_Kafiilprovider.initWebView(context);
  }

void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
    _Kafiilprovider.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
  backgroundColor: Color(0xFF1DBF73),
          title:  Text('كفيل',
 style: TextStyle_(
              fontSize: 20,
              color: const Color.fromARGB(255, 255, 255, 255),
            )
),
          actions: <Widget>[
            NavigationControls(webViewController: _Kafiilprovider.WebViewController_),
          ],
        ),
        body: WebViewWidget(controller: _Kafiilprovider.WebViewController_),
       drawer: Drawer_app(),
        floatingActionButton: _Kafiilprovider.favoriteButton(context),
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
