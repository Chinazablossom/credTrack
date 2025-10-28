import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper_functions/helper_functions.dart';

class ScreenLoader {
  static void openLoadingDialog(String text) async {
    Get.dialog(
      Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: getTheme(Get.context!).primary,),
                20.h,
                Text(
                  text,
                  style: getTextTheme(Get.context!).labelMedium?.copyWith(
                    color: getTheme(Get.context!).primary
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static stopLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
