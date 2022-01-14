import 'dart:io';
import 'package:user_project/screens/qr_code_scanner/qr_cubit/qr_cubit.dart';
import 'package:user_project/screens/qr_code_scanner/qr_cubit/qr_states.dart';
import 'package:user_project/shared/components/default_button.dart';
import 'package:user_project/shared/constants/constants.dart';
import 'package:user_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@override
class QrCodeScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrScannerCubit,QrScannerStates>(
      listener:(context,state){},
      builder:(context,state){
        return  Scaffold(
          body: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(80.0),),
                  Image.asset(
                    "assets/images/fram.png",
                    height: SizeConfig.bodyHeight * 0.35,
                  ),
                  Spacer(),
                  DefaultButton(
                    press: () {
                      scanQrCode(QrScannerCubit.get(context));
                    },
                    text: 'Scan Qr Code',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> scanQrCode(QrScannerCubit cubit) async {
    FlutterBarcodeScanner.scanBarcode
      ("#ff6666",
        'cancel',
        true,
        ScanMode.QR).then((value){
          print(value.toString());
          if(value !=null){
            cubit.setUpAttendance(value);
          }
    });
  }
}
