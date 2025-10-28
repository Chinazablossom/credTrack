import 'package:cred_track/core/credtrack-theme/theme.dart';
import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/core/utils/helper_functions/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../signup/ui/signup_screen.dart';
import '../controller/login_controller.dart';
import '../widget/auth_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    final controller = Get.isRegistered<LoginController>()
        ? Get.find<LoginController>()
        : Get.put(LoginController(), permanent: true);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [

            Positioned.fill(
              child: SvgPicture.asset(
                getBg(context),
                fit: BoxFit.cover,
              ),
            ),

            Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: getResponsiveSpacing(context,small: 12, medium: 30, large: 50), vertical: 24),
                  child: Column(
                    children: [

                      16.h,
                      AuthCard(
                        title: 'Log in',
                        subtitle: 'Welcome back to CredTrack.',
                        child: Form(
                          key: controller.loginFormKey,
                          child: Column(
                            children: [
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

                              Obx(() =>
                                  SizedBox(
                                    width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                    child: TextFormField(
                                      controller: controller.password,
                                      obscureText: controller.hidePassword.value,
                                      textInputAction: TextInputAction.done,
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
                                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                                    ),
                                  )),

                              8.h,
                              SizedBox(
                                width: getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),
                                child: Row(
                                  children: [
                                    Obx(() =>
                                        Checkbox(
                                          value: controller.rememberMe.value,
                                          onChanged: (val) =>
                                          controller.rememberMe.value =
                                              val ?? false,
                                        )),
                                    Text('Remember me', style: textTheme.bodySmall),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        // TODO:forgot password screen
                                      },
                                      child: Text('Forgot your password?',
                                        style: textTheme.bodySmall?.copyWith(
                                            color: theme.primary,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              8.h,

                              FilledButton(
                                  onPressed: () => controller.emailAndPasswordLogin(),
                                  style: FilledButton.styleFrom(
                                    minimumSize: Size(getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600), 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Log in'),
                                ),


                              12.h,
                              Row(
                                children: [
                                  Expanded(child: Divider(
                                      color: theme.outlineVariant)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('Or',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: theme.onSurfaceVariant)),
                                  ),
                                  Expanded(child: Divider(
                                      color: theme.outlineVariant)),
                                ],
                              ),
                              12.h,

                              OutlinedButton.icon(
                                icon: SvgPicture.asset(googleIcSvg, height: 20, width: 20),
                                onPressed: () => controller.googleSignIn(),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600),50),
                                ) ,
                                label: const Text('Log in with Google'),
                              ),

                              22.h,
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () => Get.offAll(
                                          () => const SignUpScreen(),
                                      transition: Transition.rightToLeft,
                                      duration: 300.milliseconds,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: textTheme.bodySmall?.copyWith(color: theme.onSurface,
                                        ),
                                        children: [
                                          TextSpan(text: "Don't have an account? "),
                                          TextSpan(
                                            text: "Sign Up",
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

