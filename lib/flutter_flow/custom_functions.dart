
import 'lat_lng.dart';
import '/backend/backend.dart';


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
