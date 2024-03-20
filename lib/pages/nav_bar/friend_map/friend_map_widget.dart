import 'package:event_full/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'friend_map_model.dart'; // Update the path according to your project structure

class FriendMapWidget extends StatefulWidget {
  const FriendMapWidget({super.key});

  @override
  State<FriendMapWidget> createState() => _FriendMapWidgetState();
}

class _FriendMapWidgetState extends State<FriendMapWidget> {
  late FriendMapModel _model;
  final Set<gmaps.Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FriendMapModel());
    fetchThisWeeksEvents().then((eventDocs) {
      displayEventsOnMap(eventDocs);
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchThisWeeksEvents() async {
    var now = DateTime.now();
    var startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
    var endOfWeek = startOfWeek.add(const Duration(days: 7));

    var eventsCollection = FirebaseFirestore.instance.collection('events');
    var snapshot = await eventsCollection
        .where('StartTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfWeek))
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
            initialCameraPosition: const gmaps.CameraPosition(
              target: gmaps.LatLng(13.106061, -59.613158),
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
