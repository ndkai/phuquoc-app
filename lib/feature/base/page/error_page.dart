import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(flex: 2,),
          Image.asset("assets/illustration/error.png", height: SizeConfig.screenHeight! * 0.5,),
          Text("Xin lỗi!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SizedBox(height: 10,),
          Text("Hiện không tải được thông tin", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
          Spacer(flex: 2,),
        ],
      ),
    );
  }
}
