import 'package:flutter/material.dart';

class CommandTile extends StatelessWidget {
  const CommandTile({
    super.key,
    required this.command,
    required this.result,
  });

  final String command;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("/~", style: TextStyle(color: Colors.blue)),
          const SizedBox(height: 4),
          Text(command),
          const SizedBox(height: 8),
          Text(result, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
