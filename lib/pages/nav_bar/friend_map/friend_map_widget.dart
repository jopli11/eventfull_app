import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:geolocator/geolocator.dart';
import 'package:event_full/flutter_flow/flutter_flow_util.dart';

class FriendMapWidget extends StatefulWidget {
  const FriendMapWidget({Key? key}) : super(key: key);

  @override
  State<FriendMapWidget> createState() => _FriendMapWidgetState();
}

class _FriendMapWidgetState extends State<FriendMapWidget> {
  final Set<gmaps.Marker> _markers = {};
  gmaps.GoogleMapController? _mapController;
  Position? _currentUserPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      _currentUserPosition = position;
      fetchThisWeeksEvents().then((eventDocs) {
        displayEventsOnMap(eventDocs);
        if (eventDocs.isNotEmpty) {
          centerMapOnClosestEvent(eventDocs);
        }
      });
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<QueryDocumentSnapshot>> fetchThisWeeksEvents() async {
    var now = DateTime.now();
    var startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
    var endOfWeek = startOfWeek.add(const Duration(days: 7));

    var eventsCollection = FirebaseFirestore.instance.collection('events');
    var snapshot = await eventsCollection
        .where('StartTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfWeek))
        .where('StartTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfWeek))
        .get();

    return snapshot.docs;
  }

  void displayEventsOnMap(List<QueryDocumentSnapshot> eventDocs) {
    final markers = <gmaps.Marker>{};

    for (var doc in eventDocs) {
      var event = doc.data() as Map<String, dynamic>;
      var geoPoint = event['location'] as GeoPoint;
      var markerId = gmaps.MarkerId(doc.id);

      var marker = gmaps.Marker(
        markerId: markerId,
        position: gmaps.LatLng(geoPoint.latitude, geoPoint.longitude),
        onTap: () {
          fetchEventsAtLocation(geoPoint).then((eventsAtLocation) {
            showEventsBottomSheet(context, eventsAtLocation);
          });
        },
        infoWindow: gmaps.InfoWindow(
          title: event['name'],
        ),
      );

      markers.add(marker);
    }

    setState(() {
      _markers.addAll(markers);
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchEventsAtLocation(
      GeoPoint location) async {
    // Here, you would implement fetching events by location from Firestore
    // This is a placeholder for your actual query logic
    var eventsCollection = FirebaseFirestore.instance.collection('events');
    var snapshot =
        await eventsCollection.where('location', isEqualTo: location).get();

    return snapshot.docs;
  }

  void centerMapOnClosestEvent(List<QueryDocumentSnapshot> eventDocs) {
    if (_currentUserPosition == null || eventDocs.isEmpty) return;

    double minDistance = double.infinity;
    gmaps.LatLng? closestEventLatLng;

    for (var doc in eventDocs) {
      var event = doc.data() as Map<String, dynamic>;
      var geoPoint = event['location'] as GeoPoint;
      var eventLatLng = gmaps.LatLng(geoPoint.latitude, geoPoint.longitude);
      var distance = Geolocator.distanceBetween(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
        eventLatLng.latitude,
        eventLatLng.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        closestEventLatLng = eventLatLng;
      }
    }

    if (closestEventLatLng != null) {
      _mapController?.animateCamera(
        gmaps.CameraUpdate.newLatLngZoom(closestEventLatLng, 14.0),
      );
    }
  }

  void showEventsBottomSheet(
      BuildContext context, List<QueryDocumentSnapshot> events) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            var event = events[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(event['title']),
              subtitle: Text(event['description'] ?? 'No description'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                context.pushNamed(
                  'EventExpanded',
                  queryParameters: {
                    'eventID': serializeParam(
                      events[index].reference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF1F4F8),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: gmaps.GoogleMap(
            onMapCreated: (gmaps.GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: const gmaps.CameraPosition(
              target: gmaps.LatLng(13.106061, -59.613158), // Default location
              zoom: 14.0,
            ),
            markers: _markers,
            mapType: gmaps.MapType.normal,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),
      ),
    );
  }
}
