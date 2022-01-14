
class UserModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? isActive;
  String? sallary;
  String? sallaryThen;
  String? increment;
  String? image;
  String ? cover;
  String? dateOfBirth;
  String? uid;
  String? jobDesc;
  String? militryService;
  String? department;
  String? hire;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    this.sallary,
    this.sallaryThen,
    this.increment,
    this.image,
    this.cover,
    required this.uid,
    this.isActive,
    this.jobDesc,
    this.department,
    this.hire,
    this.militryService});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    sallary = json['sallary'];
    sallaryThen = json['sallaryThen'];
    increment = json['increment'];
    image = json['image'];
    dateOfBirth = json['dateOfBirth'];
    uid = json['uid'];
    cover=json['cover'];
    jobDesc = json['jobDesc'];
    department = json['department'];
    militryService = json['militryService'];
    isActive = json['isActive'];
    hire = json['hire'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'sallary': sallary,
      'increment': increment,
      'image': image,
      'dateOfBirth': dateOfBirth,
      'uid': uid,
      'jobDesc': jobDesc,
      'cover':cover,
      'department': department,
      'militryService': militryService,
      'isActive': isActive,
      'sallaryThen':sallaryThen,
      'hire':hire,
    };
  }


}
