import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:user_project/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:user_project/screens/sign_in/cubit/sign_in_states.dart';
import 'package:user_project/shared/components/custom_prefix_icon.dart';
import 'package:user_project/shared/components/custom_shapes.dart';
import 'package:user_project/shared/components/custom_surfix_icon.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/components/form_error.dart';
import 'package:user_project/shared/components/keyboard.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/style/colors.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

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
    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SignInCubit cubit = SignInCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(cubit),
              SizedBox(height: getProportionateScreenHeight(10)),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                children: [
                 /* Checkbox(
                    value: remember,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    },
                  ),
                  Text("Remember me" , style: Theme.of(context).textTheme.bodyText1,),*/
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: TextDecoration.underline
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ConditionalBuilder(
                builder: (BuildContext context) => DefaultButton(
                  text: "Login In",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      cubit.signInWithEmailAndPassword(
                          email: email.toString(),
                          password: password.toString(),
                          context: context);
                    }
                  },
                ),
                fallback: (BuildContext context) =>
                    Center(child: CircularProgressIndicator()),
                condition: state is! LoginLoadingSignInState,
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildPasswordFormField(SignInCubit cubit) {
    return TextFormField(
      obscureText: cubit.isPasswordVisibleSignIn,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: Theme.of(context).textTheme.bodyText1,
        hintText: "Enter your password",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        border: outlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomPrefixIcon(
          icon: cubit.isPasswordVisibleSignIn
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            cubit.changePasswordVisibaltySignIn();
          },
        ),
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineInputBorder(),
        labelText: "Email",
        labelStyle: Theme.of(context).textTheme.bodyText1,
        hintText: "Enter your email",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),

      ),
    );
  }
}
