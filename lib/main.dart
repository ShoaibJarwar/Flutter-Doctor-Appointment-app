import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/screens/appointment_history_screen.dart';
import 'package:doctor_appointment/screens/book_appointment_screen.dart';
import 'package:doctor_appointment/screens/doctor_list_screen.dart';
import 'package:doctor_appointment/screens/doctor_profile_screen.dart';
// import 'package:doctor_appointment/screens/home_screen.dart';
import 'package:doctor_appointment/screens/login_screen.dart';
import 'package:doctor_appointment/screens/signup_screen.dart';
import 'package:doctor_appointment/services/database/profile_screen.dart';
import 'package:doctor_appointment/services/session_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.signup: (context) => SignupScreen(),
        AppRoutes.home: (context) => DoctorListScreen(),
        AppRoutes.doctorProfile: (context) => DoctorProfileScreen(),
        AppRoutes.bookAppointment: (context) => BookAppointmentScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.appointmentHistory: (context) => AppointmentHistoryScreen(),
        AppRoutes.doctorList: (context) => DoctorListScreen(),
      },
      title: 'Doctor Appointment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
        future: SessionService().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          final isLoggedIn = snapshot.data ?? false;
          if (isLoggedIn) {
            return DoctorListScreen();
          } else {
            return SignupScreen();
          }
        },
      ),
    );
  }
}
