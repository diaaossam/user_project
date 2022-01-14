class RequestModel {
  String? uid;
  String? reason;
  String? date;
  bool? isRest;
  String? response;
  String? userName;

  RequestModel(
      {this.userName,
        required this.uid,
        required this.reason,
        required this.date,
        required this.response,
        required this.isRest});

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'reason': this.reason,
      'date': this.date,
      'response': this.response,
      'userName': this.userName,
      'type':isRest,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      uid: map['uid'] as String,
      reason: map['reason'] as String,
      date: map['date'] as String,
      response: map['response'] as String,
      userName: map['userName'] as String,
      isRest: map['type'],
    );
  }
}
