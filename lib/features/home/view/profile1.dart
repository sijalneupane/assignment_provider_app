import 'package:flutter/material.dart';
import 'package:provider_test1/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider_test1/utils/string_const.dart';
import 'package:provider_test1/widgets/custom_text.dart';

class Profile1 extends StatefulWidget {
  const Profile1({super.key});

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  String name = '';
  String username = '';
  String role = '';
  String email = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'N/A';
      username = prefs.getString('username') ?? 'N/A';
      role = prefs.getString('role') ?? 'N/A';
      email = prefs.getString('email') ?? 'N/A';
      id = prefs.getString('id') ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
        title: const Text('Profile'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CustomText(data:"Here is your profile details" ,
                          fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              color: Colors.lightBlue[60],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: 'Name: $name',
                      fontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      data: 'Username: $username',
                      fontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      data: 'Role: $role',
                      fontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      data: 'Email: $email',
                      fontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      data: 'ID: $id',
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: _loadUserData,
            //     child: const Text('Refresh Data'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}