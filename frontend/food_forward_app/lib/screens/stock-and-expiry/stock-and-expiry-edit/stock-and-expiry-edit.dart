import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditStockItemScreen extends StatefulWidget {
  final FoodStockHdrSchema item;

  EditStockItemScreen({required this.item});

  @override
  _EditStockItemScreenState createState() => _EditStockItemScreenState();
}

class _EditStockItemScreenState extends State<EditStockItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _unitPriceController;
  late TextEditingController _txnAmountController;
  late TextEditingController _expirtyDateController;


  @override
  void initState() {
    super.initState();
    // Initialize controllers with the item's current data
    _nameController = TextEditingController(text: widget.item.name);
    _quantityController = TextEditingController(text: widget.item.quantity);
    _unitPriceController = TextEditingController(text: widget.item.unitPrice);
    _txnAmountController = TextEditingController(text: widget.item.txnAmt);
    String formattedDate = "${widget.item.expiryDate.year.toString().padLeft(4, '0')}-"
        "${widget.item.expiryDate.month.toString().padLeft(2, '0')}-"
        "${widget.item.expiryDate.day.toString().padLeft(2, '0')}";
    
    // Initialize the TextEditingController with the formatted date
    _expirtyDateController = TextEditingController(text: formattedDate);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _expirtyDateController.dispose();
    _txnAmountController.dispose();
    super.dispose();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      // Create an updated FoodStockHdrSchema object
      FoodStockHdrSchema updatedItem = FoodStockHdrSchema(
        guid: widget.item.guid,
        name: _nameController.text,
        quantity: _quantityController.text ?? widget.item.quantity,
        unitPrice: _unitPriceController.text ?? widget.item.unitPrice,
        txnAmt: _txnAmountController.text ?? widget.item.txnAmt,
        createdById: widget.item.createdById,
        updatedById: widget.item.updatedById,
        createdDate: widget.item.createdDate,
        updatedDate: widget.item.updatedDate,
        expiryDate: _expirtyDateController.text.isNotEmpty 
          ? DateTime.tryParse(_expirtyDateController.text) ?? widget.item.expiryDate 
          : widget.item.expiryDate,
      );

      // Call the service method to update the item
      http.Response updateResp = await FoodStockService.update(updatedItem);
      final Map<String, dynamic> responseBody = json.decode(updateResp.body);
      if (updateResp.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item updated successfully')));
        Navigator.of(context).pop(updatedItem); // Return the updated item to the previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update item')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stock Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitPriceController,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expirtyDateController,
                decoration: const InputDecoration(
                  labelText: 'Enter Date (YYYY-MM-DD)',
                  hintText: '2024-09-27',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an expiry date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
