import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExceptionExitAlert extends StatelessWidget {
  final String msg;
  ExceptionExitAlert(this.msg);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text('Error'), content: Text(msg), actions: [
      TextButton(
        onPressed: () =>
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: Text('Exit'),
      ),
    ]);
  }
}
