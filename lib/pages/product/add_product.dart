import 'package:eunice_app/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:eunice_app/model/product.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();

  AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: Form(
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
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Price is required' : null,
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              validator: (value) => value?.isEmpty ?? true ? 'Category is required' : null,
            ),
            TextFormField(
              controller: _supplierController,
              decoration: InputDecoration(labelText: 'Supplier'),
              validator: (value) => value?.isEmpty ?? true ? 'Supplier is required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newProduct = Product(
                name: _nameController.text,
                price: double.parse(_priceController.text),
                // categoryId: _categoryController.text,
                // supplierId: _supplierController.text,
              );

              // Guardar en la base de datos local
              await DBProvider().insertProduct(newProduct);

              Navigator.of(context).pop(); // Cerrar el diálogo
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
