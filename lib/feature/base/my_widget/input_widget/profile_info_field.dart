import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/my_texts.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLine;
  final String hint;
  const MyInputField({Key? key, required this.title, required this.controller, this.maxLine = 1, this.hint = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: mediumBoldTextStyle,),
          SizedBox(height: 8,),
          TextField(
            // readOnly: true,
            maxLines: maxLine,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.blue))
            ),
          )
        ],
      ),
    );
  }
}
