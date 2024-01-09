    import 'package:flutter/material.dart';
import 'package:freelance/Provider/OffersProvider.dart';

import 'kit.dart';

List<IconData> icons = [
      Icons.star,
      Icons.favorite,
      Icons.camera,
      Icons.home,
      Icons.access_alarm,
      Icons.ac_unit,
      Icons.brightness_6,
      Icons.directions_bike,
      Icons.shopping_cart,
      Icons.phone,
      Icons.restaurant,
      Icons.palette,
    ];

    List<String> buttonTexts = [
      'خمسات',
      'مستقل',
      'نفذلي',
      'كفيل',
      'لينكد ان',
      'كلمات دلالية',
      'ساعد',
      'عروض 12' ,
      'اعدادت',
      'شغل اون لاين',
      'سحب بيانات',
      'تسجيل خروج',
    ];

    List<Color> buttonColors = [
      Color(0xFF444444),
      Color(0xFF45A3E2),
      Color.fromARGB(255, 255, 255, 255),
      Color(0xFF1DBF73),
      Color(0xFF3292C9),
      Colors.teal,
      Color(0xFF4D245F),
    Color.fromARGB(255, 56, 82, 155),
      Colors.cyan,
    Color(0xFF6C8DE4),
      Colors.pink,
      Colors.lime,
    ];
  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.home, 'title': 'كلمات دلالية', 'route': 'Words'},
    {'icon': Icons.shopping_cart, 'title': 'خمسات', 'route': 'Khamsat'},
    {'icon': Icons.work, 'title': 'مستقل', 'route': 'Mostaql'},
    {'icon': Icons.security, 'title': 'كفيل', 'route': 'Kafiil'},
    {'icon': Icons.business, 'title': 'نفذلي', 'route': 'Nafezly'},
    {'icon': Icons.local_offer, 'title': 'العروض', 'route': 'Offers'},
    {
      'icon': Icons.shopping_basket,
      'title': 'أريد',
      'route': 'https://ureed.com/',
      'color': Color(0xFF18181B)
    },
    {
      'icon': Icons.favorite,
      'title': 'ساعد',
      'route': 'https://www.sa3idd.com/',
      'color': Color(0xFF4D245F)
    },
    {
      'icon': Icons.work_outline,
      'title': 'شغل اون لاين',
      'route': 'https://shoghlonline.com/',
      'color': Color(0xFF968BED)
    },
    {
      'icon': Icons.link,
      'title': 'لينكد ان',
      'route': 'https://www.linkedin.com/feed/',
      'color': Color(0xFF0866C2)
    },
    // Add more items as needed
  ];

  List<Function> route_list(BuildContext context, OffersProvider _offersProvider) {
    List<Function> buttonFunctions = [
      () =>{ Navigator.pushNamed(context, 'Khamsat')},
      () =>{ Navigator.pushNamed(context, 'Mostaql')},
      () => { Navigator.pushNamed(context, 'Nafezly')},
      () => { Navigator.pushNamed(context, 'Kafiil')},
      () => { scren_webview(context,"https://www.linkedin.com/feed/","لينكد ان",Color(0xFF0866C2))},
      () => { Navigator.pushNamed(context, 'Words')},
      () => { scren_webview(context,"https://www.sa3idd.com/","منصة ساعد",Color(0xFF4D245F))},
      () => { Navigator.pushNamed(context, 'Offers')},
      () => { Navigator.pushNamed(context, 'Settings')},
      () => { scren_webview(context,"https://shoghlonline.com/"," شغل اون لاين",Color(0xFF968BED))},
      () => {     
     _offersProvider.executeFreelancingOrderKhamsat(),
      _offersProvider.executeFreelancingOrdermostaql(),
    _offersProvider.executeFreelancingOrderKhamsat(),
    _offersProvider.executeFreelancingOrdernafezly(),
       showNotification(context,
                                          title: "",
                                          message: "تم جلب البيانات بنجاح ")
    }
    ,
    
      () => { print("OK")},
    ];
    return buttonFunctions;
  }


    List<Object> items = [
      "https://khamsat.hsoubcdn.com/assets/images/logo-73045c76e830509d4dbe03ea6172d22f047c708fed5435e93ffd47f80ee5ffa4.png",
      "https://mostaql.hsoubcdn.com/public/assets/cards/facebook@2x.png",
      "https://nafezly.com/site_images/title.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStFy9wgI7JtgvJhRcZIg4R25DCOrmjvN7SFw&usqp=CAU",
      "https://maxishow69.com/wp-content/uploads/2023/03/c7fa3586-0a41-48be-b811-833b4c841749.jpg",
      Icons.directions_bike,
      "https://www.sa3idd.com/_next/image?url=https%3A%2F%2Fmwsapi.sa3idd.com%2Fstorage%2F543183291498687.png&w=256&q=75",
      Icons.directions_bike,
      Icons.shopping_cart,
      "https://s3.eu-west-3.amazonaws.com/shoghlonline.com/wp-content/uploads/2021/04/White-Logo-1024x346-1.png",
      Icons.restaurant,
      Icons.palette,
    ];
