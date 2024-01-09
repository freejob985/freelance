import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Screens/Customlink.dart';
import 'package:freelance/Widget/list.dart';

class Drawer_app extends StatelessWidget {
  Drawer_app({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
    DrawerHeader(
  decoration: BoxDecoration(
    color: Color(0xFF71d070),
    image: DecorationImage(
      image: AssetImage('assets/images/a.jpg'), // قم بتعيين مسار الصورة هنا
      fit: BoxFit.fitWidth, // اختياري: يمكنك تعديل الطريقة التي تظهر بها الصورة
    ),
  ),
  child: GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'Home');
    },

  ),
),

          for (var item in drawerItems)
            Column(
              children: [
                ListTile(
                  leading: Icon(item['icon']),
                  title: Text(
                    item['title'],
                    style: TextStyle_(
                      fontSize: 15,
                      color: Color.fromARGB(255, 89, 89, 89),
                    ),
                  ),
                  onTap: () {
                    if (item['route'].startsWith('http')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomLink(
                            url: item['route'], text: item['title'],
                            backgroundColor: item[
                                'color'], // Pass the color parameter to CustomLink
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, item['route']);
                    }
                  },
                ),
                Divider(
                  color: Color.fromARGB(255, 226, 225, 225),
                  thickness: 1,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
