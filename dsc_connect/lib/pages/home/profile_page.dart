import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // late DocumentSnapshot<Map<String, dynamic>> data;
  bool isDataLoaded = false;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    log("now getting data from servers!");
    return await db.collection("users").doc(uid).get();
  }

  late DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    // getUserData();
    // log(data["user"]);

    if(!isDataLoaded)
      {
        getUserData().then((value) {
          data = value;
          isDataLoaded = true;
          setState(() {});
        });
      }

    if (!isDataLoaded) {
      return const Text(
        "Still Loading data",
        style: TextStyle(color: Colors.white),
      );
    } else if(FirebaseAuth.instance.currentUser==null) {
      Navigator.pushNamedAndRemoveUntil(context, MyRoutes.loginRoute, (route) => false);
      return const Text("You are not Logged in!");
    }else {
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: ProfilePic(icon: Icon(Icons.edit)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data["username"],
                style: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 0),
              child: Text(
                data["phone number"],
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 0, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          "About: - ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Expanded(
                          child: Text(
                            data["about"],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 20, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          "Mail: - ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Expanded(
                          child: Text(
                            FirebaseAuth.instance.currentUser!.email!.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ProfilePageButtons().build(
                          context,
                          "Manage Social Media links",
                          const Icon(Icons.arrow_back, color: Colors.white),
                          () {}),
                      ProfilePageButtons().build(
                          context,
                          "Terms and Conditions",
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          () {}),
                      ProfilePageButtons().build(
                          context,
                          "Contact Us",
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          () {}),
                      ProfilePageButtons().build(
                          context,
                          "Change Password",
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          () {}),
                      ProfilePageButtons().build(
                          context,
                          "Log Out",
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ), () async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushNamedAndRemoveUntil(context,
                                MyRoutes.loginRoute, (route) => false));
                      }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

class ProfilePageButtons {
  Widget build(BuildContext context, String buttonTitle, Icon icon,
      Function() function) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06313f)),
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 15, 0, 15),
            child: Text(
              buttonTitle,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  final Icon icon;

  const ProfilePic({Key? key, required this.icon}) : super(key: key);

  editProfile(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.editProfile);
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

// class LogOutButton extends StatelessWidget {
//   const LogOutButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06313f)),
//       child: Row(
//         children: const [
//           Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 15, 0, 15),
//             child: Text(
//               "Log Out",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ChangePassword extends StatelessWidget {
//   const ChangePassword({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06313f)),
//       child: Row(
//         children: const [
//           Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 15, 0, 15),
//             child: Text(
//               "Change Password",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TermsAndConditions extends StatelessWidget {
//   const TermsAndConditions({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06313f)),
//       child: Row(
//         children: const [
//           Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 15, 0, 15),
//             child: Text(
//               "Terms and Conditions",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ContactUs extends StatelessWidget {
//   const ContactUs({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06313f)),
//       child: Row(
//         children: const [
//           Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(18.0, 15, 0, 15),
//             child: Text(
//               "Contact Us",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
