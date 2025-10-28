import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/auth/auth.dart';
import 'core/bindings/bindings.dart';
import 'core/credtrack-theme/theme.dart';
import 'core/credtrack-theme/util.dart';
import 'core/utils/device/device_utils.dart';
import 'core/utils/helper_functions/helper_functions.dart';
import 'features/splash/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  hideSystemBars();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepo()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Capriola", "Capriola");
    MaterialTheme theme = MaterialTheme(textTheme);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      navigatorKey: navigatorKey,
      darkTheme: theme.dark(),
      initialBinding: CredTrackBindings(),
      home: const SplashScreen(),
    );
  }
}
