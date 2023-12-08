import 'package:flutter/material.dart';

class ModalManager {
  static BuildContext? loadingModalContext;

  static void showLoadingModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

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
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Nous cherchons pour vous.',
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: scaleFactor * 16 ,
                            fontWeight: FontWeight.w400,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '🚀😎',
                          style: TextStyle(fontSize: scaleFactor * 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showErrorModal(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

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
                Text(
                  "😞",
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: scaleFactor * 40,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: Text(
                      "Oups , une erreur s'est produite...Veuillez réesayer.",
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: scaleFactor * 16,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void dismissModal() {
    // Dismiss the loading modal using the stored context
    if (loadingModalContext != null) {
      Navigator.of(loadingModalContext!).pop();
    }
  }
}
