import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import the async library for Timer

class UsersRecord {
  final String id;
  final String displayName;
  final String fullName;
  final String photoUrl;
  final String role;

  UsersRecord({
    required this.id,
    required this.displayName,
    required this.fullName,
    required this.photoUrl,
    required this.role,
  });

  factory UsersRecord.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UsersRecord(
      id: doc.id,
      displayName: data['display_name'] ?? 'No Name',
      fullName: data['full_name'] ?? 'No Full Name',
      photoUrl: data['photo_url'] ?? 'https://example.com/default_avatar.png',
      role: data['role'] ?? 'user',
    );
  }
}

class SearchModel extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  List<UsersRecord> users = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Timer? searchDebounce;

  SearchModel() {
    loadAllUsers();
  }

  get unfocusNode => null;

  Future<void> loadAllUsers() async {
    var querySnapshot = await firebaseFirestore.collection('users').get();
    users =
        querySnapshot.docs.map((doc) => UsersRecord.fromSnapshot(doc)).toList();
    notifyListeners();
  }

  void searchUsers(String query) async {
    // Cancel any existing timers
    if (searchDebounce?.isActive ?? false) searchDebounce?.cancel();

    // Set a new timer
    searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        await loadAllUsers();
      } else {
        // Query Firestore for users with an exact match on the display name
        var querySnapshot = await firebaseFirestore
            .collection('users')
            .where('display_name', isEqualTo: query) // Adjusted for exact match
            .get();

        users = querySnapshot.docs
            .map((doc) => UsersRecord.fromSnapshot(doc))
            .toList();
        notifyListeners();
      }
    });
  }

  
}
