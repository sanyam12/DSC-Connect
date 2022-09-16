import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryDetails extends StatefulWidget {
  final DocumentSnapshot ds;
  const QueryDetails({Key? key, required this.ds}) : super(key: key);

  @override
  State<QueryDetails> createState() => _QueryDetailsState();
}

class _QueryDetailsState extends State<QueryDetails> {
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
                    widget.ds["date"].toString() +" "+ widget.ds["time"].toString(),
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



            ],
          ),
        ),
      ),
    );
  }
}
