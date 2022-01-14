class TokenModel {
  String? uid;
  bool? isAdmin;
  String? token;

  TokenModel({required this.uid, required this.isAdmin, required this.token});

  TokenModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    isAdmin = json['isAdmin'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {"uid": uid, "isAdmin": isAdmin, "token": token};
  }
}
