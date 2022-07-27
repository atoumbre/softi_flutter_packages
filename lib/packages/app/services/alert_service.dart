// import 'dart:async';

// import 'package:softi_common_app/src/services/interfaces/app/i_alert_service.dart';

// class DefaultAlertService extends IAlertService {
//   Function(AlertRequest, Completer) _showDialogListener;
//   Function(AlertRequest, Completer) _showToastListener;

//   /// Registers a callback function. Typically to show the dialog
//   @override
//   void registerDialogListener(Function(AlertRequest, Completer) showDialogListener) {
//     _showDialogListener = showDialogListener;
//   }

//   @override
//   void registerToastListener(void Function(AlertRequest, Completer) showToastListener) {
//     _showToastListener = showToastListener;
//   }

//   /// DIALOGS
//   ///
//   /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
//   Future<AlertResponse> showDialog(
//     String title,
//     String message, {
//     DialogStatus status = DialogStatus.info,
//     bool needConfirmation = false,
//   }) {
//     var _dialogCompleter = Completer<AlertResponse>();
//     _showDialogListener(
//       AlertRequest(
//         title: title,
//         message: message,
//         status: status,
//         type: needConfirmation ? DialogType.confirmation : DialogType.alert,
//       ),
//       _dialogCompleter,
//     );
//     return _dialogCompleter.future;
//   }

//   @override
//   Future<AlertResponse> showSuccessDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   }) {
//     return showDialog(
//       title,
//       message,
//       status: DialogStatus.success,
//       needConfirmation: needConfirmation,
//     );
//   }

//   @override
//   Future<AlertResponse> showInfoDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   }) {
//     return showDialog(
//       title,
//       message,
//       status: DialogStatus.info,
//       needConfirmation: needConfirmation,
//     );
//   }

//   @override
//   Future<AlertResponse> showErrorDialog(
//     String title,
//     String message, {
//     bool needConfirmation = false,
//   }) {
//     return showDialog(
//       title,
//       message,
//       status: DialogStatus.error,
//       needConfirmation: needConfirmation,
//     );
//   }

//   /// TOASTS
//   Future<AlertResponse> showToast({
//     String title,
//     String message,
//     DialogStatus status,
//   }) {
//     Completer<AlertResponse> _toastCompleter;
//     _toastCompleter = Completer<AlertResponse>();
//     _showToastListener(
//         AlertRequest(
//           title: title,
//           message: message,
//           status: status,
//           type: null,
//         ),
//         _toastCompleter);
//     return _toastCompleter.future;
//   }

//   @override
//   Future<AlertResponse> showSuccessToast(String title, String message) {
//     return showToast(title: title, message: message, status: DialogStatus.success);
//   }

//   @override
//   Future<AlertResponse> showInfoToast(String title, String message) {
//     return showToast(title: title, message: message, status: DialogStatus.info);
//   }

//   @override
//   Future<AlertResponse> showErrorToast(String title, String message) {
//     return showToast(title: title, message: message, status: DialogStatus.error);
//   }
// }
