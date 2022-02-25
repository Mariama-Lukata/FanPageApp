import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/model/posts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        creator: doc['creator'] ?? '',
        text: doc['text'] ?? '',
        timestamp: doc['timestamp'] ?? 0,
      );
    }).toList();
  }

  Future savePost(text) async {
    await FirebaseFirestore.instance.collection('post').add({
      'test': text,
      'creator': FirebaseAuth.instance.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  Stream<List<PostModel>> getPostByUser(uid) {
    return FirebaseFirestore.instance
        .collection('post')
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }
}
