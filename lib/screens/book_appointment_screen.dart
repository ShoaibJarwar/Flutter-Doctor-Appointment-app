import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final doctor = ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      appBar: AppBar(title: Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Doctor Info
            Card(
              child: ListTile(
                title: Text(doctor.name),
                subtitle: Text(
                  '${doctor.specialization} • ${doctor.experience} yrs',
                ),
                trailing: Text('⭐ ${doctor.rating}'),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Select Date Button
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Text(
                selectedDate == null
                    ? 'Select Date'
                    : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Select Time Button
            ElevatedButton(
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              child: Text(
                selectedTime == null
                    ? 'Select Time'
                    : 'Time: ${selectedTime!.format(context)}',
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Book Button
            ElevatedButton(
              onPressed: () async {
                if (selectedDate == null || selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select date and time'),
                    ),
                  );
                  return;
                }

                // ✅ Step 1: Get userId
                final prefs = await SharedPreferences.getInstance();
                final userId = prefs.getInt('userId');

                if (userId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User not logged in')),
                  );
                  return;
                }

                final doctor =
                    ModalRoute.of(context)!.settings.arguments as DoctorModel;

                final appointment = AppointmentModel(
                  userId: userId,
                  doctorId: doctor.id,
                  date: selectedDate!.toString().split(' ')[0],
                  time: selectedTime!.format(context),
                );

                final db = DBHelper.instance;
                await db.insertAppointment(appointment);

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment Booked Successfully'),
                  ),
                );

                Navigator.pushNamed(context, AppRoutes.doctorList);
              },
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
