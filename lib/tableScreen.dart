import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_series/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<bool> selectedRows = List.generate(50, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: Icon(Icons.menu,color: white,),
        automaticallyImplyLeading: false,
        title: Text('Responsive Data Table',style:TextStyle(color: white),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.refresh,color: white,),
          )
        ],
      ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('+ new item',style: TextStyle(color: blue,fontSize: 17),),

                  Icon(Icons.search,)
                ],
              ),
              Expanded(
                child: DataTable2(
                    columns: [
                      DataColumn(label: Text('Select'),
                      ),
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Age')),
                    ],
                    rows: List<DataRow>.generate(50,(index){
                      false;
                      return DataRow(
                          cells: [
                        DataCell(
                          Checkbox(
                           value: selectedRows[index],
                            onChanged: (value){
                             setState(() {
                               selectedRows[index]=value??false;
                             });
                            },
                          ),
                        ),
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('User',maxLines: 1,)),
                            DataCell(Text('${20 + (index % 15)}')),
                      ]);
                    }
                      
                ),
                ),
              )
            ],
          ),
        )
    );
  }
}
