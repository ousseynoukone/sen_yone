import 'package:flutter/material.dart';

class ModalManager {
  static BuildContext? loadingModalContext;

  static void showLoadingModal(BuildContext context) {
    // Dismiss all existing modals
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Show the new modal
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingModalContext = context; // Store the context
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          surfaceTintColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.0),
                RichText(
                  text: TextSpan(
                    text: 'Nous sommes en train de chercher pour vous.',
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                    children: <TextSpan>[
                      TextSpan(text: '🚀', style: TextStyle(fontSize: 30)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void dismissLoadingModal() {
    // Dismiss the loading modal using the stored context
    if (loadingModalContext != null) {
      Navigator.of(loadingModalContext!).pop();
    }
  }
}
