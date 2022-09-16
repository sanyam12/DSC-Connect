import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NewAnnouncement extends StatefulWidget {
  const NewAnnouncement({Key? key}) : super(key: key);

  @override
  State<NewAnnouncement> createState() => _NewAnnouncementState();
}

class _NewAnnouncementState extends State<NewAnnouncement> {

  final _titleController = TextEditingController();
  final _datePicker = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _titleController.dispose();
    _datePicker.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Announcements"),),
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
                  child: TextField(
                    controller: _datePicker,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today, color: Colors.white,),
                      labelText: "Enter Date",
                      labelStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      errorStyle:
                      TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    ),
                    readOnly: true,
                    onTap: ()async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100)
                      );

                      if(pickedDate!=null)
                        {
                          String formattedDate = DateFormat("dd-MM-yyyy").format(pickedDate);
                          setState(() {
                            _datePicker.text = formattedDate;
                          });
                        }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter Location",
                      labelStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      errorStyle:
                      TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                      label: Text("Location"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Location";
                      }
                      return null;
                    },
                    controller: _locationController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter Description",
                      labelStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      hintStyle:
                      TextStyle(color: Colors.white, fontSize: 18),
                      errorStyle:
                      TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                      label: Text("Description"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Description";
                      }
                      return null;
                    },
                    maxLines: null,
                    minLines: 4,
                    controller: _descriptionController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()async{
                        if(_formState.currentState!.validate())
                          {
                            EasyLoading.show(status: "Loading");
                            Map<String, dynamic> map = <String, dynamic> {
                              "title": _titleController.text,
                              "date": _datePicker.text,
                              "location": _locationController.text,
                              "description":_descriptionController.text
                            };

                            var temp = await db.collection("announcements").add(map);
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
