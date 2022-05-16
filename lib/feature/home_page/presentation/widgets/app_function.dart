import 'package:flutter/cupertino.dart';
import 'package:phuquoc/core/utils/my_function.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/booking/presentation/pages/booking-his-page.dart';
import 'package:phuquoc/feature/booking/presentation/pages/booking_page.dart';
import 'package:phuquoc/feature/booking/presentation/pages/home_booking_page.dart';
import 'package:phuquoc/feature/user/presentation/pages/vaccination_page.dart';
import 'home_function_card.dart';

List<Widget> appFunction(BuildContext context){
  int i = 15;
  return [
    HomeFunctionCard(
      title: "Đặt lịch khám tại nhà",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/Clinic Visit.png",
      onClick: () {
        changePage(context, HomeBookingPage());
      },
    ),
    HomeFunctionCard(
      title: "Đặt lịch khám tại CSYT",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/hospital (2).png",
      onClick: () {
        changePage(context, HospitalBookingPage(appContext: context, serviceId: "7b6e030e-b488-4840-178e-08d9e22bbcee", title: "Đặt lịch tại CSYT",));
      },
    ),
    HomeFunctionCard(
      title: "Tư vấn",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/Nurse.png",
      onClick: () {
        changePage(context, HospitalBookingPage(appContext: context, serviceId: "3f1fb466-95b6-41a2-d90f-08d9e9ffc309", title: "Đặt lịch tư vấn",));
      },
    ),
    HomeFunctionCard(
      title: "Lịch sử đặt lịch",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/Serum.png",
      onClick: () {
        changePage(context, BookingHisPage(
        ));
      },
    ),
    HomeFunctionCard(
      title: "Quản lý tiêm chủng",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/014-medical record.png",
      onClick: () {
        changePage(context, VaccinationPage(
          appContext: context,
        ));
      },
    ),
    HomeFunctionCard(
      title: "Telehealth",
      height: SizeConfig.screenWidth! / i,
      imageAsset: "assets/icons/app_function/Video Consult.png",
      onClick: () {
      },
    ),
  ];
}