import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serina/config/constants.dart';
import 'package:serina/sources/firestore/model/firestore_chat_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService({required this.firestore});

  Future<void> storeChat({
    required String userId,
    required sessionId,
    // required Map<String, dynamic> chat,
    required FirestoreChatModel data,
  }) async {
    try{
      await firestore
          .collection(FirestoreCollectionName.chats) // collection name
          .doc(userId) // user id under collection chat
          .collection(sessionId) // session id under user id
          .add(data.toJson()); // chat data
    }catch(e){
      throw Exception(e.toString());
    }

  }

  Stream<QuerySnapshot<Map<String,dynamic>>> streamChat({
    required String userId,
    required sessionId,
  }) {
    return firestore
        .collection(FirestoreCollectionName.chats) // collection name
        .doc(userId) // user id under collection chat
        .collection(sessionId)
        .snapshots();
  }

  Stream<List<FirestoreChatModel>> streamConversation({required String uid,
    required String sessionId}){
    try{
      return firestore
          .collection(FirestoreCollectionName.chats) // collection name
          .doc(uid) // user id under collection chat
          .collection(sessionId).orderBy("time",descending: true)
          .snapshots().map((snapshot){return snapshot.docs.map((doc) => FirestoreChatModel.fromJson(doc.data())).toList();
      });
    }catch(e){
      rethrow;
    }

  }
}
