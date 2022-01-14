import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class SettingsScreen extends StatelessWidget {

  var date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        controller: date,
        onTap: () {
          showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025, 12, 20))
              .then((value) {
            date.text = DateFormat.yMMMd().format(value!);
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Rest date is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Rest Date",
          border: OutlineInputBorder(),
          hintText: "Enter your Rest date",
          hintStyle: Theme.of(context).textTheme.bodyText1,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.date_range),
        ),
      ),
    );
  }
}
