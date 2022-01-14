import 'package:flutter/material.dart';
import 'package:user_project/models/request_model.dart';
import 'package:user_project/style/size_config.dart';

class CustomRequestCard extends StatelessWidget {
  RequestModel requestModel;

  CustomRequestCard(this.requestModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(10.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(requestModel.reason ?? '',style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: getProportionateScreenHeight(22.0)
            ),),
            SizedBox(height: getProportionateScreenHeight(20.0),),
            Text(requestModel.date ?? '',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: getProportionateScreenHeight(18.0)

            ),),
            SizedBox(height: getProportionateScreenHeight(20.0),),
            Text(requestModel.response ?? '',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: getProportionateScreenHeight(18.0)

            ),),

          ],
        ),
      ),
    );
  }

  Widget buildButton(context, String text, onPress, bool accept) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(10.0)),
        color: accept ? Colors.green : Colors.red,
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
        onPressed: onPress,
      ),
    );
  }

  Widget buildText(BuildContext context, String text) {
    return Text(
      '${text}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: getProportionateScreenWidth(16.0),
          ),
    );
  }
}
