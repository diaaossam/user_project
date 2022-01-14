


import 'package:user_project/models/user_model.dart';

const String USER_UID = 'uid';
const String ON_BOARDING = 'credential';
const String USERS = 'users';
const String DEFUlt = 'defult';
const String WAITING = 'waiting';
const String REQUEST = 'request';
const String USERS_REQUESTS = 'oldReq';
const String CHECK_IN = 'checkin';
const String REPORT = 'report';
const String CHECK_OUT = 'checkout';

const String DARK_MODE = 'darkmode';
const String ATTENDANCE = 'attendace';
const String BASE_URL = 'https://fcm.googleapis.com/';
const String ServerKey = 'AAAAU_UtWiA:APA91bHVFhnYgsBXuF7QPI431usELGMBGKO3KZsfqCv25XJ2ZYP3UYaoVMSc7jUWeJR8jK4jMJPywfWVXBw8SO1Yi2e82NmKxXV-33e8Y__p17LsbNfYIf9YgbklpZtO91sWDXa0ohz6';



// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
