import 'package:cred_track/core/utils/common/back_button.dart';
import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/core/utils/helper_functions/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../dashboard/widgets/evidence_preview.dart';
import '../controller/create_ticket_controller.dart';

class CreateTicketScreen extends GetView<CreateTicketController> {
  const CreateTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateTicketController());
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
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
                    blurRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CTBackButton(),
                      12.w,
                      Text(
                        "Create Ticket",
                        style: textTheme.titleSmall?.copyWith(
                          color: theme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: getResponsiveSpacing(
                  context,
                  small: double.infinity,
                  medium: 600,
                  large: 700,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: getCardTheme(context),
                  boxShadow: [
                    BoxShadow(
                      color: isLightMode(context)
                          ? Colors.black.withValues(alpha: 0.16)
                          : Colors.black.withValues(alpha: 0.38),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(12),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.txRefCtrl,
                        keyboardType: TextInputType.phone,
                        decoration:  InputDecoration(
                          labelText: 'Transaction ID (optional)',
                          hintText: "eg. TXN-1234567890",
                          prefixIcon: SvgPicture.asset(ticketIdSvg, color: theme.outline, fit: BoxFit.scaleDown),
                        ),
                      ),

                      14.h,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SvgPicture.asset(outlinedAlertSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                            6.w,
                            Text(
                              'Issue Type',
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      2.h,
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.category.value,
                          style: textTheme.bodyMedium,
                          borderRadius: BorderRadius.circular(12),
                          items: const [
                            DropdownMenuItem(
                              value: 'General',
                              child: Text('General'),
                            ),
                            DropdownMenuItem(
                              value: 'Payments',
                              child: Text('Payments'),
                            ),
                            DropdownMenuItem(
                              value: 'Account',
                              child: Text('Account'),
                            ),
                            DropdownMenuItem(
                              value: 'Wallet',
                              child: Text('Wallet'),
                            ),
                            DropdownMenuItem(
                              value: 'Bills',
                              child: Text('Bills'),
                            ),
                            DropdownMenuItem(
                              value: 'Card',
                              child: Text('Card'),
                            ),
                          ],
                          onChanged: (v) =>
                              controller.category.value = v ?? 'General',
                        ),
                      ),

                      14.h,
                      TextFormField(
                        controller: controller.titleCtrl,
                        decoration: InputDecoration(labelText: 'Title',
                          prefixIcon:  Icon(CupertinoIcons.tickets,color: theme.outline,size: 18, ),
                        ),
                        validator: (title) => Validator.validateEmptyText("Title", title),
                      ),

                      14.h,
                      TextFormField(
                        controller: controller.descCtrl,
                        minLines: 4,
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Describe your issue here, please be as detailed as possible.',
                          prefixIcon: SvgPicture.asset(complaintSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                        ),
                        validator: (descp) =>
                            Validator.validateEmptyText("Description", descp),
                      ),

                      14.h,

                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: controller.pickImage,
                                icon: const Icon(Icons.attachment),
                                label: Text(
                                  controller.pickedImagePath.value == null
                                      ? 'Attach evidence'
                                      : 'Change attachment',
                                ),
                              ),
                            ),
                            12.w,
                            EvidencePreview(
                              path: controller.pickedImagePath.value,
                            ),
                          ],
                        ),
                      ),

                      20.h,
                      Obx(
                        () => FilledButton(
                          onPressed: controller.isSaving.value
                              ? null
                              : () async {
                                  if (!(controller.formKey.currentState?.validate() ?? false)) return;
                                  await controller.create();
                                  Get.back();
                                },
                          style: FilledButton.styleFrom(
                            minimumSize: Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isSaving.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
