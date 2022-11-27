import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class HideKeyboardManager extends SingleChildStatelessWidget {
  void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: child,
    );
  }
}
