import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import '../../blocs/forms/states/user_state.dart';

abstract class DioAlertDialog{
  static fromDioError(BuildContext context, UserState userState) {
    Platform.isIOS ?
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text("Un error ocurrió"),
          content: Text(userState.getResultState.message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    ):
    material.showDialog(
      context: context,
      builder: (_) {
        return material.AlertDialog(
          title: const Text("Un error ocurrió"),
          content: Text(userState.getResultState.message),
          actions: [
            material.TextButton(
              child: const material.Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

}