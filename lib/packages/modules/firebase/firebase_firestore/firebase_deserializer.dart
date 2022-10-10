import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';

T? fromFirestore<T extends IBaseResourceData>(FirestoreResource<T> res, DocumentSnapshot docSnap) {
  var map = docSnap.data();
  if (map == null) return null;

  var _map = firestoreMap(map as Map<String, dynamic>, true);

  var _result = res.deserializer({
    ..._map,
  });

  _result
    ..id(docSnap.id)
    ..path(docSnap.reference.path)
    ..createdAt(_map['createdAt'])
    ..updatedAt(_map['updatedAt']);

  return _result;
}

Map<String, dynamic> toFirestore(IBaseResourceData doc) {
  var map = doc.toJson();

  var _map = firestoreMap(map, false);

  _map['createdAt'] = (doc.id() == '') ? FieldValue.serverTimestamp() : doc.createdAt() ?? FieldValue.serverTimestamp();
  _map['updatedAt'] = FieldValue.serverTimestamp();

  return _map;
  // ..remove('id') //
  // ..remove('path') //
  // ..remove('createdAt') //
  // ..remove('updatedAt');
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

    //DateTime.tryParse(v);

    if (v is DateTime) {
      return Timestamp.fromDate(v);
    } else {
      return v;
    }
  }
}
