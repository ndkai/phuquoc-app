
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

import 'body.dart';
void showGenderSelectDialog(BuildContext context, Function? onSuccessTap(int)){

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
          child: SelectDialogBody(
            onSuccess: (int val){
              onSuccessTap(val);
        },
          )
        ),
      );
    },
  );
}