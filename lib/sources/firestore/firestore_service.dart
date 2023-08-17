import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day/day.dart';
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
    try {
      await firestore
          .collection(FirestoreCollectionName.chats) // collection name
          .doc(userId) // user id under collection chat
          .collection("sessions")
          .doc(sessionId) // session id under user id
          .collection("chats")
          .add(data.toJson()); // chat data
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChat({
    required String userId,
    required sessionId,
  }) {
    return firestore
        .collection(FirestoreCollectionName.chats) // collection name
        .doc(userId) // user id under collection chat
        .collection("sessions")
        .doc(sessionId)
        .collection("chats")
        .snapshots();
  }

  Stream<List<FirestoreChatModel>> streamConversation(
      {required String uid, required String sessionId}) {
    try {
      return firestore
          .collection(FirestoreCollectionName.chats) // collection name
          .doc(uid) // user id under collection chat
          .collection("sessions")
          .doc(sessionId)
          .collection("chats")
          .orderBy("time", descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => FirestoreChatModel.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}

Future<List<FirestoreSessionModel>> getSessionHistory({
  required String userId,
}) async {
  try {
    QuerySnapshot snapshots = await FirebaseFirestore.instance
        .collection(FirestoreCollectionName.chats)
        .doc(userId)
        .collection("sessions")
        .orderBy("timestamp", descending: true)
        .get();

    return snapshots.docs.map((doc) {
      final rawData = doc.data() as Map<String, dynamic>;
      return FirestoreSessionModel(
          sessionId: doc.id,
          topic: rawData["topic"],
          timestamp:
              rawData["timestamp"]?.toDate() ?? Day.fromUnix(0).toDateTime());
    }).toList();
  } catch (e) {
    rethrow;
  }
}
