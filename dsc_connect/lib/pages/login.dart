import 'package:flutter/material.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  loginFun(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Processing Your Request")));
      });
    }
  }

  String name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Text(
              "Hey There... Let's get you started!!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 10),
              child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter username",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Username"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Username";
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 10),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle:
                        TextStyle(color: Color(0xFFF7D9D9), fontSize: 16)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // log("sadfafdasdfafd");
                    return "Enter a password.";
                  } else if (value.length < 8) {
                    return "Enter a password of 8 or more length.";
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  loginFun(context);
                },
                child: const Text("Log In"))
          ],
        ),
      ),
    ));
  }
}
