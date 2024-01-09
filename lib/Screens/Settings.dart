import 'package:flutter/material.dart';
import 'package:freelance/Helper_functions/function.dart';
import 'package:freelance/Helper_functions/kit.dart';
import 'package:freelance/Provider/OffersProvider.dart';
import 'package:freelance/Provider/Settingsprovider.dart';
import 'package:freelance/Widget/BottomAppBar_.dart';
import 'package:freelance/Widget/Drawer_app.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as provider;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int? totalRecords;
  int? offer;
  bool isLoading = false;
  late OffersProvider _OffersProvider;


  void greet() async {
    setState(() {
      isLoading = true;
    });

    int? result = await Provider.of<Settingsprovider>(context, listen: false).fetchTotalRecords();
    final Map<String, dynamic> data = await Provider.of<Settingsprovider>(context, listen: false).fetchData("order");

    setState(() {
      totalRecords = result ?? 0;
      offer = data['count'] ?? "";
      isLoading = false;
    });
  }

  @override
  void initState() {
 _OffersProvider =
        provider.Provider.of<OffersProvider>(context, listen: false);
    super.initState();
    greet();
  }

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
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<Settingsprovider>(context, listen: false).fetchTotalRecords();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                          child: buildButtonContent(Icons.settings, 'عدد العروض الكلي :  ${totalRecords ?? ''}'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, 'Offers');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.greenAccent),
                            ),
                          ),
                          child: buildButtonContent(Icons.color_lens, 'العروض المتاحة :  $offer'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final Map<String, dynamic> datax =
                                await Provider.of<Settingsprovider>(context, listen: false).deleteAllData("deleteAllData");
                            greet();

                            showNotification(context, title: "", message: datax['message']);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.orangeAccent),
                            ),
                          ),
                          child: buildButtonContent(Icons.brightness_6, 'حذف العروض'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
    //  _offersProvider.executeFreelancingOrderKhamsat();
    //   _offersProvider.executeFreelancingOrdermostaql();
    // _offersProvider.executeFreelancingOrderKhamsat();
    // _offersProvider.executeFreelancingOrdernafezly();

Provider.of<OffersProvider>(context, listen: false).executeFreelancingOrderKhamsat();
Provider.of<OffersProvider>(context, listen: false).executeFreelancingOrdermostaql();
Provider.of<OffersProvider>(context, listen: false).executeFreelancingOrderKhamsat();
Provider.of<OffersProvider>(context, listen: false).executeFreelancingOrdernafezly();


                            Navigator.pushNamed(context, 'Settings');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.purpleAccent),
                            ),
                          ),
                          child: buildButtonContent(Icons.notifications, 'أعادة تنشيط'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.redAccent),
                            ),
                          ),
                          child: buildButtonContent(Icons.security, 'Security'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        drawer: Drawer_app(),
        bottomNavigationBar: BottomAppBar_(),
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
