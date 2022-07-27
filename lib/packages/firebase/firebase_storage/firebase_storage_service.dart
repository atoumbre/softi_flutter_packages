import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:softi_packages/packages/services/remote_Storage/i_remote_storage.dart';

var _eventTypeMap = {
  TaskState.error: UploadState.error,
  TaskState.success: UploadState.success,
  TaskState.paused: UploadState.paused,
  TaskState.canceled: UploadState.canceled,
  TaskState.running: UploadState.running,
};

class FirebaseStorageService extends IRemoteStorageService {
  @override
  Future<UploadEvent> uploadMedia({
    required dynamic imageToUpload,
    required String title,
    required bool compressed,
    bool addTimestamp = false,
  }) async {
    var completer = Completer<UploadEvent>();

    var _result = await uploadMediaStream(
      imageToUpload: imageToUpload,
      title: title,
      addTimestamp: addTimestamp,
      compressed: compressed,
    );

    var sub;

    sub = _result.listen((event) {
      if (event.type == UploadState.running) return;
      sub.cancel();
      completer.complete(event);
    });

    return completer.future;
    // print('Start up load');

    // var imageFileName = title + (addTimestamp ? DateTime.now().millisecondsSinceEpoch.toString() : '');

    // final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    // UploadTask uploadTask;

    // if (compressed) {
    //   var _imageToUpload = await (imageToUpload is File
    //       ? FlutterImageCompress.compressWithFile(
    //           (imageToUpload).absolute.path,
    //           minWidth: 640,
    //           minHeight: 640,
    //           // quality: 94,
    //         )
    //       : FlutterImageCompress.compressWithList(
    //           imageToUpload,
    //           minWidth: 640,
    //           minHeight: 640,
    //           // quality: 94,
    //         ));

    //   uploadTask = firebaseStorageRef.putData(_imageToUpload!);
    // } else {
    //   uploadTask = imageToUpload is File ? firebaseStorageRef.putFile(imageToUpload) : firebaseStorageRef.putData(imageToUpload as Uint8List);
    // }

    // return uploadTask.then<UploadEvent>((event) async {
    //   return UploadEvent(
    //       type: _eventTypeMap[event.state],
    //       total: event.totalBytes.toDouble(),
    //       uploaded: event.bytesTransferred.toDouble(),
    //       // rawrResult: event.state == TaskState.success ? event.metadata. : null,
    //       result: event.state != TaskState.success
    //           ? null
    //           : RemoteAsset(
    //               url: await event.ref.getDownloadURL(),
    //               title: event.metadata!.fullPath,
    //             ));
    // });
  }

  @override
  Future<Stream<UploadEvent>> uploadMediaStream({
    required dynamic imageToUpload,
    required String title,
    required bool compressed,
    bool addTimestamp = false,
  }) async {
    print('Start up load');

    var imageFileName = title + (addTimestamp ? DateTime.now().millisecondsSinceEpoch.toString() : '');

    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    var uploadData = await (imageToUpload is File ? imageToUpload.readAsBytes() : Future.value(imageToUpload as Uint8List));

    uploadData = await (compressed
        ? FlutterImageCompress.compressWithList(
            uploadData,
            minWidth: 640,
            minHeight: 640,
            // quality: 94,
          )
        : Future.value(uploadData));

    var __stream = firebaseStorageRef.putData(uploadData).snapshotEvents.asyncMap<UploadEvent>((event) async {
      return UploadEvent(
          type: _eventTypeMap[event.state],
          total: event.totalBytes.toDouble(),
          uploaded: event.bytesTransferred.toDouble(),
          result: event.state != TaskState.success
              ? null
              : RemoteAsset(
                  url: await event.ref.getDownloadURL(),
                  title: event.metadata!.fullPath,
                ));
    });

    return __stream;

    // var _imageToUpload =

    //       .then((value) {
    //        _comp.complete(value)
    //         uploadTask = firebaseStorageRef.putData(_imageToUpload!);
    //       });

    //     uploadTask = imageToUpload is File ? firebaseStorageRef.putFile(imageToUpload) : firebaseStorageRef.putData(imageToUpload as Uint8List);
    //   }

    //   return uploadTask;
    // }).map;

    // return uploadTask.snapshotEvents.asyncMap<UploadEvent>((event) async {
    //   return UploadEvent(
    //       type: _eventTypeMap[event.state],
    //       total: event.totalBytes.toDouble(),
    //       uploaded: event.bytesTransferred.toDouble(),
    //       result: event.state != TaskState.success
    //           ? null
    //           : RemoteAsset(
    //               url: await event.ref.getDownloadURL(),
    //               title: event.metadata!.fullPath,
    //             ));
    // });
  }

  @override
  Future deleteMedia(String imageFileName) async {
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
