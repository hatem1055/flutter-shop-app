import 'package:flutter/material.dart';

void showConfirmationDialog(
    {@required BuildContext context,
    @required String message,
    @required Function confirmFunction,
    @required Function dismissFunction}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  confirmFunction();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                child: Text('yes,Iam sure')),
            TextButton(
                onPressed: () {
                  dismissFunction();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).errorColor,
                )),
                child: Text('cancel'))
          ],
        );
      },
      barrierDismissible: true);
}
