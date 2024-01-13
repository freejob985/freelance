import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Provider/OffersProvider.dart';
import 'package:freelance/Provider/Settingsprovider.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int? totalRecords;
  int? offer;
  bool isLoading = false;
  late OffersProvider _offersProvider;

  @override
  void initState() {
    _offersProvider = Provider.of<OffersProvider>(context, listen: false);
    super.initState();
    greet();
  }

  void greet() async {
    setState(() {
      isLoading = true;
    });

    int? result =
        await Provider.of<Settingsprovider>(context, listen: false)
            .fetchTotalRecords();
    final Map<String, dynamic> data =
        await Provider.of<Settingsprovider>(context, listen: false)
            .fetchData("order");

    setState(() {
      totalRecords = result ?? 0;
      offer = data['count'] ?? 0;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF67CF6B),
          title: Text(
            'اعدادت',
            style: TextStyle_(fontSize: 25, color: Colors.white),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildElevatedButton(
                      onPressed: () {
                        Provider.of<Settingsprovider>(context, listen: false)
                            .fetchTotalRecords();
                      },
                      primary: Colors.blue,
                      icon: Icons.settings,
                      label: 'عدد العروض الكلي :  ${totalRecords ?? ''}',
                    ),
                    SizedBox(height: 16.0),
                    buildElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Offers');
                      },
                      primary: Colors.green,
                      icon: Icons.color_lens,
                      label: 'العروض المتاحة :  $offer',
                    ),
                    SizedBox(height: 16.0),
                    buildElevatedButton(
                      onPressed: () async {
                        final Map<String, dynamic> datax =
                            await Provider.of<Settingsprovider>(context,
                                    listen: false)
                                .deleteAllData("deleteAllData");
                        greet();
                        showNotification(
                            context, title: "", message: datax['message']);
                      },
                      primary: Colors.orange,
                      icon: Icons.brightness_6,
                      label: 'حذف العروض',
                    ),
                    SizedBox(height: 16.0),
                    buildElevatedButton(
                      onPressed: () {
greet();
                        _offersProvider.executeFreelancingOrderKhamsat();
                        _offersProvider.executeFreelancingOrdermostaql();
                        _offersProvider.executeFreelancingOrderKhamsat();
                        _offersProvider.executeFreelancingOrdernafezly();
                      },
                      primary: Colors.purple,
                      icon: Icons.notifications,
                      label: 'أعادة تنشيط',
                    ),
                    SizedBox(height: 16.0),
                    buildElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Archives');
                      },
                      primary: Colors.red,
                      icon: Icons.security,
                      label: 'ارشيف السحب',
                    ),
                  ],
                ),
              ),
        drawer: Drawer_app(),
        bottomNavigationBar: BottomAppBar_(),
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required Color primary,
    required IconData icon,
    required String label,
  }) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: primary,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: primary),
            ),
          ),
          child: buildButtonContent(icon, label),
        ),
      ),
    );
  }

  Widget buildButtonContent(IconData icon, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      textDirection: TextDirection.ltr,
      children: [
        Text(
          label,
          style: TextStyle_(fontSize: 15, color: Colors.white),
        ),
        SizedBox(width: 8.0),
        Icon(icon, color: Colors.white),
      ],
    );
  }
}
