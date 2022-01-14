import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  IconData prefix;
  String title;
  String detials;


  CardItem(this.prefix, this.title, this.detials);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(prefix, size: getProportionateScreenHeight(30.0),
              color: Colors.blue,),
            SizedBox(width: getProportionateScreenWidth(25)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${title}',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${detials}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
