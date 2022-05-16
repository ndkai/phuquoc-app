import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/base_page.dart';
import 'package:phuquoc/feature/booking/presentation/widgets/seacher.dart';

class VaccinationManagePage extends StatefulWidget {
  const VaccinationManagePage({Key? key}) : super(key: key);

  @override
  _VaccinationManagePageState createState() => _VaccinationManagePageState();
}

class _VaccinationManagePageState extends State<VaccinationManagePage> {
  String searchVal = "";
  late BuildContext currentContext;
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      title: "Quản lý tiêm chủng",
      onBack: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: SizeConfig.screenHeight! * 0.91,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
            Text(
              "Lịch sử đăng kí tiêm chủng:",
              style: normalBoldTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Searcher(
                  width: SizeConfig.screenWidth! * 0.7,
                  height: SizeConfig.screenHeight! * 0.06,
                  title: "Tìm kiếm",
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


            // Expanded(
            //     child: hospitalSwagger != null
            //         ? MediaQuery.removePadding(
            //       context: context,
            //       child: ListView(
            //         children: buildListviewItem(),
            //       ),
            //       removeTop: true,
            //     )
            //         : Container())
          ],
        ),
      ),
    );
  }
}
