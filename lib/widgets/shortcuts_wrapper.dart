import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortcutsWrapper extends StatelessWidget {
  const ShortcutsWrapper({
    super.key,
    this.controlKeyL,
    this.arrowUp,
    required this.child,
  });

  final Object? Function(ClearIntent)? controlKeyL;
  final Object? Function(LastCommandIntent)? arrowUp;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.keyL,
        ): const ClearIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.arrowUp,
        ): const ClearIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ClearIntent: CallbackAction<ClearIntent>(
            onInvoke: controlKeyL ?? (_) => null,
          ),
          LastCommandIntent: CallbackAction<LastCommandIntent>(
            onInvoke: arrowUp ?? (_) => null,
          ),
        },
        child: Focus(child: child),
      ),
    );
  }
}

class ClearIntent extends Intent {
  const ClearIntent();
}

class LastCommandIntent extends Intent {
  const LastCommandIntent();
}
