import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserEventsRecord extends FirestoreRecord {
  UserEventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "eventID" field.
  DocumentReference? _eventID;
  DocumentReference? get eventID => _eventID;
  bool hasEventID() => _eventID != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "ticketLink" field.
  String? _ticketLink;
  String get ticketLink => _ticketLink ?? '';
  bool hasTicketLink() => _ticketLink != null;

  // "organiserName" field.
  String? _organiserName;
  String get organiserName => _organiserName ?? '';
  bool hasOrganiserName() => _organiserName != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _eventID = snapshotData['eventID'] as DocumentReference?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _ticketLink = snapshotData['ticketLink'] as String?;
    _organiserName = snapshotData['organiserName'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('userEvents')
          : FirebaseFirestore.instance.collectionGroup('userEvents');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('userEvents').doc(id);

  static Stream<UserEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserEventsRecord.fromSnapshot(s));

  static Future<UserEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserEventsRecord.fromSnapshot(s));

  static UserEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserEventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserEventsRecordData({
  DocumentReference? eventID,
  String? title,
  String? description,
  DateTime? startTime,
  DateTime? endTime,
  String? photoUrl,
  LatLng? location,
  String? ticketLink,
  String? organiserName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'eventID': eventID,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'photo_url': photoUrl,
      'location': location,
      'ticketLink': ticketLink,
      'organiserName': organiserName,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserEventsRecordDocumentEquality implements Equality<UserEventsRecord> {
  const UserEventsRecordDocumentEquality();

  @override
  bool equals(UserEventsRecord? e1, UserEventsRecord? e2) {
    return e1?.eventID == e2?.eventID &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.location == e2?.location &&
        e1?.ticketLink == e2?.ticketLink &&
        e1?.organiserName == e2?.organiserName;
  }

  @override
  int hash(UserEventsRecord? e) => const ListEquality().hash([
        e?.eventID,
        e?.title,
        e?.description,
        e?.startTime,
        e?.endTime,
        e?.photoUrl,
        e?.location,
        e?.ticketLink,
        e?.organiserName
      ]);

  @override
  bool isValidKey(Object? o) => o is UserEventsRecord;
}
