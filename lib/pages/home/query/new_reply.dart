import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NewReplyPage extends StatefulWidget {
  final DocumentSnapshot ds;
  const NewReplyPage({Key? key, required this.ds}) : super(key: key);

  @override
  State<NewReplyPage> createState() => _NewReplyPageState();
}

class _NewReplyPageState extends State<NewReplyPage> {

  final _formState = GlobalKey<FormState>();
  final _answerController = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Answer"),
      ),

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
                        hintText: "Enter Answer",
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                        errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                        label: Text("Answer"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Answer";
                        }
                        return null;
                      },
                      maxLines: null,
                      minLines: 4,
                      controller: _answerController,
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
                              "date": date,
                              "time": time,
                              "reply": _answerController.text
                            };

                            var temp = await db.collection("queries")
                                .doc(widget.ds.id)
                                .collection("replies")
                                .add(map);
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
