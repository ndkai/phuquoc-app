import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phuquoc/core/constant/my_colors.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/show_toast.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/loading_dialog.dart';
import 'package:phuquoc/feature/booking/data/models/hospital_swagger.dart';
import 'package:phuquoc/feature/booking/presentation/manager/booking/bloc.dart';
import 'package:phuquoc/feature/booking/presentation/pages/booking-his-page.dart';
import 'package:phuquoc/feature/booking/presentation/widgets/seacher.dart';

import '../../../../injection_container.dart';
import 'booking_time_picker.dart';

class HospitalBookingPage extends StatefulWidget {
  final BuildContext? appContext;
  final String? serviceId;
  final String? title;
  const HospitalBookingPage({Key? key, this.appContext, this.serviceId, this.title}) : super(key: key);

  @override
  _HospitalBookingPageState createState() => _HospitalBookingPageState();
}

class _HospitalBookingPageState extends State<HospitalBookingPage> {
  String searchVal = "";
  late BuildContext currentContext;
  HospitalSwagger? hospitalSwagger;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseSubPage(
      title: "${widget.title}",
      showHelp: true,
      showHelpTap: (){
        changePage(context, BookingHisPage(
        ));
      },
      helpWidget: Icon(Icons.history, size: SizeConfig.screenWidth! * 0.07,),
      onBack: (){
        Navigator.of(context).pop();
      },
      child: BlocProvider<BookingBloc>(
        create: (_) => sl<BookingBloc>(),
        child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingLoading) {
              showLoadingDialog(context);
            } else if (state is BookingError) {
              Navigator.of(widget.appContext!).pop();
              showToastString(state.msg);
            } else if (state is GetHospitalLoaded) {
              Navigator.of(widget.appContext!).pop();
              setState(() {
                hospitalSwagger = state.data;
              });
            }
          },
          builder: (context, state) {
            currentContext = context;
            if (state is BookingInitial) {
              BlocProvider.of<BookingBloc>(context)
                  .add(BookingLoadingE());
              BlocProvider.of<BookingBloc>(context)
                  .add(GetHospitalByServiceE(widget.serviceId!));
            }
            return Container(
              height: SizeConfig.screenHeight! * 0.91,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Searcher(
                        width: SizeConfig.screenWidth! * 0.7,
                        height: SizeConfig.screenHeight! * 0.06,
                        title: "Nhập tên cơ sở",
                        onChanged: (s) {
                          setState(() {
                            searchVal = s;
                          });
                        },
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.4)),
                          child: Image.asset(
                            "assets/icons/filter.png",
                            width: SizeConfig.screenWidth! * 0.05,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.03,
                  ),
                  Text(
                    "Chọn cở sở bạn muốn đặt khám:",
                    style: normalBoldTextStyle,
                  ),
                  Expanded(
                      child: hospitalSwagger != null
                          ? MediaQuery.removePadding(
                              context: context,
                              child: ListView(
                                children: buildListviewItem(),
                              ),
                              removeTop: true,
                            )
                          : Container())
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildListviewItem() {
    if(searchVal.length < 1){
      return hospitalSwagger!.data!.map((e) => item(e)).toList();
    } else {
      print("search val ${searchVal}");
      return hospitalSwagger!.data!.takeWhile((value) => value.name!.contains(searchVal) || value.phone!.contains(searchVal)).map((e) => item(e)).toList();
    }
  }

  Widget item(HospitalData hospital) {
    return InkWell(
      onTap: (){
        changePage(context, BookingTimePage(hospitalData: hospital,));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
        child: Row(
          children: [
            Image.asset(
              "assets/images/hospital_image.png",
              width: SizeConfig.screenWidth! * 0.24,
            ),
            SizedBox(width: SizeConfig.screenWidth! * 0.03,),
            Container(
              width: SizeConfig.screenWidth!* 0.56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${hospital.name}",
                    style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenWidth! * 0.045, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.015,
                  ),
                  textDisplay("Địa chỉ", "${hospital.address}"),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.015,
                  ),
                  textDisplay("Sđt", "${hospital.phone}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textDisplay(String title, String content) {
    return Container(
      width: SizeConfig.screenWidth! * 0.55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title}: ",
            style: normalTextStyle,
          ),
          Text(
            "${content}",
            style: normalTextStyle,
          ),
        ],
      ),
    );
  }
}
