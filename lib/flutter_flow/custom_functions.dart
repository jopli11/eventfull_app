import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? parseLatLng(LatLng? latLng) {
  // Check if latLng is not null before trying to access its properties
  if (latLng != null) {
    double lat = latLng.latitude;
    double long = latLng.longitude;
    return '$lat,$long';
  } else {
    // Handle the case when latLng is null
    // You can return a default string or handle it however you prefer
    return 'No location data available';
  }
}
