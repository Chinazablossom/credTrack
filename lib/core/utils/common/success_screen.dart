import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper_functions/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.title,
      required this.subTitle,required this.onPressed});

  final title, subTitle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                  color: isLightMode(context) ? Colors.black54 : Colors.white,
                  blurRadius: 10.0,
                  spreadRadius: 0.5,
                  blurStyle: BlurStyle.outer)
            ],
            color: isLightMode(context) ? Colors.white : Colors.white10),
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: FilledButton(onPressed: onPressed,
                      style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))
                      ),
                      child: Text("Continue"))
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              successSvg, fit: BoxFit.contain,
            ),
            20.h,
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            12.h,
            Text(
              subTitle,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}