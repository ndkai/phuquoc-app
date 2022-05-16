import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/provice.dart';
import 'body.dart';

void showWardSelectDialog(BuildContext context,Districts districts, Function? onSuccessTap(Wards)){

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.screenWidth! * 0.05))
        ),
        // insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.2),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.4)
          ),
          child: WardSelectBody(
            districts: districts,
            onSuccess: (Wards val){
              onSuccessTap(val);
        },
          )
        ),
      );
    },
  );
}