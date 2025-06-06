import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test1/features/assignment/provider/assignment_provider.dart';
import 'package:provider_test1/features/login/provider/login_provider.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/dialog_box.dart';
import 'package:provider_test1/utils/network_status.dart';
import 'package:provider_test1/utils/route_const.dart';
import 'package:provider_test1/utils/route_generator.dart';
import 'package:provider_test1/utils/snackbar.dart';
import 'package:provider_test1/utils/spin_kit.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_icon_button.dart';
import 'package:provider_test1/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAssignment extends StatefulWidget {
  const GetAssignment({super.key});

  @override
  State<GetAssignment> createState() => _GetAssignmentState();
}

class _GetAssignmentState extends State<GetAssignment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Delay the call to ensure context is available
    Future.microtask(() {
      Provider.of<AssignmentProvider>(context, listen: false).getAssignment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 106, 97),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
           Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          getAssignmentStr,
          style: TextStyle(color: const Color(0xFFFFFFFF)),
        ),
      ),
      body: Consumer<AssignmentProvider>(
        builder:
            (context, assignmentProvider, child) => Stack(
              children: [
                Positioned(
                  top: 00,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 106, 97),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(800),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 81, 119),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(600),
                      ),
                    ),
                  ),
                ),
                RefreshIndicator.adaptive(
                  onRefresh: () => assignmentProvider.getAssignment(),
                  child: _getAssignmentUi(assignmentProvider),
                ),
                assignmentProvider.getGetAssignmentStatus ==
                        NetworkStatus.loading
                    ? Loader.backdropFilter(context)
                    : SizedBox(),
              ],
            ),
      ),
    );
  }

  Widget _getAssignmentUi(AssignmentProvider assignmentProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CustomText(
                    data:
                        "Total Assignments = ${assignmentProvider.assignmentList.length}",
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: assignmentProvider.assignmentList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              data:
                                  assignmentProvider
                                      .assignmentList[index]
                                      .subjectName,
                              // type: "heading",
                            ),
                            Spacer(),
                            CustomText(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              data:
                                  assignmentProvider.assignmentList[index].id
                                      .toString(),
                              // type: "heading",
                            ),
                          ],
                        ),
                        CustomText(
                          fontWeight: FontWeight.w500,
                          data: assignmentProvider.assignmentList[index].title,
                          // type: "heading",
                        ),
                        Divider(color: Colors.blue),
                        CustomText(
                          data:
                              assignmentProvider.assignmentList[index].faculty,
                          // type: "subHeading",
                        ),
                        CustomText(
                          data:
                              assignmentProvider.assignmentList[index].semester,
                          // type: "subHeading",
                        ),
                        CustomText(
                          data:
                              assignmentProvider
                                  .assignmentList[index]
                                  .description,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            CustomIconButton(
                              onPressed: () {
                                RouteGenerator.navigateToPage(
                                  context,
                                  Routes.addAssignment,
                                  arguments:
                                      assignmentProvider.assignmentList[index],
                                );
                              },
                              edit: true,
                              color: Colors.green,
                            ),
                            CustomIconButton(
                              onPressed: () {
                                DialogBox.showConfirmBox(
                                  context: context,
                                  title: deleteAssignmentTitleStr,
                                  message: deleteAssignmentMessageConfirmStr,
                                  onOkPressed: () {
                                    assignmentProvider.deleteAssignmentById(
                                      assignmentProvider
                                          .assignmentList[index]
                                          .id
                                          .toString(),
                                    );
                                  },
                                );
                              },
                              edit: false,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // getAssignment() async {
  //   Dio dio = Dio();
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? token = prefs.getString("authToken"); // Retrieve the token
  //     if (token != null && token.isNotEmpty) {
  //       // url += "?token=$token"; // Append token as a query parameter
  //       dio.options.headers["Authorization"] = "Bearer $token";
  //     }
  //     String url = ApiConst.baseUrl + ApiConst.getAssignmentApi;
  //     assignmentProvider.assignmentList = await dio.get(url);
  //     setState(() {
  //       assignmentProvider.assignmentList;
  //     });
  //   } catch (e) {
  //     displaySnackBar(context, e.toString());
  //   }
  // }
}
