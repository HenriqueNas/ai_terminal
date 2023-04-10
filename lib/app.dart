import 'package:flutter/material.dart';

import 'widgets/command_input.dart';
import 'widgets/command_tile.dart';
import 'widgets/shortcuts_wrapper.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final commands = <int, Map<String, String>>{};
  int commandIndex = 0;

  Object? clearCommands(ClearIntent intent) {
    setState(() {
      commands.clear();
    });

    return null;
  }

  Object? getLastCommand(LastCommandIntent intent) {
    setState(() {
      commandIndex = commands.length - 1;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ShortcutsWrapper(
        controlKeyL: clearCommands,
        arrowUp: getLastCommand,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                reverse: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: commands.length,
                  itemBuilder: (context, index) => CommandTile(
                    command: commands[index]?.keys.first ?? '',
                    result: commands[index]?.values.first ?? '',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: CommandInput(
                command: commands[commandIndex]?.keys.first,
                onCommandChanged: (command) {
                  setState(() {
                    commandIndex = commands.length;
                  });
                },
                onSubmitted: (command, result) {
                  setState(() {
                    commands[commands.length] = {command: result};
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
