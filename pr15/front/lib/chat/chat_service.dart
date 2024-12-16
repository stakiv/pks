import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/auth/auth_service.dart';
import 'package:front/auth/auth_service.dart';
import 'package:front/models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authService = AuthService();
  //authService.getCurrentUserEmail().toString();

  // отправка сообщений
  Future<void> sendMessage(String receiverEmail, String message) async {
    final String currentUserEmail =
        authService.getCurrentUserEmail().toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderEmail: currentUserEmail,
        receiverEmail: receiverEmail,
        message: message,
        timestamp: timestamp);

    List<String> emails = [currentUserEmail, receiverEmail];
    emails.sort();
    String chatRoomName = emails.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomName)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // получение сообщений
  Stream<QuerySnapshot> getMessages(String userEmail1, String userEmail2) {
    List<String> emails = [userEmail1, userEmail2];
    emails.sort();
    String chatRoomName = emails.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomName)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
