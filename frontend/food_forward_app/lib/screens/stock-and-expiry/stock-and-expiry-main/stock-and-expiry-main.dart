import 'package:flutter/material.dart';


class StockAndExpiryScreen extends StatefulWidget {
  @override
  _StockAndExpiryScreenState createState() => _StockAndExpiryScreenState();
}

class _StockAndExpiryScreenState extends State<StockAndExpiryScreen> {
  List<FoodItem> items = [
    FoodItem(name: 'Apple', quantity: '30g', receiptNo: '10003', expiryDate: '30th Sept 2024'),
    FoodItem(name: 'Chocolate Bar', quantity: '3 units', receiptNo: '10003', expiryDate: '15th Oct 2024'),
    FoodItem(name: 'Potatoes', quantity: '3 units', receiptNo: '10003', expiryDate: '20th Nov 2024'),
  ];

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
