import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _aboutController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _aboutController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  Image.asset(
                    "assets/images/gdsc.png",
                    width: 130,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Add your details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Text(
                "Just a few more details",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter Username",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle: TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Username"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Username";
                    }
                    return null;
                  },
                  controller: _usernameController,
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter phone number",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle: TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Phone Number"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Phone Number";
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter About",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle: TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Enter Something About You"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter About";
                    }
                    return null;
                  },
                  controller: _aboutController,
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,18.0),
                child: ElevatedButton(
                  onPressed: () async{
                    if(_formState.currentState!.validate())
                      {
                        EasyLoading.show(status: "Submitting");
                        Map<String, dynamic> map = <String, dynamic>{
                          "username": _usernameController.text,
                          "phone number": _phoneNumberController.text,
                          "about": _aboutController.text
                        };

                        var ref = FirebaseFirestore.instance.collection("users").doc(uid);
                        var doc = await ref.get();
                        if(doc.exists)
                        {
                          ref.update(map).then((value) => log("updated data into doc"));
                        }else{
                          ref.set(map).then((value) => log("added data into new doc"));
                        }

                        EasyLoading.dismiss();
                        if(!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
                      }
                  },
                  child: const Text("Submit")
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

