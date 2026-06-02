import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/doctor_service.dart';
import 'package:doctor_appointment/services/session_service.dart';
import 'package:flutter/material.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = DoctorService.getDoctors();

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, AppRoutes.appointmentHistory);
            },
            icon: Icon(Icons.history),
          ),
          IconButton(
            onPressed: () async {
              await SessionService().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(doctor.name),
              subtitle: Text(
                '${doctor.specialization} • ${doctor.experience} yrs',
              ),
              trailing: Text('⭐ ${doctor.rating}'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.doctorProfile,
                  arguments: doctor,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
