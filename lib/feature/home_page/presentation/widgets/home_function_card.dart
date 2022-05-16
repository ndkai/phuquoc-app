import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/my_color.dart';

class HomeFunctionCard extends StatelessWidget {
  final String? imageAsset;
  final String? title;
  final Function()? onClick;
  final Color? color;
  final double? height;
  final double? width;



  const HomeFunctionCard({Key? key, this.imageAsset, this.title, this.onClick,this.color=Colors.white,this.height,this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: (){
        onClick!();
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        // height: size.width * 0.25,
        width: size.width * 0.25,
        margin: const EdgeInsets.fromLTRB(5,5,5,5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey[300], width: 1)
        ),
        child:Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.01,),
            Container(
              padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle
                ),
                child: Image.asset(imageAsset!, height: height,width: width,)),
            SizedBox(height: size.height * 0.01,),
            Text(title!, textAlign: TextAlign.center, style: TextStyle(fontSize: size.width/30,
            fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
