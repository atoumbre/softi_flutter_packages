import 'package:get/get.dart';
import 'package:softi_packages/packages/services/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/services/auth/models/auth_user.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin AuthControllerMixin on IBaseController {
  final authUser = Rxn<AuthUser>();
  final authUserId = ''.obs;

  /// GETTERS

  IAuthService get authApi => Get.find();
  String? get uid => authUser()?.uid;
  Stream<AuthUser?> get authUserStream => authUser.stream;

  /// METHODS

  Future<void> initAuth() async {
    authUser(await authApi.getCurrentUser);

    return authUser.bindStream(authApi.authUserStream.skip(0).map((event) {
      print('authUser.bindStream fired: ${event?.uid}');
      authUserId(event?.uid ?? '');
      return event;
    }));
  }

  Future<void> disposeAuth() async {
    authUser.close();
  }
}
