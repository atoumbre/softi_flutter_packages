import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_packages/packages/firebase/firebase_firestore/firebase_resource.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource.dart';

T? fromFirestore<T extends IResourceData>(FirestoreResource<T> res, DocumentSnapshot docSnap) {
  var map = docSnap.data();
  if (map == null) return null;

  var _map = firestoreMap(map as Map<String, dynamic>, true);

  var _result = res.deserializer({
    // 'id': docSnap.id,
    // 'path': docSnap.reference.path,
    ..._map,
  });

  _result
    ..setId(docSnap.id)
    ..setPath(docSnap.reference.path);

  return _result;
}

Map<String, dynamic> toFirestore(IResourceData doc) {
  var map = doc.toJson();

  var _map = firestoreMap(map, false);

  return _map
    ..remove('id') //
    ..remove('path');
}

Map<String, dynamic> firestoreMap(Map<String, dynamic> input, bool fromFirestore, [bool skipNull = true]) {
  var result = <String, dynamic>{};

  input.forEach((k, v) {
    if (skipNull && v == null) {
      return;
    } else if (v is Map) {
      result[k] = firestoreMap(v as Map<String, dynamic>, fromFirestore);
    } else if (v is List) {
      result[k] = firestireList(v, fromFirestore);
    } else {
      result[k] = firestoreTransform(v, fromFirestore);
    }
  });
  return result;
}

List firestireList(List input, bool fromFirestore, [bool skipNull = true]) {
  var result = [];

  input.forEach((v) {
    if (skipNull && v == null) {
      return;
    } else if (v is Map) {
      result.add(firestoreMap(v as Map<String, dynamic>, fromFirestore));
    } else if (v is List) {
      result.add(firestireList(v, fromFirestore));
    } else {
      result.add(firestoreTransform(v, fromFirestore));
    }
  });

  return result;
}

dynamic firestoreTransform(dynamic v, bool fromFirestore) {
  if (fromFirestore) {
    //FROM FIRESTORE

    if (v is Timestamp) {
      return v.toDate(); //.toIso8601String();
    } else if (v is DocumentReference) {
      return v.id;
    } else {
      return v;
    }
  } else {
    // TO FIRESTORE

    // DateTime.tryParse(v);

    if (v is DateTime) {
      return Timestamp.fromDate(v);
    } else {
      return v;
    }
  }
}
