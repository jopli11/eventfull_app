// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future<String> convertGeopointToCity(LatLng? location) async {
  // Check if the location is not null
  if (location == null) {
    throw Exception('Location is null. Please provide a valid LatLng object.');
  }

  // Replace with your actual Firebase Cloud Function URL
  final url = Uri.parse(
      'https://europe-west3-eventfull-7b3e6.cloudfunctions.net/getCityFromCoordinate');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
          {'latitude': location.latitude, 'longitude': location.longitude}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Assuming the cloud function returns a JSON object with a 'city' field
      return data['city'];
    } else {
      // Log or handle the error according to your app's needs
      throw Exception(
          'Failed to convert LatLng to city. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    throw Exception('Error occurred while fetching city: $e');
  }
}
