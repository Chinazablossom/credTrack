
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cred_track/core/utils/common/snack_bars.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      if(results.isNotEmpty) _updateConnectionStatus(results.first);
    }) ;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if(_connectionStatus.value == ConnectivityResult.none){
      SnackBars.displaySnackBar(
          title: "Oh no....",
          message: "Looks like you're not connected to the internet",
          isWarning: true
      );
    }
  }

  Future<bool> isConnected() async{
    try{
    var result = await _connectivity.checkConnectivity();
    if(result == ConnectivityResult.none){
      return false;
    }else {
      return true;
    }
  } on PlatformException catch(_){
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }

}
