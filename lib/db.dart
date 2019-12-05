import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/Comment.dart';
import 'dart:async';


class DatabaseService {
 static final Firestore _db = Firestore.instance;
 DatabaseService._();
  static Future<CommentItem> getHero(String id) async {
    var snap = await _db.collection('comments').document(id).get();

    return CommentItem.fromJson(snap.data);
  }

  /// Get a stream of a single document
 static Stream<CommentItem> streamComment(String id) {
    return _db
        .collection('comments')
        .document(id)
        .snapshots()
        .map((snap) => CommentItem.fromJson(snap.data));
  }

 static Stream<List<CommentItem>> listOfComments() {
   var ref = _db.collection('comments');

   return ref.snapshots().map((list) =>
       list.documents.map((doc) => CommentItem.fromJson(doc.data)).toList());
 }

 static Future<void> createComment(CommentItem item) {
    DocumentReference doc= _db
        .collection('comments')
        .document();

    item.key=doc.documentID;
    return doc.setData(item.toJson());
  }





  Future<void> removeWeapon(FirebaseUser user, String id) {
    return _db
        .collection('comments')

        .document(id)
        .delete();
  }
}