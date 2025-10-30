import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../controller/ticket_controller.dart';
import '../../details/ui/ticket_details_screen.dart';
import '../../create/ui/create_ticket_screen.dart';
import '../widgets/faq.dart';
import '../widgets/status_chip.dart';

class DashboardScreen extends GetView<TicketController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TicketController(), permanent: true);
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(
          () => const CreateTicketScreen(),
          transition: Transition.rightToLeft,
          duration: 500.milliseconds,
        ),
        label: const Text('Create Ticket'),
        icon: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              final name = controller.currentUser.value?.userName.split(" ")[0]  ?? '';
              return Container(
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
                      blurRadius: 10,
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
                        Obx(() {
                          final imageUrl = controller.currentUser.value?.userImage ?? '';
                          return Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.outline),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Icon(
                                Icons.person,
                                color: theme.outline,
                              ),
                            )
                                : Center(
                              child: Icon(
                                Icons.person,
                                color: theme.outline,
                              ),
                            ),
                          );
                        }),
                        12.w,
                        Text(
                          name.isEmpty ? 'Hi 👋🏽' : 'Hi, $name 👋🏽',
                          style: textTheme.titleSmall?.copyWith(
                            color: theme.inverseSurface,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.outline),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                            child: Icon(
                              CupertinoIcons.line_horizontal_3_decrease,
                              color: theme.outline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: FaqScroller(onTap: (faq) => openFaq(context, faq)),
          ),

          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.tickets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(emptyTicketsSvg,height: 200,width: 200,),
                    8.h,
                    Text(
                      'No tickets yet. Issue a ticket to get started.',
                      style: textTheme.bodyLarge?.copyWith(color: theme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }


            return Positioned(
              top: 185,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: controller.tickets.length,
                separatorBuilder: (_, __) => 12.h,
                itemBuilder: (context, index) {
                  final ticket = controller.tickets[index];
                  return InkWell(
                    onTap: () => Get.to(() => TicketDetailsScreen(ticket: ticket),
                      transition: Transition.rightToLeft,
                      duration: 500.milliseconds
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getCardTheme(context),
                        borderRadius: BorderRadius.all(Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isLightMode(context)
                                ? Colors.black.withValues(alpha: 0.16)
                                : Colors.black.withValues(alpha: 0.38),
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ticket.title, style: textTheme.labelSmall?.copyWith(
                                    color: theme.onSurfaceVariant
                                  )),
                                  8.h,
                                  Text(
                                   "Category:  ${ticket.category}",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: theme.onSurfaceVariant,
                                    ),
                                  ),
                                  4.h,
                                  Text(
                                    DateFormat('On MMM dd, yyyy - HH:mm: a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        ticket.createdAt,
                                      ).toLocal(),
                                    ),
                                    style: textTheme.bodySmall?.copyWith(
                                      color: theme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            12.w,
                            StatusChip(status: ticket.status),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );

          }),
        ],
      ),
    );
  }
}
