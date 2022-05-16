import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phuquoc/core/utils/my_texts.dart';
import 'package:phuquoc/core/utils/size_config.dart';

class TimeRangePicker extends StatelessWidget {
  final ValueChanged<List<DateTime>>? onChanged;
  TimeRangePicker({Key? key,this.onChanged,}) : super(key: key);

  final TextEditingController firstDateCT = TextEditingController();
  final TextEditingController endDateCT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.fromLTRB(0,10,0,10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.screenWidth! * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Từ ngày", style: mediumTextStyle,),
                SizedBox(height: 8,),
                Container(
                  // height: SizeConfig.screenHeight * 0.1,
                  child: TextFormField(
                    onTap: (){getDate(context, firstDateCT);},
                    readOnly:  true,
                    controller: firstDateCT,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.blue))
                    ),
                  ),
                )
              ],
            ),
          ),
         Container(
           width: SizeConfig.screenWidth! * 0.4,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Dến ngày", style: mediumTextStyle,),
               SizedBox(height: 8,),
               Container(
                 // height: SizeConfig.screenHeight * 0.1,
                 child: TextFormField(
                   onTap: (){getDate(context, endDateCT);},
                   readOnly:  true,
                   controller: endDateCT,
                   decoration: InputDecoration(
                       prefixIcon: Icon(Icons.calendar_today),
                       border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                           borderSide: BorderSide(color: Colors.blue))
                   ),
                 ),
               )
             ],
           ),
         )
        ],
      ),
    );
  }

  Future<void> getDate(BuildContext context, TextEditingController controller) async {
    showDateRangePicker(context: context,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    // if (result != null && ) {
    //   firstDateCT.text = getTimeByDateTime(picked.first);
    //   endDateCT.text = getTimeByDateTime(picked.last);
    //   onChanged(picked);
    //   print(picked);
    // }
  }

}


