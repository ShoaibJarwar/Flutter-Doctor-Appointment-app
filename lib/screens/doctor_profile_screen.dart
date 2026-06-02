import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      appBar: AppBar(title: Text(doctor.name)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(doctor.name),
                subtitle: Text(
                  '${doctor.specialization} • ${doctor.experience} yrs',
                ),
                trailing: Text('⭐ ${doctor.rating}'),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.bookAppointment,
                  arguments: doctor,
                );
              },
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
