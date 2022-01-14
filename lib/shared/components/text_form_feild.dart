
import 'package:flutter/material.dart';

class DefultTextFormField extends StatelessWidget {

  TextEditingController controller;
  TextInputType keyboardType;
  IconData prefixIcon;
  String label;
  final onTap;
  String? Function(String?)? validate ;


  DefultTextFormField(this.controller, this.keyboardType, this.prefixIcon,
      this.label, this.validate , {this.onTap});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: validate,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),)
    );
  }
}
