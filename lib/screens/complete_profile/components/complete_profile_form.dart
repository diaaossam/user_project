import 'package:user_project/main_layout/main_layout.dart';
import 'package:user_project/screens/complete_profile/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:user_project/screens/complete_profile/complete_profile_cubit/complete_profile_states.dart';
import 'package:user_project/screens/login_check/login_check_screen.dart';
import 'package:user_project/shared/components/custom_surfix_icon.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/components/form_error.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  var firstname = TextEditingController();
  var lastName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var birthDate = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                buildFirstNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildLastNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildAddressFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildBirthDateFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                DefaultButton(
                  text: "continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      CompleteProfileCubit.get(context)
                          .setUserInfo(
                        firstName: firstname.text,
                        lastName: lastName.text,
                        phoneNumber: phoneNumber.text,
                        address: address.text,
                        birthdate: birthDate.text,
                      )
                          .then((value) {
                        firstname.clear();
                        lastName.clear();
                        phoneNumber.clear();
                        address.clear();
                        birthDate.clear();
                        navigateToAndFinish(context,LoginStatuesScreen() );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: address,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        labelStyle: Theme.of(context).textTheme.bodyText1,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: "Enter your address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneNumber,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastName,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstname,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildBirthDateFormField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      controller: birthDate,
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950, 1, 1),
                lastDate: DateTime.now())
            .then((value) {
          birthDate.text = DateFormat.yMMMd().format(value!);
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Birth date is required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "BirthDate",
        hintText: "Enter your BirthDate",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.date_range),
      ),
    );
  }
}
