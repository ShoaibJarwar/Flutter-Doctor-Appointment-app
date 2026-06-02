class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final int experience;
  final double rating;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.rating,
  });

  // Map<String, dynamic> map() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'specialization': specialization,
  //     'experience': experience,
  //     'rating': rating,
  //   };
  // }
}
