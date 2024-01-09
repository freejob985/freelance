
import 'dart:io';

import 'package:flutter/material.dart';

class BottomAppBar_ extends StatelessWidget {
  const BottomAppBar_({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
Navigator.pushNamed(context, 'Home');
              // Handle home button tap
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
Navigator.pushNamed(context, 'Offers');
              // Handle search button tap
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
Navigator.pushNamed(context, 'Words');
              // Handle favorite button tap
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
                 exit(0);


              // Handle profile button tap
            },
          ),
        ],
      ),
    );
  }
}
