import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'dart:developer';

import 'package:flutter_signin_button/button_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  loginFun(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Processing Your Request")));
      });

      // log((FirebaseAuth.instance.currentUser == null).toString());

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        await Navigator.pushNamedAndRemoveUntil(
            context, MyRoutes.homeRoute, (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        log("An exception in login occurred!!");

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(e.message.toString()));
            });
      }
    }
  }

  String name = "";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    hintText: "Enter Email",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle: TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Email"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Email";
                    }
                    return null;
                  },
                  controller: _emailController,
                ),
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
                  controller: _passwordController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0,0,0,10),
                    child: InkWell(
                      onTap: ()async{
                        await Navigator.popAndPushNamed(context, MyRoutes.signupRoute);
                      },
                      child: const Text(
                          "New to DSC Connect? Create account now!",
                        style: TextStyle(
                          color: Color(0XFF40d886),
                          fontSize: 15
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,18.0),
                child: ElevatedButton(
                    onPressed: () {
                      loginFun(context, _emailController, _passwordController);
                    },
                    child: const Text("Log In")
                ),

              ),SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Implementation pending")));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(
                    Buttons.GitHub,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Implementation pending")));
                    },
                  ),
                )
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
