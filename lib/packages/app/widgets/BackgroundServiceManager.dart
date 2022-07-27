import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:softi_packages/packages/core/services/SoppableService.dart';

class BackgroundServiceManager extends SingleChildStatefulWidget {
  final Widget? child;
  final List<IStoppableService> services; // = [];

  BackgroundServiceManager(
    this.services, {
    super.key,
    this.child,
  }); //: super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends SingleChildState<BackgroundServiceManager> with WidgetsBindingObserver {
  // List<IStoppableService> services = [];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    widget.services.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(
      child: child,
    );
  }
}
