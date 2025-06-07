import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/utils/date_formatter.dart';
import 'package:provider_test1/utils/edit_delete_button.dart';
import 'package:provider_test1/utils/interactive_viewer.dart';
import 'package:provider_test1/utils/loading_and_error_builder%20copy.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider_test1/features/notices/provider/notices_provider.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class GetNoticeScreen extends StatefulWidget {
  const GetNoticeScreen({Key? key}) : super(key: key);

  @override
  State<GetNoticeScreen> createState() => _GetNoticeScreenState();
}

class _GetNoticeScreenState extends State<GetNoticeScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      await Provider.of<NoticesProvider>(context, listen: false).loadUserRole();
      await Provider.of<NoticesProvider>(context, listen: false).getNotice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(noticesStr)),
      body: Consumer<NoticesProvider>(
        builder:
            (context, noticesProvider, child) => Center(
              child: Stack(
                children: [
                  _noticeUi(noticesProvider),
                  noticesProvider.getGetNetworkStatus == NetworkStatus.loading
                      ? Loader.backdropFilter(context)
                      : const SizedBox(),
                ],
              ),
            ),
      ),
    );
  }

  Widget _noticeUi(NoticesProvider noticesProvider) {
    return noticesProvider.notices.isEmpty
        ? Center(child: CustomText(data: noNoticesAvailable))
        : RefreshIndicator.adaptive(
          onRefresh: () async {
            await noticesProvider.getNotice();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: noticesProvider.notices.length,
            itemBuilder: (context, index) {
              final notice = noticesProvider.notices[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          notice.title ?? noTitleStr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Notice image
                        if (notice.noticeImageURL != null &&
                            notice.noticeImageURL!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                MyInteractiveViewer().myInteractiveViewer(context, Image.network(notice.noticeImageURL!));
                              },
                              child: Image.network(
                                notice.noticeImageURL!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    LoadingAndErrorBuilder().customErrorBuilder(height: 200),
                                loadingBuilder:
                                    LoadingAndErrorBuilder()
                                        .customLoadingBuilder(height: 200),
                              ),
                            ),
                          ),

                        const SizedBox(height: 8),

                        // Priority and category
                        Row(
                          children: [
                            Text(
                              '$priorityStr: ${notice.priority ?? naStr}',
                              style: TextStyle(
                                fontSize: 14,
                                color: _getPriorityColor(notice.priority),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '$categoryStr: ${notice.category ?? naStr}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Issued by
                        // Text(
                        //   '$issuedByStr: ${notice.issuedByUsername ?? unknownStr} ($idStr: ${notice.issuedBy ?? naStr})',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.grey[700],
                        //   ),
                        // ),

                        // const SizedBox(height: 8),

                        // Target audience
                        Text(
                          '$targetAudienceStr: ${notice.targetAudience?.join(', ') ?? naStr}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Created/Updated Date
                        Text(
                          '$createdDateStr: ${DateFormatter().formatDate(notice.createdAt!)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '$updatedDateStr: ${DateFormatter().formatDate(notice.updatedAt!)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        // Admin Buttons
                        if (noticesProvider.userRole == 'admin') ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              EditDeleteButton().editButton(
                                context: context,
                                route: Routes.addNoticeRoute,
                                arguments: noticesProvider.notices[index],
                              ),
                              EditDeleteButton().deleteButton(
                                context: context,
                                dialogTitle: deleteAssignmentTitleStr,
                                dialogMessage:
                                    deleteAssignmentMessageConfirmStr,
                                onOkPressed: () {},
                              ),
                              // ElevatedButton.icon(
                              //   onPressed: () {
                              //     // TODO: Navigate to Edit screen
                              //   },
                              //   icon: const Icon(Icons.edit),
                              //   label: const Text('Edit'),
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.blueAccent,
                              //   ),
                              // ),
                              // const SizedBox(width: 12),
                              // ElevatedButton.icon(
                              //   onPressed: () {
                              //     // TODO: Show confirmation then delete
                              //   },
                              //   icon: const Icon(Icons.delete),
                              //   label: const Text('Delete'),
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.redAccent,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
