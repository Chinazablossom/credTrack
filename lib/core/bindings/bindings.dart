import 'package:cred_track/core/auth/auth.dart';
import 'package:get/get.dart';

import '../../features/main/controller/ticket_controller.dart';
import '../utils/common/network_manager.dart';
import '../../features/splash/splash_controller.dart';
import '../../features/authentication/login/controller/login_controller.dart';
import '../../features/authentication/signup/controller/signup_controller.dart';

class CredTrackBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(), permanent: true);
    Get.put(NetworkManager());
    Get.put(AuthenticationRepo());
    // Auth controllers
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpController>(() => SignUpController());

    Get.put(TicketController(), permanent: true);

  }
}
