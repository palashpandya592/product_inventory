import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_app/constant/app_colors.dart';

class Toast {
  static showToast(String? msg) {
    Fluttertoast.showToast(
        msg: msg.toString(),
        webBgColor: "linear-gradient(to right, #319416, #319416)",
        textColor: AppColors.white,
        webPosition: 'center');
  }

  static errorToast(String? msg) {
    Fluttertoast.showToast(
        msg: msg.toString(),
        textColor: AppColors.white,
        webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
        webPosition: 'center');
  }
}
