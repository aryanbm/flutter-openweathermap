import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  BuildContext? globalContext;
  bool isShowing = false;

  void showCustomDialog(BuildContext context, String? message,
      {Widget? child}) {
    isShowing = true;
    Future.sync(
      () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          globalContext = ctx;
          if (child != null) return child;
          return Center(
            child: Material(
              borderRadius: BorderRadius.circular(
                10,
              ),
              elevation: 9,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Color(0xFF272727),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFFFFF),
                      ),
                      backgroundColor: Color(0xFFFFFFFF).withOpacity(
                        0.5,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AutoSizeText(
                      "$message",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void dismiss() {
    try {
      if (isShowing) {
        isShowing = false;
        Navigator.of(globalContext!).pop();
      }
    } catch (error) {
      print(error);
    }
  }
}
