import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * 各种样式的loading
 */
class Loading {

  /**
   * 构建spinLoading
   */
  static Widget buildSpinLoading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitDoubleBounce(color: Theme.of(context).primaryColor),
        Text(
          "loading",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }

  /**
   * 展示easy loading
   */
  static void showEasyLoading(){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5);

    EasyLoading.show();
  }

  static void dismissEasyLoading(){
    EasyLoading.dismiss();
  }
}
