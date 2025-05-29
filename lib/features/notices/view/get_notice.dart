import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/notices/model/get_notices_model.dart';
import 'package:provider_test1/features/notices/provider/notices_provider.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/string_const.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoticesProvider>(
      create: (_) => NoticesProvider()..getNotice(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(noticesStr),
          // backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<NoticesProvider>(
          builder: (context, noticesProvider, child) {
            if (noticesProvider.getGetNetworkStatus== NetworkStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (noticesProvider.getGetNetworkStatus == NetworkStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      noticesProvider.errorMsg ?? failedToFetchNotices,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => noticesProvider.getNotice(),
                      child: const Text(retryStr),
                    ),
                  ],
                ),
              );
            } else if (noticesProvider.getGetNetworkStatus == NetworkStatus.success) {
              if (noticesProvider.notices.isEmpty) {
                return const Center(child: Text(noNoticesAvailable));
              }
              return ListView.builder(
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
                            Text(
                              notice.title ?? noTitleStr,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$dateStr: ${notice.noticeDate ?? naStr}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice.content ?? noContentStr,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
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
                            Text(
                              '$issuedByStr: ${notice.issuedByUsername ?? unknownStr} ($idStr: ${notice.issuedBy ?? naStr})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$targetAudienceStr: ${notice.targetAudience?.join(', ') ?? naStr}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$createdDateStr: ${notice.createdAt ?? naStr}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              '$updatedDateStr: ${notice.updatedAt ?? naStr}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text(initializingStr));
          },
        ),
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