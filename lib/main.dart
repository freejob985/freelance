import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freelance/Provider/CustomLinkprovider.dart';
import 'package:freelance/Provider/Khamsatprovider.dart';
import 'package:freelance/Provider/Mostaqlprovider.dart';
import 'package:freelance/Provider/OffersProvider.dart';
import 'package:freelance/Provider/RequestsProvider.dart';
import 'package:freelance/Provider/Settingsprovider.dart';
import 'package:freelance/Provider/Wordsprovider.dart';
import 'package:freelance/Provider/kafiilprovider.dart';
import 'package:freelance/Provider/nafezlyprovider.dart';
import 'package:freelance/Provider/presentationprovider.dart';
import 'package:freelance/Screens/%20Presentation-edit.dart';
import 'package:freelance/Screens/Home.dart';
import 'package:freelance/Screens/Offers.dart';
import 'package:freelance/Screens/Settings.dart';
import 'package:freelance/Screens/kafiil.dart';
import 'package:freelance/Screens/khamsat.dart';
import 'package:freelance/Screens/mostaql.dart';
import 'package:freelance/Screens/nafezly.dart';
import 'package:freelance/Screens/presentation.dart';
import 'package:freelance/Screens/test.dart';
import 'package:freelance/Screens/words.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const start());
}

class start extends StatelessWidget {
  const start({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RequestsProvider()),
        ChangeNotifierProvider(create: (_) => OffersProvider()),
        ChangeNotifierProvider(create: (_) => Wordsprovider()),
        ChangeNotifierProvider(create: (_) => Wordsprovider()),
        ChangeNotifierProvider(create: (_) => Presentationprovider()),
        ChangeNotifierProvider(create: (_) => Khamsatprovider()),
        ChangeNotifierProvider(create: (_) => Mostaqlprovider()),
        ChangeNotifierProvider(create: (_) => Nafezlyprovider()),
      ChangeNotifierProvider(create: (_) => Kafiilprovider()),
      ChangeNotifierProvider(create: (_) => CustomLinkprovider()),
      ChangeNotifierProvider(create: (_) => Settingsprovider()),


      ],
      child: MaterialApp(
        routes: {
          'Home': (context) => const Home(),
          'Offers': (context) => const Offers(),
          'Khamsat': (context) => const Khamsat(),
          'Mostaql': (context) => const Mostaql(),
          'Kafiil': (context) => const Kafiil(),
          'Nafezly': (context) => const Nafezly(),
          'Words': (context) => const Words(),
          'Presentation': (context) => const Presentation(),
          'Test': (context) => const Test(),
          'Home': (context) => const Home(),
          'Settings': (context) => const Settings(),

        },
        initialRoute: 'Settings',
        debugShowCheckedModeBanner: false,
      ),  
    );
  }
}
