import 'dart:developer';

import 'package:dsc_connect/pages/home/query/new_reply.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../utils/Routes.dart';

class QueryDetails extends StatefulWidget {
  final DocumentSnapshot ds;

  const QueryDetails({Key? key, required this.ds}) : super(key: key);

  @override
  State<QueryDetails> createState() => _QueryDetailsState();
}

class _QueryDetailsState extends State<QueryDetails> {

  final db = FirebaseFirestore.instance;
  int lastTapped = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.ds["title"].toString(),
          maxLines: 1,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.ds["title"].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    softWrap: true,
                  ),
                ),
              ),


              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.ds["date"].toString() + " " +
                        widget.ds["time"].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    softWrap: true,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.ds["query"].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  softWrap: true,
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Category: - ${widget.ds["category"]}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.end,
                    softWrap: true,
                  ),
                ),
              ),

              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Replies",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    softWrap: true,
                  ),
                ),
              ),

              StreamBuilder(
                stream: db.collection("queries").doc(widget.ds.id).collection(
                    "replies").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    EasyLoading.show(status: "Loading...");
                    return const Text("No Data");
                  } else {
                    EasyLoading.dismiss();

                    var list = List.generate(snapshot.data!.docs.length, (index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Card(
                        color: const Color(0xFF3e7974),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(lastTapped==index?15:30)
                        ),
                        child: SizedBox(
                          width: double.infinity,
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
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12.0,8,8,8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${ds["date"].toString()} ${ds["time"].toString()}",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      ds["reply"].toString(),
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
                        ),
                      );
                    });
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: list,
                      ),
                    );

                    // for(var index in snapshot.data!.docs.length)
                    //   {
                    //     DocumentSnapshot ds = snapshot.data!.docs[index];
                    //     return Card(
                    //       color: const Color(0xFF3e7974),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(lastTapped==index?15:30)
                    //       ),
                    //       child: InkWell(
                    //         highlightColor: Colors.transparent,
                    //         splashFactory: NoSplash.splashFactory,
                    //         onTapDown: (details){
                    //           setState(() {
                    //             lastTapped = index;
                    //           });
                    //         },
                    //         onTapUp: (details){
                    //           setState(() {
                    //             lastTapped = -1;
                    //           });
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.fromLTRB(12.0,8,8,8),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Text(
                    //                   "${ds["date"].toString()} ${ds["time"].toString()}",
                    //                   maxLines: 1,
                    //                   style: const TextStyle(
                    //                       fontSize: 18,
                    //                       color: Colors.white
                    //                   ),
                    //                 ),
                    //               ),
                    //
                    //
                    //               Padding(
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Text(
                    //                   ds["reply"].toString(),
                    //                   maxLines: 2,
                    //                   style: const TextStyle(
                    //                       fontSize: 18,
                    //                       color: Colors.white
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //
                    //   }

                    // return ListView.builder(
                    //   itemCount: snapshot.data!.docs.length,
                    //   itemBuilder: (BuildContext context, int index){
                    //     DocumentSnapshot ds = snapshot.data!.docs[index];
                    //   },
                    //);



                  }
                },
              )


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context)=>NewReplyPage(ds: widget.ds))
          // );
        },
        label: const Text("New Reply"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
