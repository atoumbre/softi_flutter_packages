import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseLifeCycleController.dart';
import 'package:softi_packages/packages/services/presence/presence_service_interface.dart';

enum UserPresenceState { online, offline, away }

class PresenceController extends IBaseLifeCycleController {
  final IPresenceService presenceService;

  final _userPresence = UserPresenceState.offline.obs;

  PresenceController(this.presenceService);

  UserPresenceState get userPresence => _userPresence.value;

  @override
  void onDetached() => _setOffline();

  @override
  void onInactive() => _setAway();

  @override
  void onPaused() => _setAway();

  @override
  void onResumed() => _setOnline();

  void _setAway() {
    presenceService.setAway();
    _userPresence(UserPresenceState.away);
  }

  void _setOnline() {
    presenceService.setOnline();
    _userPresence(UserPresenceState.online);
  }

  void _setOffline() {
    presenceService.setOffline();
    _userPresence(UserPresenceState.offline);
  }
}
