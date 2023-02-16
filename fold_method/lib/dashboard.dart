import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fold_method/itemModel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //TextFormField controllers
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemController.clear();
    _priceController.clear();
  }

  //Items will be added here after being inputed to the textfield
  List<Item> items = [];

  //Declare form key fot TextFormField Validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(
                hintText: 'Item',
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                suffixIcon: IconButton(
                  onPressed: () => _itemController.clear(),
                  icon: const Icon(Icons.clear),
                ),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                // if (value!.isEmpty) {
                //   Future.delayed(const Duration(seconds: 1), () {
                //     print('One second has passed.');
                //     return "Please provide the name";
                //   });

                // }
                if (value!.isEmpty) {
                  return "Please provide the name";
                }

                // Timer(Duration(seconds: 5), () {});//

                // Duration(seconds: 2);
                // return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      suffixIcon: IconButton(
                        onPressed: () => _itemController.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " Please provide the price";
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //validate the form and add a new item to the data row
                    if (_formKey.currentState!.validate()) {
                      items.add(
                        Item(
                          itemName: _itemController.text,
                          itemPrice: double.parse(_priceController.text),
                        ),
                      );
                      //update the list and clear the textformfield
                      setState(() {
                        _itemController.clear();
                        _priceController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.subdirectory_arrow_left, size: 30),
                ),
                const SizedBox(height: 20),
              ],
            ),
            DataTable(
              columns: [
                const DataColumn(label: Text('Item')),
                //Ascending order of price
                DataColumn(
                  label: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.arrow_upward_rounded, size: 15),
                        SizedBox(width: 10),
                        Text('Price'),
                      ],
                    ),
                  ),
                ),
              ],
              rows: [
                ...items.map((element) {
                  return DataRow(cells: [
                    DataCell(Text(element.itemName)),
                    DataCell(Text(element.itemPrice.toString()))
                  ]);
                }),
                //calculate the sum of the
                DataRow(cells: [
                  const DataCell(Text("Total Amount")),

                  //sum item prices
                  DataCell(
                    Text(
                      items
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.itemPrice.toInt())
                          .toString(),
                    ),
                  )
                ])
              ],
              //rows: mapItemtoDataRow(items).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

//NOT USED

// //Functions that map each [item and price] to a data row
// Iterable<DataRow> mapItemtoDataRow(List<Item> item) {
//   return item.map((item) {
//     return DataRow(
//       cells: [
//         DataCell(Text(item.itemName)),
//         DataCell(Text(item.itemPrice.toString())),
//         DataCell(Text(item.itemPrice.toString())),
//       ],
//     );
//   });
// }
