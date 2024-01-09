import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Models/presentation.dart';
import 'package:freelance/Provider/presentationprovider.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart' as provider;


class PresentationEdit extends StatefulWidget {
  final int id;
  final presentation item;


  PresentationEdit({Key? key, required this.id, required this.item}) : super(key: key);

  @override
  State<PresentationEdit> createState() => _PresentationEditState();
}

class _PresentationEditState extends State<PresentationEdit> {
  final TextEditingController _textEditingController = TextEditingController();
  late Presentationprovider _presentation;

  @override

  void initState() {
    super.initState();
  _presentation =
        provider.Provider.of<Presentationprovider>(context, listen: false);
_textEditingController.text=widget.item.offer;

  }

void dispose() {
    // تحرير الموارد عند إغلاق الواجهة
  //   _presentation.dispose();
  //  _textEditingController.dispose();
  //   super.dispose();
  }
  Widget build(BuildContext context) {
    return Directionality(
textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 103, 207, 107),
          title:  Text('تعديل العرض ', style: TextStyle_(
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextFormField لتحرير النص
              TextFormField(
    style: TextStyle_(fontSize: 15),
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter your presentation',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 16),
              // زر لتحديث البيانات
              ElevatedButton(
                onPressed: () {
    
    _presentation.updatePresentation( _textEditingController.text, widget.id, context);
                },
                child: Text('Update Data'),
              ),
            ],
          ),
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
