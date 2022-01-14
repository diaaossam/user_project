import 'package:user_project/main_layout/main_layout.dart';
import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:user_project/screens/profile_screen/profile_screen.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/components/text_form_feild.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  UserModel userModel;
  ProfileScreenCubit cubit;

  Body(this.userModel, this.cubit);

  var fisrtName = TextEditingController();
  var lastName = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var dateOfBirth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileImage = cubit.profileImage;
    var coverImage = cubit.coverImage;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
        child: Column(
          children: [
            Container(
              height: SizeConfig.bodyHeight * 0.30,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: SizeConfig.bodyHeight * .22,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                  image: coverImage == null
                                      ? AssetImage("assets/images/cover.jpg")
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: getProportionateScreenHeight(20.0),
                          child: IconButton(
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: Icon(Icons.camera_alt)),
                        )
                      ],
                    ),
                    alignment: AlignmentDirectional.topCenter,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: SizeConfig.bodyHeight * .084,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          CircleAvatar(
                            radius: SizeConfig.bodyHeight * .08,
                            backgroundImage: profileImage == null
                                ? AssetImage("assets/images/defult_image.png")
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: getProportionateScreenHeight(20.0),
                        child: IconButton(
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                            icon: Icon(Icons.camera_alt)),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            DefultTextFormField(
              fisrtName..text = userModel.firstName ?? '',
              TextInputType.text,
              Icons.supervised_user_circle_sharp,
              'first name',
              (value) {
                if (value!.isEmpty) return 'first name is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              lastName..text = userModel.lastName ?? '',
              TextInputType.text,
              Icons.supervised_user_circle_sharp,
              'last name',
              (value) {
                if (value!.isEmpty) return 'last name is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              phone..text = userModel.phoneNumber ?? '',
              TextInputType.phone,
              Icons.phone,
              'phone',
              (value) {
                if (value!.isEmpty) return 'phone number is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              address..text = userModel.address ?? '',
              TextInputType.streetAddress,
              Icons.location_on_outlined,
              'Address',
              (value) {
                if (value!.isEmpty) return 'Address is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              dateOfBirth..text = userModel.dateOfBirth ?? '',
              TextInputType.datetime,
              Icons.date_range,
              'Date',
              (value) {
                if (value!.isEmpty) return 'Birth Date is required';
              },
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950, 1, 1),
                        lastDate: DateTime.now())
                    .then((value) {
                  dateOfBirth.text = DateFormat.yMMMd().format(value!);
                });
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            DefaultButton(
              text: 'Update',
              press: () {
                cubit.updateUserInfo({
                  'firstName': fisrtName.text,
                  'lastName': lastName.text,
                  'phoneNumber': phone.text,
                  'dateOfBirth': dateOfBirth.text,
                  'address': address.text,
                }).then((value) {
                  fisrtName.clear();
                  lastName.clear();
                  phone.clear();
                  dateOfBirth.clear();
                  address.clear();
                  dateOfBirth.clear();
                  navigateTo(context, MainLayout());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
