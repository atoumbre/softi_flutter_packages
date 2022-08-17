// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:softi_common/index.dart';

// abstract class IAlertService extends IBaseService {
//   /// Registers a callback function. Typically to show the dialog
//   void registerDialogListener(void Function(AlertRequest, Completer) showDialogListener);

//   void registerToastListener(void Function(AlertRequest, Completer) showToastListener);

//   /// DIALOGS
//   ///
//   /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
//   // Future<AlertResponse> showDialog(
//   //   String title,
//   //   String message, {
//   //   DialogStatus status = DialogStatus.info,
//   //   bool needConfirmation = false,
//   // });

//   Future<AlertResponse> showSuccessDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   });

//   Future<AlertResponse> showInfoDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   });

//   Future<AlertResponse> showErrorDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   });

//   /// TOASTS

//   // Future<AlertResponse> showToast({
//   //   String title,
//   //   String message,
//   //   DialogStatus status,
//   // });

//   Future<AlertResponse> showSuccessToast(String title, String message);

//   Future<AlertResponse> showInfoToast(String title, String message);

//   Future<AlertResponse> showErrorToast(String title, String message);
// }

// enum DialogStatus {
//   info,
//   success,
//   error,
// }

// enum DialogType {
//   alert,
//   confirmation,
// }

// class AlertRequest {
//   final String title;
//   final String message;
//   final DialogStatus status;
//   final DialogType type;

//   AlertRequest({
//     @required this.type,
//     @required this.status,
//     @required this.title,
//     @required this.message,
//   });
// }

// class AlertResponse {
//   // final String fieldOne;
//   // final String fieldTwo;
//   final bool confirmed;

//   AlertResponse({
//     // this.fieldOne,
//     // this.fieldTwo,
//     this.confirmed,
//   });
// }
