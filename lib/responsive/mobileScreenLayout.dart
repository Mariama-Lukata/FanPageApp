import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/providers/user_provider.dart';
import 'package:fanpage_app/screens/list.dart';
import 'package:fanpage_app/services/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fanpage_app/model/user.dart' as model;
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  PostService _postService = PostService();

  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
    });
  }

  Widget build(BuildContext context) {
   // model.User user = Provider.of<UserProvider>(context).getUser;
    return StreamProvider.value(
      value: _postService.getPostByUser(FirebaseAuth.instance.currentUser!.uid),
     initialData: [],
     child:Scaffold(
        body: Container(
          child: ListPosts(),
        ),
     )
      );
  }
}
