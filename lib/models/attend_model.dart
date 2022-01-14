class AttendanceModel {
  bool isAttend;
  String attendTime;
  String leaveTime;
  String year;
  String monthDay;

  AttendanceModel(
      {required this.isAttend,
      required this.attendTime,
      required this.leaveTime,
      required this.year,
      required this.monthDay});

  Map<String, dynamic> toMap() {
    return {
      'isAttend': this.isAttend,
      'attendTime': this.attendTime,
      'leaveTime': this.leaveTime,
      'year': this.year,
      'monthDay': this.monthDay,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      isAttend: map['isAttend'] as bool,
      attendTime: map['attendTime'] as String,
      leaveTime: map['leaveTime'] as String,
      year: map['year'] as String,
      monthDay: map['monthDay'] as String,
    );
  }
}
