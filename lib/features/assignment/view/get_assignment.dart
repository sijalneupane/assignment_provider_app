import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider_test1/utils/api_const.dart';
import 'package:provider_test1/utils/snackbar.dart';
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
  Response? response;
  @override
  void initState() {
    getAssignment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 235, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 106, 97),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          getAssignmentStr,
          style: TextStyle(color: const Color(0xFFFFFFFF)),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 00,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 106, 97),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(800))),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 51, 81, 119),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(600))),
              )),
          response != null
              ? Column(
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
                                    "Total Assignments = ${response?.data["list"].length}",
                               
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: response?.data["list"].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Card(
                                color: const Color(0xFFFFFFFF),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            data: response?.data["list"][index]
                                                ["title"],
                                            // type: "heading",
                                          ),
                                          Spacer(),
                                          CustomText(
                                            data: response?.data["list"][index]
                                                ["subjectName"],
                                            // type: "heading",
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      CustomText(
                                        data: response?.data["list"][index]
                                            ["faculty"],
                                        // type: "subHeading",
                                      ),
                                      CustomText(
                                        data: response?.data["list"][index]
                                            ["semester"],
                                        // type: "subHeading",
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              data: response?.data["list"]
                                                  [index]["description"],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          CustomIconButton(
                                            onPressed: () {},
                                            edit: true,
                                            color: Colors.green,
                                          ),
                                          CustomIconButton(
                                            onPressed: () {},
                                            edit: false,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Loading...")
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  getAssignment() async {
    Dio dio = Dio();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("authToken"); // Retrieve the token
      if (token != null && token.isNotEmpty) {
        // url += "?token=$token"; // Append token as a query parameter
        dio.options.headers["Authorization"] = "Bearer $token";
      }
      String url = ApiConst.baseUrl + ApiConst.getAssignmentApi;
      response = await dio.get(url);
      setState(() {
        response;
      });
    } catch (e) {
      displaySnackBar(context, e.toString());
    }
  }
}
