import 'package:firebase_series/utils/colors.dart';
import 'package:firebase_series/widgets/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});
  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}
class _DatePickerScreenState extends State<DatePickerScreen> {
 DateTime? selectDate;
 void showSlectDate(){
   showDialog(context: context, builder: (context){
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 150),
       child: Container(
         height: 500,
         width: double.maxFinite,
         child: Column(
           children: [
             SizedBox(
               width: double.maxFinite,
               height: 450,
               child: SfDateRangePicker(
                 todayHighlightColor: darkBlack,
                 backgroundColor: Colors.tealAccent,
                 headerHeight: 70,
                 selectionColor: blue,
                 headerStyle: DateRangePickerHeaderStyle(
                   backgroundColor: Colors.blue,
                   textStyle: TextStyle(color: white,fontSize: 25)
                 ),
                 onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                   setState(() {
                     selectDate=args.value;
                   });
                 },
                 selectionMode: DateRangePickerSelectionMode.single,
               ),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                TextButton(onPressed: (){
                  Get.back();
                }, child: Text('close',style: TextStyle(color: blue,fontSize: 18,letterSpacing: 1),)
                )
               ],
             )
           ],
         ),
       ),
     );
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        iconTheme: IconThemeData(
          color: white,
        ),
        title: Text('DatePicker',style: TextStyle(color: white
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
           Container(
             height: 200,
             width: double.maxFinite,
             color: themeColor,
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Text('Date:',style: TextStyle(color:white,fontSize: 17),),
                       SizedBox(
                         width: 10,
                       ),
                       Text(
                         selectDate!=null
                         ? DateFormat('dd-MM-yyyy').format(selectDate!):"16-07-2003"
                         // selectDate!=null?"$selectDate:${selectDate!.toLocal()}".split('')[0]:"No date selected"
                       ,style: TextStyle(color:darkBlack,fontSize: 17),),
                       Spacer(
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12),
                         child: GestureDetector(
                             onTap: (){
                               showSlectDate();
                             },
                             child: Icon(Icons.arrow_drop_down_outlined,color: white,size: 24,)),
                       )
                     ],
                   ),
                 ),
               ],
             ),
           ),
          
          SizedBox(
            height: 80,
          ),
         CustomTextFormField(
            labelText: 'Enter your email',
           prefixIcon: Icon(Icons.email_outlined),
         )
        ],
      ),
    );
  }
}