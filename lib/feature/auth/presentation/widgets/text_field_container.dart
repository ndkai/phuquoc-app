import 'package:flutter/material.dart';
import 'package:phuquoc/core/constant/my_colors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;

  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // width: size.width * 0.8,
      decoration: BoxDecoration(
          // color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kActiveShadowColor,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: kActiveShadowColor,
              offset: Offset(-3, 3),
            ),
            BoxShadow(
              color: kActiveShadowColor,
              offset: Offset(-2, -2),
            )
          ],
          // border: Border.all(color: Colors.grey, width: 1)
      ),
      child: child,
    );
  }
}
