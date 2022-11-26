import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class IPresenceService extends IBaseService {
  void setOnline();
  void setOffline();
  void setAway();
}
