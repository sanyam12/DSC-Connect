import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../utils/Routes.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _aboutController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  int length = 200;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DSC Connect"),
        ),
        body: Column(
          children: [
            const Center(
                child: ProfilePicEdit(
              icon: Icon(Icons.camera),
            )),
            Form(
                key: _formState,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Enter Username",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          errorStyle:
                              TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                          label: Text("New Username"),
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
                          hintText: "Enter Phone Number",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          errorStyle:
                              TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
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
                        decoration: InputDecoration(
                          hintText: "Enter About",
                          labelStyle:
                            TextStyle(color: length-200<=0?Colors.white:Colors.red, fontSize: 18),
                          hintStyle:
                              const TextStyle(color: Colors.white, fontSize: 18),
                          errorStyle:
                              const TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                          label: Text(
                              length<=200?"Enter About (${200-length})":"Enter About ${length-200}"
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter  About";
                          } else if(value.length>200){
                            return "About is too long";
                          }
                          return null;
                        },
                        controller: _aboutController,
                        onChanged: (value)
                        {
                          setState(() {
                            length = value.length;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _formState.currentState!.validate();
                        },
                        child: const Text("Submit")
                    )
                  ],
                ))
          ],
        ));
  }
}

class ProfilePicEdit extends StatelessWidget {
  final Icon icon;

  const ProfilePicEdit({Key? key, required this.icon}) : super(key: key);

  editProfile(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Implementation pending")));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        height: 125,
        child: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFE7E9EC),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/user.png",
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        editProfile(context);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(
                              side: BorderSide(
                                  color: Color(0xFF06313F), width: 4)),
                          minimumSize: const Size(50, 50)),
                      child: icon),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
