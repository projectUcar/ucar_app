import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:ucar_app/src/util/fail_to_message.dart';
import '../../blocs/blocs.dart';

abstract class DioAlertDialog{
  static displayDialog(BuildContext context, String label) {
    Platform.isIOS ?
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text("Un error ocurrió"),
          content: Text(label),
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
          content: Text(label),
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

  static fromUserState(BuildContext context, UserState userState) => displayDialog(context, userState.getResultState.message);

  static fromDioException(BuildContext context, DioException e) => displayDialog(context, e.getMessage());

}