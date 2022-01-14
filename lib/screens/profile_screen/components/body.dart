import 'package:user_project/models/user_model.dart';
import 'package:user_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:user_project/screens/sign_in/sign_in_screen.dart';
import 'package:user_project/shared/components/custom_card.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/shared/database/local/cache_helper.dart';
import 'package:user_project/shared/methods.dart';
import 'package:user_project/style/colors.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  UserModel userModel;
  ProfileScreenCubit cubit;

  Body(this.userModel, this.cubit);

  @override
  Widget build(BuildContext context) {
    String fullname = '${userModel.firstName} ${userModel.lastName}';

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
                    child: Container(
                      height: SizeConfig.bodyHeight * .22,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                              image: userModel.cover != DEFUlt
                                  ? NetworkImage(userModel.cover ?? DEFUlt)
                                  : AssetImage("assets/images/cover.jpg")
                                      as ImageProvider,
                              fit: BoxFit.cover)),
                    ),
                    alignment: AlignmentDirectional.topCenter,
                  ),
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
                        backgroundImage: userModel.image != DEFUlt
                            ? NetworkImage(userModel.image ?? DEFUlt)
                            : AssetImage("assets/images/defult_image.png")
                                as ImageProvider,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              fullname,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: getProportionateScreenHeight(26.0)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(4.0),
            ),
            Text(
              userModel.jobDesc ?? DEFUlt,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: getProportionateScreenHeight(18.0),
                  color: inActiveIconColor),
            ),
            CardItem(Icons.date_range, 'Date of hiring', '${userModel.hire}'),
            CardItem(Icons.money, 'Sallary', '${userModel.sallary}'),
            CardItem(Icons.format_indent_increase_sharp, 'Total Sallary',
                '${userModel.sallaryThen}'),
            CardItem(Icons.phone, 'Phone Number', '${userModel.phoneNumber}'),
            CardItem(
                Icons.location_on_outlined, 'Address', '${userModel.address}'),
            CardItem(
                Icons.date_range, 'Birth Date', '${userModel.dateOfBirth}'),
            CardItem(Icons.local_fire_department, 'Department',
                '${userModel.department}'),
            CardItem(Icons.military_tech_outlined, 'Militry Services',
                '${userModel.militryService}'),
            DefaultButton(
              text: 'Log Out',
              press: () {
                cubit.signOut();
                CachedHelper.clearData();
                navigateToAndFinish(context, SignInScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
