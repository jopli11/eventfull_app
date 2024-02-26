import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProfilesRecord extends FirestoreRecord {
  ProfilesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "profile_photo" field.
  String? _profilePhoto;
  String get profilePhoto => _profilePhoto ?? '';
  bool hasProfilePhoto() => _profilePhoto != null;

  // "artist_name" field.
  String? _artistName;
  String get artistName => _artistName ?? '';
  bool hasArtistName() => _artistName != null;

  // "followers" field.
  List<DocumentReference>? _followers;
  List<DocumentReference> get followers => _followers ?? const [];
  bool hasFollowers() => _followers != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "genre" field.
  String? _genre;
  String get genre => _genre ?? '';
  bool hasGenre() => _genre != null;

  // "link" field.
  String? _link;
  String get link => _link ?? '';
  bool hasLink() => _link != null;

  // "tabs" field.
  List<String>? _tabs;
  List<String> get tabs => _tabs ?? const [];
  bool hasTabs() => _tabs != null;

  // "likes" field.
  int? _likes;
  int get likes => _likes ?? 0;
  bool hasLikes() => _likes != null;

  // "performance_image" field.
  String? _performanceImage;
  String get performanceImage => _performanceImage ?? '';
  bool hasPerformanceImage() => _performanceImage != null;

  // "profile_likes" field.
  bool? _profileLikes;
  bool get profileLikes => _profileLikes ?? false;
  bool hasProfileLikes() => _profileLikes != null;

  void _initializeFields() {
    _profilePhoto = snapshotData['profile_photo'] as String?;
    _artistName = snapshotData['artist_name'] as String?;
    _followers = getDataList(snapshotData['followers']);
    _location = snapshotData['location'] as String?;
    _genre = snapshotData['genre'] as String?;
    _link = snapshotData['link'] as String?;
    _tabs = getDataList(snapshotData['tabs']);
    _likes = castToType<int>(snapshotData['likes']);
    _performanceImage = snapshotData['performance_image'] as String?;
    _profileLikes = snapshotData['profile_likes'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('profiles');

  static Stream<ProfilesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProfilesRecord.fromSnapshot(s));

  static Future<ProfilesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProfilesRecord.fromSnapshot(s));

  static ProfilesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProfilesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProfilesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProfilesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProfilesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProfilesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProfilesRecordData({
  String? profilePhoto,
  String? artistName,
  String? location,
  String? genre,
  String? link,
  int? likes,
  String? performanceImage,
  bool? profileLikes,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'profile_photo': profilePhoto,
      'artist_name': artistName,
      'location': location,
      'genre': genre,
      'link': link,
      'likes': likes,
      'performance_image': performanceImage,
      'profile_likes': profileLikes,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProfilesRecordDocumentEquality implements Equality<ProfilesRecord> {
  const ProfilesRecordDocumentEquality();

  @override
  bool equals(ProfilesRecord? e1, ProfilesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.profilePhoto == e2?.profilePhoto &&
        e1?.artistName == e2?.artistName &&
        listEquality.equals(e1?.followers, e2?.followers) &&
        e1?.location == e2?.location &&
        e1?.genre == e2?.genre &&
        e1?.link == e2?.link &&
        listEquality.equals(e1?.tabs, e2?.tabs) &&
        e1?.likes == e2?.likes &&
        e1?.performanceImage == e2?.performanceImage &&
        e1?.profileLikes == e2?.profileLikes;
  }

  @override
  int hash(ProfilesRecord? e) => const ListEquality().hash([
        e?.profilePhoto,
        e?.artistName,
        e?.followers,
        e?.location,
        e?.genre,
        e?.link,
        e?.tabs,
        e?.likes,
        e?.performanceImage,
        e?.profileLikes
      ]);

  @override
  bool isValidKey(Object? o) => o is ProfilesRecord;
}
