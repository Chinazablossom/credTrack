import 'package:cred_track/core/utils/common/back_button.dart';
import 'package:cred_track/core/utils/common/snack_bars.dart';
import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../controller/ticket_controller.dart';
import '../../admin/ui/admin_tickets_screen.dart';
import '../../../authentication/login/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/profile_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    final controller = Get.isRegistered<TicketController>()
        ? Get.find<TicketController>()
        : Get.put(TicketController(), permanent: true);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: getCardTheme(context),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isLightMode(context)
                          ? Colors.black.withValues(alpha: 0.16)
                          : Colors.black.withValues(alpha: 0.38),
                      blurRadius: 3,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CTBackButton(),
                    12.w,
                    Text(
                      "Profile",
                      style: textTheme.titleSmall?.copyWith(
                        color: theme.inverseSurface,
                      ),
                    ),
                    Spacer(),
                    FilledButton.icon(
                      onPressed: () {
                        final idCtrl = TextEditingController();
                        final passCtrl = TextEditingController();
                        final width = MediaQuery.sizeOf(context).width;
                        final dialogWidth = width >= 720 ? 680.0 : width * 0.92;

                        Get.dialog(
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 24,
                            ),
                            actionsPadding: EdgeInsets.only(
                              bottom: 16,
                              right: 16,
                            ),
                            title: SizedBox(
                              width: dialogWidth,
                              child: Text(
                                'Enter admin details',
                                style: textTheme.titleSmall,
                              ),
                            ),
                            content: SizedBox(
                              width: dialogWidth,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: idCtrl,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Admin ID',
                                      prefixIcon: SvgPicture.asset(
                                        idSvg,
                                        color: theme.outline,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  14.h,
                                  TextFormField(
                                    controller: passCtrl,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: SvgPicture.asset(
                                        lockSvg,
                                        color: theme.outline,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () {
                                  final adminId = idCtrl.text.trim();
                                  final password = passCtrl.text.trim();
                                  if (adminId == '21110591134' &&
                                      password == 'Qwerty@1') {
                                    Get.back();
                                    Get.off(
                                      () => const AdminTicketsScreen(),
                                      transition: Transition.rightToLeft,
                                      duration: 300.milliseconds,
                                    );
                                    SnackBars.displaySnackBar(
                                      title: 'Welcome ',
                                      message: 'You Logged in successfully',
                                      isSuccess: true,
                                    );
                                  } else {
                                    SnackBars.displaySnackBar(
                                      title: 'Error',
                                      message: 'Invalid admin credentials',
                                      isError: true,
                                    );
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      icon: SvgPicture.asset(loginSvg, color: theme.onPrimary),
                      label: const Text('Login as Admin'),
                    ),
                  ],
                ),
              ),
            ),

            // body
            Positioned.fill(
              top: 110,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Obx(() {
                  final user = controller.currentUser.value;
                  final imageUrl = user?.userImage ?? '';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.outline),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.person,
                                    color: theme.outline,
                                    size: 50,
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.person,
                                    color: theme.outline,
                                    size: 50,
                                  ),
                                ),
                        ),
                      ),

                      20.h,

                      ProfileField(
                        label: 'CredPal ID',
                        img: idSvg,
                        value: user?.userCredPalId ?? 'XXXXXXXXXXXX',
                      ),
                      16.h,
                      ProfileField(label: 'Name', value: user?.userName ?? ''),
                      16.h,
                      ProfileField(
                        label: 'Email',
                        img: emailSvg,
                        value: user?.userEmail ?? '',
                      ),

                      30.h,
                      FilledButton.icon(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAll(
                            () => const LoginScreen(),
                            transition: Transition.fadeIn,
                          );
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: Size(
                            getResponsiveSpacing(
                              context,
                              small: double.infinity,
                              medium: 500,
                              large: 600,
                            ),
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        label: const Text('Log out'),
                        icon: SvgPicture.asset(logoutSvg, color: theme.onPrimary),
                        iconAlignment: IconAlignment.end,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
