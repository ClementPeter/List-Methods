import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_method/itemModel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //TextFormField controllers
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemController.clear();
    _priceController.clear();
  }

  //Items will be added here after being inputed to the textfield
  List<Item> items = [];
  bool sort = false; //triggers the arrow up button for ascending

  //Declare form key fot TextFormField Validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        // padding: const EdgeInsets.all(15.0),
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
              sortColumnIndex: 0,
              sortAscending: sort,
              columns: [
                const DataColumn(label: Text('Item')),
                //Ascending order of price
                DataColumn(
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    if (ascending) {
                      items
                          .sort(((a, b) => a.itemPrice.compareTo(b.itemPrice)));
                    } else {
                      items
                          .sort(((a, b) => b.itemPrice.compareTo(a.itemPrice)));
                    }
                    setState(() {
                      sort = ascending;
                    });
                  },
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
                //Descending order of price
                DataColumn(
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    if (ascending) {
                      items
                          .sort(((a, b) => b.itemPrice.compareTo(a.itemPrice)));
                    } else {
                      items
                          .sort(((a, b) => a.itemPrice.compareTo(b.itemPrice)));
                    }
                    setState(() {
                      sort = ascending;
                    });
                  },
                  label: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.arrow_downward_rounded, size: 15),
                        SizedBox(width: 10),
                        Text('Price'),
                      ],
                    ),
                  ),
                ),
              ],
              rows: mapItemtoDataRow(items).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

//Functions that map each [item and price] to a data row
Iterable<DataRow> mapItemtoDataRow(List<Item> item) {
  return item.map((item) {
    return DataRow(
      cells: [
        DataCell(Text(item.itemName)),
        DataCell(Text(item.itemPrice.toString())),
        DataCell(Text(item.itemPrice.toString())),
      ],
    );
  });
}
