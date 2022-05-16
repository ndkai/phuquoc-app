import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class Searcher extends StatelessWidget {
  final ValueChanged? onChanged;
  final ValueChanged? onSummited;
  final String? title;
  final double? width;
  final double? height;

  const  Searcher({Key? key, this.onChanged, this.onSummited, this.title, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
        decoration: BoxDecoration(
            // color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent)                          
        ),
        child: TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 18, ),

            hintText: title,
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, SizeConfig.screenHeight! * 0.008 ),
          ),
          onChanged: onChanged,
        ));
  }
}
