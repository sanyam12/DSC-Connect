import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewReplyPage extends StatefulWidget {
  final DocumentSnapshot ds;
  const NewReplyPage({Key? key, required this.ds}) : super(key: key);

  @override
  State<NewReplyPage> createState() => _NewReplyPageState();
}

class _NewReplyPageState extends State<NewReplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Answer"),
      ),

    );
  }
}
