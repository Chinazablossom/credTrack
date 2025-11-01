import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/utils/constants/asset_paths.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';

class FaqScroller extends StatelessWidget {
  const FaqScroller({super.key, required this.onTap});

  final void Function(Faq) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    return SizedBox(
      height: 65,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: faqList.length,
        separatorBuilder: (_, __) => 10.w,
        itemBuilder: (_, i) {
          final f = faqList[i];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onTap(f),
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color:theme.secondaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SvgPicture.asset(supportSvg, color: theme.onSecondaryContainer,),
                  8.w,
                  Expanded(
                    child: Text(
                      f.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.onSecondaryContainer,
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void openFaq(BuildContext context, Faq faq) {
  final theme = getTheme(context);
  final textTheme = getTextTheme(context);
  final width = MediaQuery.sizeOf(context).width;
  final dialogWidth = width >= 720 ? 680.0 : width * 0.92;

  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      actionsPadding: EdgeInsets.only(bottom: 16,right: 16,),
      scrollable: true,
      title: SizedBox(
        width: dialogWidth,
        child: Text(
          faq.title,
          style: textTheme.labelSmall,
        ),
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1),
            8.h,
            Text(
              faq.answer,
              style: textTheme.bodyMedium
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: Get.back,
          style: FilledButton.styleFrom(
            foregroundColor: theme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Close',
          ),
        ),
      ],
    ),
  );
}

class Faq {
  final String title;
  final String answer;

  const Faq(this.title, this.answer);
}

const List<Faq> faqList = [
  Faq("What is CredPal's Buy now pay later",
      "CredPal's Buy Now Pay Later BNPL gives you access to buy any product from Credpal's authorized merchants, make a down payment, then you can spread the remaining payment over a couple of months as selected on the app."),

  Faq('How can i increase my credit limit',
      ''' We are always pleased to increase the credit limit of your credit card. An account with a high-performance rating may be reviewed and granted a higher credit limit. To increase your credit limit, on the homepage in your credpal app click on 'Cash Transfer", click on "Transfer icon". At the bottom of the transfer page, click on "Request limit increase", input the information required and continue. Please know that you are to upload your recent documents (4 months updated salary bank statement, a scanned copy of your work ID and your most recent utility bill) on the app for review.
             '''),
  Faq(
    'Can i change my card plan',
    'Yes, it comes at a cost. If you are trying to move to a higher plan, you would have to pay the subscription fee for the new plan.',
  ),
  Faq(
    'How can i add another debit card for repayment',
    'Login into your CredPal app. Click on the menu tab at the bottom right side of the screen, then click on the My Card Tab. Click on Add card in front of the Repayment Card and enter your card details. Please Note: You will be charged for the transaction.',
  ),
  Faq(
    'How do i add my card',
    '''Click on Menu on the bottom navigation bar. Click on 'My Cards'. Click on '+ Add card' at the right side of the screen. A page informing you Of the N50 charge appears for this transaction. Click on 'Next', input your card details and complete the transaction.''',
  ),
];
