// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> eventCheck(
  DocumentReference? eventRef,
  DocumentReference? userRef,
) async {
  if (userRef == null || eventRef == null) {
    throw Exception("User reference or event reference is null");
  }

  // Assuming `userEventsRef` is a list of references to the user's events.
  // This function now directly uses `userRef` and `eventRef` passed as arguments.

  final userEventsCollection = userRef.collection('userEvents');
  bool eventAdded = false;

  // Query the user's `userEvents` to check if the event is already there by comparing document references
  final eventInUserEvents =
      await userEventsCollection.where('eventRef', isEqualTo: eventRef).get();

  if (eventInUserEvents.docs.isEmpty) {
    // Event is not in `userEvents`, add it
    await userEventsCollection.add({
      'eventRef': eventRef, // Direct reference to the event document
    });
    eventAdded = true; // Indicates the event was added
  } else {
    // Event is in `userEvents`, remove it
    // Assuming there's only one instance of each event in `userEvents`
    await userEventsCollection.doc(eventInUserEvents.docs.first.id).delete();
    eventAdded = false; // Indicates the event was removed
  }

  return eventAdded;
}
