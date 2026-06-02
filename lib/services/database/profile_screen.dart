import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/database/db_helper.dart';
import 'package:doctor_appointment/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? email;

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) return;

    final db = DBHelper.instance;
    final user = await db.getUser(userId);
    if (!mounted) return;

    if (user != null) {
      setState(() {
        name = user.name;
        email = user.email;
      });
    }
  }

  void logout() async {
    await SessionService().logout();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Name : ${name ?? ''}"),
            SizedBox(height: 10),
            Text("Email: ${email ?? ''}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
