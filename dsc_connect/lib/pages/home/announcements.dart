import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_connect/pages/home/announcements/about_announcements.dart';
import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance;
  // double cardBorderRadius = 25;
  int lastTapped = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
          child: StreamBuilder(
              stream: db.collection("announcements").snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  EasyLoading.show(status: "Loading...");
                  return const Text("No Data!");
                } else {
                  EasyLoading.dismiss();
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Card(
                        color: const Color(0xFF3e7974),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(lastTapped==index?15:30)
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          onTapDown: (details){
                            setState(() {
                              lastTapped = index;
                            });
                          },
                          onTapUp: (details){
                            setState(() {
                              lastTapped = -1;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutAnnouncements(ds: ds)
                                  )
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0,8,8,8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ds["title"].toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  ds["date"].toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  ds["description"].toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.newAnnouncementPage);
        },
        label: const Text("New Announcements"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
