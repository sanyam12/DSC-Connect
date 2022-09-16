import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutAnnouncements extends StatefulWidget {
  final DocumentSnapshot ds;
  const AboutAnnouncements({Key? key, required this.ds}) : super(key: key);

  @override
  State<AboutAnnouncements> createState() => _AboutAnnouncementsState();
}

class _AboutAnnouncementsState extends State<AboutAnnouncements> {
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
                      fontSize: 22,
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
                    widget.ds["date"].toString(),
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
                  widget.ds["description"].toString(),
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
                    "Location: - ${widget.ds["location"]}",
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
