import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phuquoc/core/utils/size_config.dart';
import 'package:phuquoc/feature/base/my_widget/dialog/select_dialog/country_select/provice.dart';

class DistrictSelectBody extends StatefulWidget {
  final Function(Districts)? onSuccess;
  final Province? province;
  const DistrictSelectBody({Key? key, this.onSuccess, this.province}) : super(key: key);

  @override
  _DistrictSelectBodyState createState() => _DistrictSelectBodyState();
}

class _DistrictSelectBodyState extends State<DistrictSelectBody> {
  int val = -1;
  late Districts districts;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.4)
        ),
        child: Container(
          height: SizeConfig.screenHeight! * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth! * 0.9,
                height: SizeConfig.screenHeight! * 0.4,
                child: ListView(
                  children: lists(),
                ),
              ),

              SizedBox(height: SizeConfig.screenHeight! * 0.01,),
              Divider(color: Colors.black, height: 1,),
              SizedBox(height: SizeConfig.screenHeight! * 0.02,),
              Expanded(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            // border: Border(
                            //     right: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.2
                            //     )
                            // )
                          ),
                          width: SizeConfig.screenWidth! * 0.25,
                          child: Center(
                            child: Text("Hu??y bo??", style: TextStyle(
                              color: Colors.blue,
                              fontSize: SizeConfig.screenWidth! * 0.045,

                            )),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.onSuccess!
                          (districts);
                      },

                      child: Container(
                          decoration: BoxDecoration(
                            // border: Border(
                            //     left: BorderSide(
                            //         color: Colors.black,
                            //         width: 0.2
                            //     )
                            // )
                          ),
                          width: SizeConfig.screenWidth! * 0.25,
                          child: Center(
                            child: Text("?????ng ??", style: TextStyle(
                                color: Colors.blue,
                                fontSize: SizeConfig.screenWidth! * 0.045,
                                fontWeight: FontWeight.bold
                            ),),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  List<Widget> lists(){
    return widget.province!.districts!.map((e) =>
        MediaQuery.removePadding(context: context,
            removeLeft: true,
            child: ListTile(
          title: Text("${e.label}"),
          leading: Radio(
            value: int.parse(e.value.toString()),
            groupValue: val,
            onChanged: (value) {
              setState(() {
                print("value ${value}");
                val = value as int;
                districts = e;
              });
            },
            activeColor: Colors.green,
          ),
        ))
    ).toList();
  }
}
