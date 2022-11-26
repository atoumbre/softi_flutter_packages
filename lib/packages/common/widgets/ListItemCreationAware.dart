import 'package:flutter/widgets.dart';

class ListItemCreationAware extends StatefulWidget {
  final VoidCallback itemCreated;
  final VoidCallback? itemDestroyed;
  final Widget? child;
  const ListItemCreationAware({
    Key? key,
    required this.itemCreated,
    this.itemDestroyed,
    this.child,
  }) : super(key: key);

  @override
  _ListItemCreationAwareState createState() => _ListItemCreationAwareState();
}

class _ListItemCreationAwareState extends State<ListItemCreationAware> {
  @override
  void initState() {
    super.initState();
    widget.itemCreated();
  }

  @override
  void dispose() {
    if (widget.itemDestroyed != null) widget.itemDestroyed!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
