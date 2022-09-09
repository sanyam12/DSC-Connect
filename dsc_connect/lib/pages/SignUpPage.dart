import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'dart:developer';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  loginFun(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController,
      TextEditingController _fullNameController) async {
    if (_formKey.currentState!.validate()) {

      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Processing Your Request")));
      });

      try {
        final credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        await Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
      } on FirebaseAuthException catch (e) {
        log("An exception in signup occurred!!");

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
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // initialiseFirebase();
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
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                "Hey There... $name",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 38, 18, 0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter Full Name",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    errorStyle: TextStyle(color: Color(0xFFF7D9D9), fontSize: 16),
                    label: Text("Full Name"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                    setState(() {});
                  },
                  controller: _fullNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 10),
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
                    } else {
                      if (!value.contains("@")) {
                        return "Enter valid Mail address";
                      }
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
                    padding: const EdgeInsets.fromLTRB(18.0,0,0,18),
                    child: InkWell(
                      onTap: ()async{
                        await Navigator.popAndPushNamed(context, MyRoutes.loginRoute);
                      },
                      child: const Text(
                        "Already have an account? Log In here",
                        style: TextStyle(
                          color: Color(0xFF40d886),
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    loginFun(context, _emailController, _passwordController,
                        _fullNameController);
                  },
                  child: const Text("Sign Up")),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 18.0, 0, 18.0),
                child: Text(
                  "Or Sign In With",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SignInButton(
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
    // Clean up the controller when the widget is disposed.
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
