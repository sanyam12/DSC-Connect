import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NewQueryPage extends StatefulWidget {
  const NewQueryPage({Key? key}) : super(key: key);

  @override
  State<NewQueryPage> createState() => _NewQueryPageState();
}

class _NewQueryPageState extends State<NewQueryPage> {

  final _titleController = TextEditingController();
  final _queryController = TextEditingController();
  final _categoryController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _titleController.dispose();
    _queryController.dispose();
    _categoryController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Query"),),
      body: SingleChildScrollView(
        child: Center(
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,40.0,0,0),
                    child: SvgPicture.asset(
                      "assets/images/new_messages.svg",
                      width: 200,
                    ),
                  ),
                  //textDormFields
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Enter Title",
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                        label: Text("Title"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Title";
                        }
                        return null;
                      },
                      controller: _titleController,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Enter Category",
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                        label: Text("Category"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Category";
                        }
                        return null;
                      },
                      controller: _categoryController,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Enter Query",
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                        label: Text("Query"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Query";
                        }
                        return null;
                      },
                      maxLines: null,
                      minLines: 4,
                      controller: _queryController,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: ()async{
                          if(_formState.currentState!.validate())
                          {
                            EasyLoading.show(status: "Loading");
                            String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
                            String time = TimeOfDay.now().format(context);
                            Map<String, dynamic> map = <String, dynamic> {
                              "title": _titleController.text,
                              "query": _queryController.text,
                              "category":_categoryController.text,
                              "date": date,
                              "time": time
                            };

                            var temp = await db.collection("queries").add(map);
                            EasyLoading.dismiss();
                            if(!mounted) return;
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Submit",
                        )
                    ),
                  ),



                ],
              ),
            )
        ),
      ),
    );
  }
}
