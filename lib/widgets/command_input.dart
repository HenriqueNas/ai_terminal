import 'dart:io';

import 'package:flutter/material.dart';

class CommandInput extends StatelessWidget {
  const CommandInput({
    super.key,
    this.command,
    required this.onSubmitted,
    required this.onCommandChanged,
  });

  final void Function(String, String) onSubmitted;
  final void Function(String) onCommandChanged;
  final String? command;

  @override
  Widget build(BuildContext context) {
    final fieldController = TextEditingController();
    final focusNode = FocusNode();

    Future<String> runCommand(String fullCommand) async {
      final command = fullCommand.split(' ').first;

      final result = await Process.run(command, [
        ...fullCommand.split(' ').skip(1),
      ]);

      return result.stdout;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("/~", style: TextStyle(color: Colors.pink)),
        TextField(
          autofocus: true,
          focusNode: focusNode,
          controller: fieldController,
          onSubmitted: (command) async {
            final result = await runCommand(command);

            onSubmitted(command, result);

            fieldController.clear();
            focusNode.requestFocus();
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a command',
          ),
        ),
      ],
    );
  }
}
