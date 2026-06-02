import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/services/database/db_helper.dart';
import 'package:doctor_appointment/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  const AppointmentHistoryScreen({super.key});

  Future<List<AppointmentModel>> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) return [];

    return DBHelper.instance.getAppointmentsByUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    final doctors = DoctorService.getDoctors();
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: FutureBuilder<List<AppointmentModel>>(
        future: _loadAppointments(),
        builder: (context, snapshot) {
          // 🔹 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔹 No Data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No appointments found'));
          }

          final appointments = snapshot.data!;

          // 🔹 List
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              final doctor = doctors.firstWhere((d) => d.id == appt.doctorId);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(doctor.name),
                  subtitle: Text(
                    '${doctor.specialization}\nDate: ${appt.date} • Time: ${appt.time}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DBHelper.instance.deleteAppointment(appt.id!);
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
