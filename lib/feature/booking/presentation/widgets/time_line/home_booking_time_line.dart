
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';

import 'date_item_card.dart';

class HomeBookingTimeLine extends StatefulWidget {
  final DateTime? activeDate;
  final int? currentMonth;
  final DateByUnitAServiceSwagger? availableDay;
  final int? curentYear;
  final ValueChanged<DateTime>? onChangeDay;
  const HomeBookingTimeLine({Key? key,this.activeDate, this.onChangeDay, this.currentMonth, this.curentYear, this.availableDay}) : super(key: key);

  @override
  _HomeBookingTimeLineState createState() => _HomeBookingTimeLineState();
}
GlobalKey<_HomeBookingTimeLineState> homebkTimeLineKey = new GlobalKey<_HomeBookingTimeLineState>();

class _HomeBookingTimeLineState extends State<HomeBookingTimeLine> {
  late DateTime activeday;
  late ScrollController scrollController;
  int? currentMonth;
  int? curentYear;
  List<DateTime> days = <DateTime>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentMonth = widget.currentMonth;
    curentYear = widget.curentYear;
    activeday = widget.activeDate!;
    DateTime lastDayOfMonth = new DateTime(widget.curentYear!, widget.currentMonth! + 1, 0);
    for(var i = 1; i <= lastDayOfMonth.day; i++){
      days.add(DateTime(curentYear!,currentMonth!, i));
    }
    scrollController = ScrollController(initialScrollOffset: activeday.day * SizeConfig.screenWidth! * 0.2);
  }

  void changeDate(int month, int year){
    setState(() {
      currentMonth = month;
      curentYear = year;
      activeday = DateTime(curentYear!,currentMonth!, 1);
      days.clear();
      DateTime lastDayOfMonth = new DateTime(widget.curentYear!, widget.currentMonth! + 1, 0);
      for(var i = 1; i <= lastDayOfMonth.day; i++){
        days.add(DateTime(curentYear!,currentMonth!, i));
      }
      scrollController.jumpTo(SizeConfig.screenWidth! * 0.2 * (activeday.day-1));
    });


  }
  @override
  Widget build(BuildContext context) {
    print("HomeBookingTimeLine1 ${activeday}");
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! * 0.1,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener(
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              children: _buildListItemsFromitems(days),
              itemExtent: SizeConfig.screenWidth! * 0.2,
            ),
            onNotification: (t){
              if (t is ScrollEndNotification) {
              }
              return true;
            },
          ),
        )
    );
  }

  void setActiveDay( DateTime at){
    setState(() {
      activeday = at;
    });
  }


  List<Widget> _buildListItemsFromitems(List<DateTime> list) {
    return list.map((item) {
      bool active = false;
      bool inactive = true;
      if(item.day == activeday.day && item.month == activeday.month && item.year == activeday.year){
        active = true;
      }
      DateByServiceAndUnit? dateByServiceAndUnit;
      if(widget.availableDay != null){
        for(var i in widget.availableDay!.dateByServiceAndUnit!){
          if(isTheSameDate(item, i.date!)){
            inactive = false;
            dateByServiceAndUnit = i;
            break;
          }
        }
      } else{
        inactive = false;
      }

      var container = DateTimeCardItem(
        date: item,
        isActive: active,
        inActive: inactive,
        showMonth: item.month != widget.currentMonth,
        onTap: (e){
          setState(() {
            if(item.day == e.day){
              activeday = e;
            }
            widget.onChangeDay!(e);
          });
        },
      );
      return container;
    }).toList();
  }

  bool isTheSameDate(DateTime d1, String d2){
    try{
      DateTime d3 = DateTime.parse(d2);
      return d1.day == d3.day && d1.month == d3.month && d1.year == d3.year;
    } catch(e){
      return false;
    }
  }
}
