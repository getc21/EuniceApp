import 'package:eunice_app/database/db_provider.dart';
import 'package:eunice_app/model/category.dart';
import 'package:eunice_app/model/supplier.dart';
import 'package:eunice_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:eunice_app/model/product.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _weightController = TextEditingController();
  final _dimensionsController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  Category? _selectedCategory;
  Supplier? _selectedSupplier;
  List<Category> _categories = [];
  List<Supplier> _suppliers = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadSuppliers();
  }

  Future<void> _loadCategories() async {
    final categories = await DBProvider().getCategories();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _loadSuppliers() async {
    final suppliers = await DBProvider().getSuppliers();
    setState(() {
      _suppliers = suppliers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: SingleChildScrollView(
        child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
              validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) => value?.isEmpty ?? true ? 'Description is required' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Price is required' : null,
            ),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Weight is required' : null,
            ),
            TextFormField(
              controller: _dimensionsController,
              decoration: InputDecoration(labelText: 'Dimensions'),
              validator: (value) => value?.isEmpty ?? true ? 'Dimensions are required' : null,
            ),
            DropdownButtonFormField<Category>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Category'),
              items: _categories.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) => value == null ? 'Category is required' : null,
            ),
            DropdownButtonFormField<Supplier>(
              value: _selectedSupplier,
              decoration: InputDecoration(labelText: 'Supplier'),
              items: _suppliers.map((supplier) {
                return DropdownMenuItem<Supplier>(
                  value: supplier,
                  child: Text(supplier.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSupplier = value;
                });
              },
              validator: (value) => value == null ? 'Supplier is required' : null,
            ),
            TextFormField(
              controller: _stockQuantityController,
              decoration: InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Stock Quantity is required' : null,
            ),
          ],
        ),
      ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newProduct = Product(
              name: _nameController.text,
              description: _descriptionController.text,
              price: double.parse(_priceController.text),
              weight: double.parse(_weightController.text),
              dimensions: _dimensionsController.text,
              categoryId: _selectedCategory?.id,
              supplierId: _selectedSupplier?.id,
              stockQuantity: int.parse(_stockQuantityController.text),
            );

              // Guardar en la base de datos local
              await DBProvider().insertProduct(newProduct);

              Get.to(HomePage()); // Cerrar el diálogo
            }
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
