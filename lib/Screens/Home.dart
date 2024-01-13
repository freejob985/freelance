import 'package:flutter/material.dart';
import 'package:freelance/Provider/OffersProvider.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:freelance/Widget/kit.dart';
import 'package:freelance/Widget/list.dart';
import 'package:provider/provider.dart' as provider;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final OffersProvider _offersProvider =
        provider.Provider.of<OffersProvider>(context);

    // Define lists for icons, texts, and colors
    List<Function> buttonFunctions = route_list(context, _offersProvider);


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF67CF6B),
          title: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Text(
              'الصفحة الرئيسية',
              style: TextStyle_(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            Object item = items[index];

            Widget buttonChild;

            if (item is IconData) {
              // عنصر الأيقونة
              IconData iconData = item;
              Color buttonColor = buttonColors[index];
              buttonChild = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData, size: 36.0),
                  SizedBox(height: 8.0),
                  Text(buttonTexts[index],
                      style: TextStyle_(fontSize: 20, color: Colors.white)),
                ],
              );
            } else if (item is String) {
              // عنصر الصورة من رابط على الإنترنت
              String imageUrl = item;
              buttonChild = Image.network(imageUrl, fit: BoxFit.cover);
            } else {
              // عنصر غير معروف
              buttonChild = Container();
            }

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: buttonColors[index],
                onPrimary: Colors.white,
              ),
              onPressed: () {
                buttonFunctions[index]();

                print('Button $index pressed!');
              },
              child: buttonChild,
            );
          },
        ),
        drawer: Drawer_app(),
        // bottomNavigationBar: BottomAppBar_(),
      ),
    );
  }
}
