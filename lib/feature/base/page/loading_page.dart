import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage() : super();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/loading-paperplane.gif"),
            Text("Đang tải...", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.06, color: Colors.purple, fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
