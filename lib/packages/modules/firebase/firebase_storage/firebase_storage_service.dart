import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:softi_packages/packages/services/external/remote_Storage/i_remote_storage.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

var _eventTypeMap = {
  TaskState.error: UploadState.error,
  TaskState.success: UploadState.success,
  TaskState.paused: UploadState.paused,
  TaskState.canceled: UploadState.canceled,
  TaskState.running: UploadState.running,
};

class FirebaseStorageService extends IRemoteStorageService {
  // @override
  // Future<UploadEvent> uploadMediaSerice({
  //   required Uint8List imageToUpload,
  //   required String remotePath,
  //   required bool compressed,
  //   bool addTimestamp = false,
  // }) async {
  //   var completer = Completer<UploadEvent>();

  //   var _result = await _uploadMediaStream(
  //     imageToUpload: imageToUpload,
  //     remotePath: remotePath,
  //     compressed: compressed,
  //   );

  //   var sub;

  //   sub = _result.listen((event) {
  //     if (event.type == UploadState.running) return;
  //     sub.cancel();
  //     completer.complete(event);
  //   });

  //   return completer.future;
  // }

  @override
  Future<Stream<UploadEvent>> uploadMediaService({
    required Uint8List imageToUpload,
    String folder = '',
    String identifier = '',
    required bool compressed,
    required String localIdentifier,
  }) async {
    print('Start up load');

    var imageFileName = p.join(folder, (identifier == '') ? Uuid().v4() : identifier);

    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    // var uploadData = await (imageToUpload is File ? imageToUpload.readAsBytes() : Future.value(imageToUpload as Uint8List));
    var uploadData = imageToUpload;

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
                  thumbUrl: await event.ref.getDownloadURL(),
                  folder: p.dirname(event.metadata!.fullPath),
                  identifier: p.basename(event.metadata!.fullPath),
                ));
    });

    return __stream;
  }

  @override
  Future deleteMedia(RemoteAsset remoteAsset) async {
    var imageFileName = p.join(remoteAsset.folder, remoteAsset.identifier);

    final firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
