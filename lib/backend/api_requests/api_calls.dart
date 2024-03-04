
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;


class ReverseGeoCodeCall {
  static Future<ApiCallResponse> call({
    String? latlng = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'reverseGeoCode',
      apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'latlng': latlng,
        'key': "AIzaSyAtNoHhyHOct4nytP8m7_C0nLFmKPI0SWY",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class PlacesCall {
  static Future<ApiCallResponse> call({
    String? location = '',
    int? radius = 1000,
    String? type = 'point_of_interest',
    String? keyword = 'venue',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'placesCall',
      apiUrl: 'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'location': location,
        'radius': radius.toString(),
        'type': type,
        'keyword': keyword,
        'key': "AIzaSyAkPJtvJJ6huU7T3cc8KVRmHEzoG_d1Zi0", // Make sure to replace with your actual API key
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}