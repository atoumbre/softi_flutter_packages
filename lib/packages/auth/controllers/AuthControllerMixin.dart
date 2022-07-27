import 'package:get/get.dart';
import 'package:softi_packages/packages/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin AuthControllerMixin on IBaseController {
  final authUser = Rxn<AuthUser>();
  final userId = ''.obs;

  /// GETTERS

  IAuthService get authApi => Get.find();
  String? get uid => authUser()?.uid;
  Stream<AuthUser?> get authUserStream => authUser.stream;

  /// METHODS

  Future<void> initAuth() async {
    authUser(await authApi.getCurrentUser);

    return authUser.bindStream(authApi.authUserStream.skip(0).map((event) {
      print('authUser.bindStream fired: ${event?.uid}');
      userId(event?.uid ?? '');
      return event;
    }));
  }

  Future<void> disposeAuth() async {
    authUser.close();
  }
}
