import 'package:flutter/material.dart';

import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';

class StockAndExpiryScreen extends StatefulWidget {
  @override
  _StockAndExpiryScreenState createState() => _StockAndExpiryScreenState();
}

class _StockAndExpiryScreenState extends State<StockAndExpiryScreen> {
  List<FoodItem> items = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

    void _getData() async {
      print("GET FOOD STOCK HDR");
      await FoodStockService.getFoodStock();
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
                    subtitle: Text('Qty: ${items[index].quantity}, Expiry: ${items[index].expiryDate}'),
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
