import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Provider/OffersProvider.dart';
import 'package:freelance/Screens/Customlink.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  late OffersProvider _OffersProvider;
  final TextEditingController _keywordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _OffersProvider =
        provider.Provider.of<OffersProvider>(context, listen: false);
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    await _OffersProvider.fetchData();

    setState(() {
      isLoading = false;
    });
  }

  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'عروض',
            style: TextStyle_(
              fontSize: 20,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 103, 207, 107),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<OffersProvider>(
                builder: (context, itemList, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 126, 214, 129),
                    ),
                    child: ListView.builder(
                      itemCount: itemList.free.length,
                      itemBuilder: (context, index) {
                        final item = itemList.free[index];
                        int? id = item.id;
                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color.fromRGBO(241, 236, 236, 1)
                                            .withOpacity(0.5),
                                        width: 2.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 199, 199, 199)
                                              .withOpacity(0.1),
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        imageUrl: item.picture,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        _OffersProvider.getLimitedWordsText(
                                            item.text, 6),
                                        style: TextStyle_(fontSize: 12),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            var x = await _OffersProvider.fetchOffer(
                                                item.keywords);
                                            String result = await x.join();
                                            Clipboard.setData(
                                                ClipboardData(text: result));
                                            showNotification(context,
                                                title: "",
                                                message: "تم نسخ العرض $result");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 4.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            fixedSize: Size(
                                                80.0, 5.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Center(
                                                  child: Icon(Icons.photo_camera,
                                                      color: Colors.white,
                                                      size: 16.0)),
                                              SizedBox(width: 1.0),
                                              Center(
                                                  child: Text('نسخ العرض',
                                                      style: TextStyle_(
                                                          fontSize: 10,
                                                          color: Colors.white))),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await _OffersProvider.updateFreelancing(
                                                item.id);
                                            showNotification(context,
                                                title: "", message: "تم ارشفة العرض");
                                            _OffersProvider.fetchData();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 8.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.share,
                                                  color: Colors.white, size: 16.0),
                                              SizedBox(width: 2.0),
                                              Text(item.keywords,
                                                  style: TextStyle_(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              var x =
                                                  await _OffersProvider.fetchOffer(
                                                      item.keywords);
                                              String result = await x.join();
                                              Clipboard.setData(
                                                  ClipboardData(text: result));
                                              String url = item.Link;
                                              String text = item.text;
                                              scren_webview(context, url, text);
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 8.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.comment,
                                                  color: Colors.white, size: 16.0),
                                              SizedBox(width: 2.0),
                                              Text(item.sort,
                                                  style: TextStyle_(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        drawer: Drawer_app(),
        bottomNavigationBar: BottomAppBar_(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _OffersProvider.showDialogx(_keywordController, context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void scren_webview(BuildContext context, String url, String text) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomLink(url: url, text: text),
      ),
    );
  }
}
