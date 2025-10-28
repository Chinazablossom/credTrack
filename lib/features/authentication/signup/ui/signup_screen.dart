import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/core/utils/helper_functions/validators.dart';
import 'package:cred_track/features/authentication/login/widget/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/credtrack-theme/theme.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../login/ui/login_screen.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    final controller = Get.isRegistered<SignUpController>()
        ? Get.find<SignUpController>()
        : Get.put(SignUpController(), permanent: true);

    final confirmPassword =
        Get.isRegistered<TextEditingController>(tag: 'signup_confirm')
        ? Get.find<TextEditingController>(tag: 'signup_confirm')
        : Get.put<TextEditingController>(
            TextEditingController(),
            tag: 'signup_confirm',
          );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(getBg(context), fit: BoxFit.cover),
            ),

            Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      16.h,

                      AuthCard(
                        title: "Sign up",
                        subtitle: "Create your CredTrack account.",
                        child: Form(
                          key: controller.signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Name
                              SizedBox(
                                width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                child: TextFormField(
                                  controller: controller.userName,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode: AutovalidateMode.onUnfocus,
                                  decoration: InputDecoration(
                                    labelText: 'Full name',
                                    hintText: 'John Doe',
                                    prefixIcon: Icon( Icons.person, color: theme.outline),
                                  ),
                                  validator: (name) => Validator.validateName(name),
                                ),
                              ),
                              14.h,

                              // Email
                              SizedBox(
                                width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                child: TextFormField(
                                  controller: controller.email,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'example@gmail.com',
                                    prefixIcon: SvgPicture.asset(emailSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                                  ),
                                  validator: (email) => Validator.validateEmail(email),
                                ),
                              ),

                              14.h,

                              // id
                              SizedBox(
                                width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                child: TextFormField(
                                  controller: controller.credPalId,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'CredPal Id',
                                    hintText: 'e.g 21110591134',
                                    prefixIcon: SvgPicture.asset(idSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                                  ),
                                  validator: (id) =>
                                      Validator.validateEmptyText(id, "ID"),
                                ),
                              ),

                              14.h,

                              // Password
                              Obx(
                                () => SizedBox(
                                  width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                  child: TextFormField(
                                    controller: controller.password,
                                    obscureText: controller.hidePassword.value,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: '********',
                                      prefixIcon: SvgPicture.asset(lockSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            controller.hidePassword.value =
                                                !controller.hidePassword.value,
                                        icon: SvgPicture.asset(
                                          controller.hidePassword.value ? eyeOpen : eyeClose,
                                          color: theme.outline, fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    validator: (password) => Validator.validatePassword(password),
                                  ),
                                ),
                              ),

                              14.h,
                              // Confirm Password
                              SizedBox(
                                width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                child: TextFormField(
                                  controller: confirmPassword,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm password',
                                    hintText: '********',
                                    prefixIcon: SvgPicture.asset(lockSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Please confirm your password';
                                    if (value != controller.password.text)
                                      return 'Passwords do not match';
                                    return null;
                                  },
                                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                                ),
                              ),

                              16.h,
                              FilledButton(
                                onPressed: () => controller.signUp(),
                                style: FilledButton.styleFrom(
                                  minimumSize: Size(
                                   getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                    50
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Sign up'),
                              ),

                              12.h,
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(color: theme.outlineVariant),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      'Or',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: theme.outlineVariant,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(color: theme.outlineVariant),
                                  ),
                                ],
                              ),
                              12.h,
                              OutlinedButton.icon(
                                icon: SvgPicture.asset(
                                  googleIcSvg,
                                  height: 20,
                                  width: 20,
                                ),
                                onPressed: () => controller.googleSignIn(),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600), 50)
                                ),
                                label: const Text('Sign up with Google'),
                              ),

                              22.h,
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () => Get.offAll(() => const LoginScreen(),
                                        transition: Transition.leftToRight,
                                        duration: 300.milliseconds
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: textTheme.bodySmall?.copyWith(color: theme.onSurface),
                                        children: [
                                          TextSpan(text: "Already have an account? "),
                                          TextSpan(
                                            text: "Log in",
                                            style: textTheme.bodySmall?.copyWith(
                                              color: theme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                      30.h,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: getResponsiveSpacing(context,small: 16,medium: 30,large: 80),
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'CredTrack',
                  style: textTheme.displayMedium?.copyWith(
                    color: isLightMode(context) ? Colors.white : MaterialTheme.darkScheme().primary,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: isLightMode(context) ? Colors.black54 : Colors.white12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
