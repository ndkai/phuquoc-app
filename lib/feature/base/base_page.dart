import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class BaseSubPage extends StatelessWidget {
  final String? title;
  final Function? onBack;
  final Widget? child;
  final Widget? botNar;
  final bool? isLoading;
  final Color? backgroundColors;
  final bool? showHelp;
  final Function? showHelpTap;
  final Widget? helpWidget;
  final Widget? drawer;
  final double? margin;
  final bool? showOnBackIcon;
  const BaseSubPage({Key? key, this.title = "",  this.onBack,  this.child,
    this.botNar, this.isLoading = false, this.showHelp = false,
     this.showHelpTap,  this.drawer, this.backgroundColors = Colors.white, this.margin = 15,
    this.showOnBackIcon = true,  this.helpWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
    ),
    child: Scaffold(
      bottomNavigationBar: botNar,
      drawer: drawer ,
      body: Container(
        width: size.width,
        height: SizeConfig.screenHeight,
        margin: EdgeInsets.fromLTRB(margin!,10,margin!,0),
        child: Stack(
          children: [
            Container(
              height: SizeConfig.screenHeight,
              width: size.width,
              margin: EdgeInsets.fromLTRB(0, SizeConfig.screenHeight! * 0.12, 0, SizeConfig.screenWidth! * 0.01),
              child: SingleChildScrollView(
                child: child,
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(10, SizeConfig.screenHeight! * 0.07, SizeConfig.screenHeight! * 0.01, SizeConfig.screenHeight! * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      onBack!();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.05,
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: size.width * 0.06,
                        color: showOnBackIcon!?Colors.blue:Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth! * 0.6),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.width * 0.06,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  showHelp!?InkWell(
                    onTap: (){
                      showHelpTap!();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth! * 0.1,
                      child: helpWidget,
                    ),
                  ): Container(
                    width: SizeConfig.screenWidth! * 0.1,
                    child: Text("  "),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
