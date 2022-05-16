import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

Widget infoField(String title, String content, {Color contentColor = Colors.black, Function? ontap, ValueChanged<String>? onchanged}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.01, vertical: SizeConfig.screenHeight! * 0.008),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.045, fontWeight: FontWeight.w500,),),
        InkWell(
          onTap: (){
            ontap!();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // margin: EdgeInsets.only(bottom: 10, top: 5, left: SizeConfig.screenWidth! * 0.03, right: SizeConfig.screenWidth! * 0.03),
            child: TextField(
              // readOnly: true,
              onChanged: (s){
                onchanged!(s);
              },
              style: TextStyle(color: contentColor),
              controller: TextEditingController(text: content,),
              decoration: InputDecoration(
                // border: InputBorder.none
              ),
            ),
          ),
        )
      ],
    ),
  );

}