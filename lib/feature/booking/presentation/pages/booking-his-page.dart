import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/utils/input_converter.dart';
import 'package:phuquoc/core/utils/my_color.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/booking/data/models/booking_his.dart';
import 'package:phuquoc/feature/booking/data/models/booking_response.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_his_request.dart';
import 'package:phuquoc/feature/booking/domain/entities/delete_booking_request.dart';
import 'package:phuquoc/feature/booking/presentation/manager/booking/bloc.dart';

import '../../../../injection_container.dart';

class BookingHisPage extends StatefulWidget {
  const BookingHisPage({Key? key}) : super(key: key);

  @override
  _BookingHisPageState createState() => _BookingHisPageState();
}

class _BookingHisPageState extends State<BookingHisPage> {
  BookingHisResponse? bookingHisResponse;
  BuildContext? currentContext;
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Lịch hẹn",
      onBack: (){
        Navigator.of(context).pop();
      },
      child: BlocProvider<BookingBloc>(
        create: (_) => sl<BookingBloc>(),
        child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state){
            print("BookingHisPage ${state}");
            if (state is BookingLoading) {
              showLoadingDialog(context);
            } else if (state is BookingError) {
              Navigator.of(context).pop();
              showToastString(state.msg);
            } else if (state is BookingHisLoaded) {
              Navigator.of(context).pop();
              setState(() {
                bookingHisResponse = state.data;
              });
            } else if(state is BookingDeteteLoaded){
              Navigator.of(context).pop();
              showSuccesDialog();
            }
          },
           builder: (context, state){
            currentContext = context;
            if(state is BookingInitial){
              BlocProvider.of<BookingBloc>(context).add(BookingLoadingE());
              BlocProvider.of<BookingBloc>(context).add(GetBookingHisE(BookingHisRequest(
              )));
            }
             return Container(
               height: SizeConfig.screenHeight! * 0.91,
               margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
               child:  bookingHisResponse != null
                   ? MediaQuery.removePadding(
                 context: context,
                 child: ListView(
                   children: buildListviewItem(),
                 ),
                 removeTop: true,
               )
                   : Container()
             );
           },
        ),
      )
    );
  }

  List<Widget> buildListviewItem(){
     return bookingHisResponse!.data!.takeWhile((value) => value.status == 1).map((e) => item(e)).toList();
     // return bookingHisResponse!.data!.map((e) => item(e)).toList();
  }
  Widget item(Data data){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! * 0.02),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.07, vertical: SizeConfig.screenHeight! * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data.service!.name!.length > 0 ?
          Text('${data.service!.name}', style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.05, fontWeight: FontWeight.bold),):
          Container(),
          SizedBox(height: 10),
          Text('Thời gian: ${getTimeByString(data.date!)}', style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04),),
          SizedBox(height: 10),
          Text('${data.unit!.address}', style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04),),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                BlocProvider.of<BookingBloc>(currentContext!).add(BookingLoadingE());
                BlocProvider.of<BookingBloc>(currentContext!).add(DeleteBookingE(DeleteBookingRequest(
                  id: data.id,
                  status: 3
                )));
              },
              child: Container(
                width: SizeConfig.screenWidth! * 0.3,
                padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! * 0.015),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.03)
                ),
                child: Center(
                  child: Text("Hủy lịch hẹn" , style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.screenWidth! * 0.04
                  ),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showSuccesDialog() {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(
            child: Text(
              'HỦY LỊCH THÀNH CÔNG',
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight! * 0.3,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Doctor-rafiki 1.png",
                  height: SizeConfig.screenHeight! * 0.2,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<BookingBloc>(currentContext!).add(BookingLoadingE());
                    BlocProvider.of<BookingBloc>(currentContext!).add(GetBookingHisE(BookingHisRequest(
                    )));
                  },
                  child: Text(
                    "Quay lại",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth! * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
