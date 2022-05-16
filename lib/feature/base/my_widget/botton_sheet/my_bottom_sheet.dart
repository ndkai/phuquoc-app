import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phuquoc/core/utils/size_config.dart';

import 'bottom_sheet_item.dart';

void showMyBottomSheet(
    BuildContext context, String title, List<BottomSheetItem> items) {
  showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      color: Colors.transparent,
      height: SizeConfig.screenHeight! * 0.45,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            height: SizeConfig.screenHeight! * 0.05,
            width: SizeConfig.screenWidth,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth! * 0.03,
              ),
            )),
          ),
          Column(
            children: items
                .map((e) => Column(
                      children: [
                        bottomSheetItem(context, e.title, () {
                          Navigator.of(context).pop();
                          e.callback();
                        }),
                        Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    ),
  );
}

Widget bottomSheetItem(BuildContext context, String name, Function onPressed) {
  return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: InkWell(
        onTap: (){
          onPressed();
        },
        child: Container(
          // margin: EdgeInsets.all(1),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              // border: Border(
              //   top: BorderSide(width: 1.0, color: Colors.black),
              //   bottom: BorderSide(width: 1.0, color: Colors.black),
              // ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          height: SizeConfig.screenHeight! * 0.07,
          width: SizeConfig.screenWidth,
          child: Center(
              child: Text(
            name,
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: SizeConfig.screenWidth! * 0.05,
            ),
          )),
        ),
      ));
}
