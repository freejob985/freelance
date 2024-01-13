import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freelance/Helper_functions/SessionManager.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Models/words.dart';
import 'package:freelance/Provider/Wordsprovider.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';

class Words extends StatefulWidget {
  const Words({Key? key}) : super(key: key);

  @override
  _WordsState createState() => _WordsState();
}

class _WordsState extends State<Words> {
  late Wordsprovider _words;
  final TextEditingController _keywordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _words = provider.Provider.of<Wordsprovider>(context, listen: false);
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      isLoading = true;
    });

    await _words.fetchData();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 103, 207, 107),
          title: Text(
            'الكلمات الدلالية',
            style: TextStyle_(
              fontSize: 20,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer<Wordsprovider>(
            builder: (context, myType, child) {
              return isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: myType.word.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = myType.word[index];
                        int? id = item.id;
                        String? words = item.words;

                        return Container(
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (val) {
                                    _words.delate_row(id.toString(), context);
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red.shade300,
                                  borderRadius: BorderRadius.circular(0),
                                )
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (val) {
                                    SessionManager.setSession(
                                        'Presentation', id.toString());
                                    Navigator.pushNamed(context, "Presentation");
                                  },
                                  icon: Icons.opacity_outlined,
                                  backgroundColor: Color.fromARGB(255, 69, 146, 100),
                                  borderRadius: BorderRadius.circular(0),
                                )
                              ],
                            ),
                            child: GestureDetector(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                color: const Color.fromARGB(255, 227, 229, 230),
                                child: ListTile(
                                  leading: Icon(Icons.text_fields),
                                  title: Text(
                                    words ?? '',
                                    style: TextStyle_(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
        drawer: Drawer_app(),
        bottomNavigationBar: BottomAppBar_(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _words.showDialogx(_keywordController, context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }
}
