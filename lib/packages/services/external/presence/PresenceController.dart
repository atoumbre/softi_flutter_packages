import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/IBaseControllerWithLifeCycle.dart';
import 'package:softi_packages/packages/services/external/presence/presence_service_interface.dart';

enum UserPresenceState { online, offline, away }

class PresenceController extends IBaseControllerWithLifeCycle {
  final IPresenceService presenceService;

  final _userPresence = UserPresenceState.offline.obs;

  PresenceController(this.presenceService);

  UserPresenceState get userPresence => _userPresence.value;

  @override
  void onStateChange(AppLifecycleState newState) async {
    switch (newState) {
      case AppLifecycleState.detached:
        _setOffline();
        break;

      case AppLifecycleState.inactive:
        _setAway();
        break;

      case AppLifecycleState.paused:
        _setAway();
        break;

      case AppLifecycleState.resumed:
        _setOnline();
        break;
      default:
    }
  }

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
