class AppointmentModel {
  final int? id;
  final int userId;
  final int doctorId;
  final String date;
  final String time;

  AppointmentModel({
    this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      userId: map['userId'],
      doctorId: map['doctorId'],
      date: map['date'],
      time: map['time'],
    );
  }

  @override
  String toString() {
    return 'AppointmentModel(id: $id, userId: $userId, doctorId: $doctorId, date: $date, time: $time)';
  }
}
