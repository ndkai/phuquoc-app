import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentWrapper extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  const ContentWrapper({Key? key, required this.children, this.backgroundColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)
      ),
      child: Column(
          children: children,
      ),
    );
  }
}
