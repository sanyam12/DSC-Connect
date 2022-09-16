import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_connect/pages/home/announcements/about_announcements.dart';
import 'package:dsc_connect/pages/home/query/query_details.dart';
import 'package:dsc_connect/utils/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QueriesPage extends StatefulWidget {
  const QueriesPage({Key? key}) : super(key: key);

  @override
  State<QueriesPage> createState() => _QueriesPageState();
}

class _QueriesPageState extends State<QueriesPage> {
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
              stream: db.collection("queries").snapshots(),
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
                                      builder: (context) => QueryDetails(ds: ds)
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ds["category"].toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),

                                      Text(
                                        "${ds["date"].toString()} ${ds["time"].toString()}",
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    ds["query"].toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
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
          Navigator.pushNamed(context, MyRoutes.newQueryPage);
        },
        label: const Text("New Query"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
