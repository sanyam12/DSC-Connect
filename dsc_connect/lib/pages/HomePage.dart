import 'dart:developer';

import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DSC Connect"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Hello World",
              style: TextStyle(color: Colors.white
              ),
            ),

            //sign out button (temporary)
            ElevatedButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut().onError((error, stackTrace){log(error.toString());});
              await Navigator.pushNamedAndRemoveUntil(context, MyRoutes.loginRoute, (route) => false);
            },
                child: const Text("Sign Out"))
          ],
        ),
      )

    );
  }
}
