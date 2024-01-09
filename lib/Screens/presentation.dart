import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Models/presentation.dart';
import 'package:freelance/Provider/presentationprovider.dart';
import 'package:freelance/Screens/%20Presentation-edit.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

class Presentation extends StatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  late Presentationprovider _presentation;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _presentation =
        provider.Provider.of<Presentationprovider>(context, listen: false);
    _presentation.fetchData();
    _textEditingController = TextEditingController();
  }

  void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
    // _presentation.dispose();
    // _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
    backgroundColor: Color.fromARGB(255, 103, 207, 107),
          title: Text('العروض',
              style: TextStyle_(
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 255, 255),
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter your presentation',
                  border: OutlineInputBorder(),
                  hintMaxLines: 5,
                ),
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
 style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 103, 207, 107),// لون الخلفية للزر
    onPrimary: Colors.white, // لون النص على الزر
  ),
                  onPressed: () async {
                    // حفظ البيانات هنا
                    String presentationText = _textEditingController.text;
                    _presentation.addPresentation(presentationText, context);
                    _textEditingController.clear();
    
                    Map<String, dynamic> result =
                        await _presentation.addPresentation(
                      presentationText,
                      context,
                    );
    
                    if (result.containsKey('error')) {
                      showNotification(context,
                          title: "",
                          message: result['error'].toString(),
                          success: false);
                      // Handle error
                      _presentation.fetchData();
                      print('Error: ${result['error']}');
                    } else {
                      // Handle success
                      //  showNotification(context,
                      //       title: "", message: , success: false);
                      showNotification(context,
                          title: "", message: result.toString(), success: true);
                      _presentation.fetchData();
                      print('Success: $result');
                    }
    
                    // عرض الشاشة الجديدة
                  },
                  icon: Icon(Icons.save),
                  label: Text('حفظ',
style: TextStyle_( fontSize: 15 ,color: Colors.white)),
                ),
              ],
            ),
            Expanded(
              child: Consumer<Presentationprovider>(
                builder: (context, myType, child) {
                  return ListView.builder(
                    itemCount: myType.pres.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = myType.pres[index];
                      int? id = item.id;
                      String? words = item.offer;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PresentationEdit(id: id!, item: item),
                            ),
                          );
                        },
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (val) {
                                  _presentation.delate_row(
                                      id.toString(), context);
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red.shade300,
                                borderRadius: BorderRadius.circular(0),
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(Icons.slideshow),
                            title: Text(words,
style: TextStyle_( fontSize: 15)),
                            // Add more details or interactions here
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer_app(),
      bottomNavigationBar: BottomAppBar_(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
                Navigator.pushNamed(context, "Words");

          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
