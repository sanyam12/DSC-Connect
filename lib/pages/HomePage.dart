import 'dart:developer';

import 'package:dsc_connect/pages/home/announcements.dart';
import 'package:dsc_connect/pages/home/profile_page.dart';
import 'package:dsc_connect/pages/home/queries.dart';
import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(color: Colors.white);

  static const List<Widget> _widgetOptions = <Widget>[
    AnnouncementsPage(),
    QueriesPage(),
    ProfilePage(),
  ];

  Future<bool> isUserLogged()async{
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null)
      {
        try {
          String? tokenResult = await firebaseUser.getIdToken(true);
        } on Exception catch (e) {
          return false;
        }
        return true;
      }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    isUserLogged();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DSC Connect",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Announcements"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Query Corner"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Profile"
          ),

        ],

        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        selectedItemColor: const Color(0xFF40d886),
      ),

    );
  }
}


// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//
// }
