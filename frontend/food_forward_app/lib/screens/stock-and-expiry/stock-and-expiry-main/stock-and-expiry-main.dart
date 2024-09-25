import 'package:flutter/material.dart';

import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';

class StockAndExpiryScreen extends StatefulWidget {
  @override
  _StockAndExpiryScreenState createState() => _StockAndExpiryScreenState();
}

class _StockAndExpiryScreenState extends State<StockAndExpiryScreen> {
  List<FoodStockHdrSchema> items = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

    void _getData() async {
      print("GET FOOD STOCK HDR");
      List<FoodStockHdrSchema> fetchedItems = await FoodStockService.getFoodStock();
      setState(() {
        items = fetchedItems;  // Update the state with the fetched data
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Filter by date',
                suffixIcon: Icon(Icons.date_range),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                // Handle the picked date
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(items[index].name),
                    subtitle: Text('Qty: ${items[index].quantity ?? 'N/A'}, Price: ${items[index].unitPrice ?? 'N/A'}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItem {
  String name;
  String quantity;
  String receiptNo;
  String expiryDate;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.receiptNo,
    required this.expiryDate,
  });
}
