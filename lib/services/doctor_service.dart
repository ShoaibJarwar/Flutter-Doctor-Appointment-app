import 'package:doctor_appointment/models/doctor_model.dart';

class DoctorService {
  static List<DoctorModel> getDoctors() {
    return [
      DoctorModel(
        id: 1,
        name: "Dr. Ali",
        specialization: "Cardiologist",
        experience: 10,
        rating: 4.5,
      ),
      DoctorModel(
        id: 2,
        name: "Dr. Sara Khan",
        specialization: "Dermatologist",
        experience: 8,
        rating: 4.3,
      ),
      DoctorModel(
        id: 3,
        name: "Dr. Ahmed Raza",
        specialization: "Neurologist",
        experience: 12,
        rating: 4.7,
      ),
      DoctorModel(
        id: 4,
        name: "Dr. Fatima Noor",
        specialization: "Pediatrician",
        experience: 6,
        rating: 4.2,
      ),
      DoctorModel(
        id: 5,
        name: "Dr. Hassan Malik",
        specialization: "Orthopedic Surgeon",
        experience: 15,
        rating: 4.8,
      ),
    ];
  }
}
