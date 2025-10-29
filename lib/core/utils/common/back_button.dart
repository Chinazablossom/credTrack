import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/asset_paths.dart';
import '../helper_functions/helper_functions.dart';

class CTBackButton extends StatelessWidget {
  const CTBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: getTheme(context).onSurface),
        ),
        child:  Center(
          child: SvgPicture.asset(
            arrowBackSvg, color: getTheme(context).onSurface,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
