import 'package:flutter/widgets.dart';

class StateFullWrapper extends StatefulWidget {
  const StateFullWrapper({
    this.child,
    this.onInit,
    this.onDispose,
  });

  final Widget? child;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;

  @override
  _StateFullWrapperState createState() => _StateFullWrapperState();
}

class _StateFullWrapperState extends State<StateFullWrapper> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) widget.onInit!();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!();
    super.dispose();
  }
}
