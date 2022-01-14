import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CardHistoryItem extends StatelessWidget {
  bool isAttend;
  String attend;
  String leave;
  String date;



  CardHistoryItem(this.isAttend, this.attend, this.leave,this.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isAttend ? Icon(
                Icons.check, size: getProportionateScreenHeight(50.0),
                color: Colors.blue):Icon(
                Icons.clear, size: getProportionateScreenHeight(50.0),
                color: Colors.red),
            SizedBox(width: getProportionateScreenWidth(25)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    '${date}',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(17),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${attend}',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${leave}',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
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
