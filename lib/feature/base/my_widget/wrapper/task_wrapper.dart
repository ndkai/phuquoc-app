import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class TaskWrapper extends StatelessWidget {
  final List<Widget> children;
  const TaskWrapper({required Key key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.65,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
