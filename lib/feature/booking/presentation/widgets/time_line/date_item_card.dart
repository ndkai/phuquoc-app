import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/utils/my_color.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class DateTimeCardItem extends StatefulWidget {
  final DateTime? date;
  final ValueChanged<DateTime>? onTap;
  final bool? isActive;
  final bool? inActive;
  final bool? showMonth;
  const DateTimeCardItem(
      {Key? key,
      this.date,
      this.onTap,
      this.isActive = false, this.showMonth = false, this.inActive = true})
      : super(key: key);

  @override
  _DateTimeCardItemState createState() => _DateTimeCardItemState();
}

class _DateTimeCardItemState extends State<DateTimeCardItem> {
  Color backgroundColors = Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(!widget.inActive!)
        widget.onTap!(widget.date!);
      },
      child: Container(
        // padding: EdgeInsets.symmetric( horizontal: SizeConfig.screenWidth! * 0.06),
        decoration: BoxDecoration(
            color: widget.isActive! ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //   color: Colors.greenAccent,
              //   shape: BoxShape.circle
              // ),
              child: Column(
                children: [
                  Text(
                    widget.date!.day.toString(),
                    style: TextStyle(
                        color: widget.isActive! ? Colors.white : widget.inActive! ? Colors.grey.withOpacity(0.4) :Colors.black,
                        fontSize: SizeConfig.screenWidth! * 0.055),
                  ),
                  SizedBox(
                    height: SizeConfig.spaceSize !* 0.5,
                  ),
                  Text(
                    dayInWeek[widget.date!.weekday].toString(),
                    style: TextStyle(
                        color: widget.isActive! ? Colors.white :  widget.inActive! ? Colors.grey.withOpacity(0.4) :Colors.black,
                        fontSize: SizeConfig.screenWidth! * 0.04),
                  ),
                  // Text(
                  //   widget.showMonth! && widget.date!.day == 1 ? "Th${widget.date!.month}":"",
                  //   style: TextStyle(
                  //       color: widget.isActive! ? Colors.white : Colors.black,
                  //       fontSize: SizeConfig.screenWidth! * 0.03),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
