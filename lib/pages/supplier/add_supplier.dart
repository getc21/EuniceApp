import 'package:eunice_app/database/db_provider.dart';
import 'package:eunice_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:eunice_app/model/supplier.dart';
import 'package:get/get.dart';

class AddSupplier extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _contactAddressController =
      TextEditingController();

  AddSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Supplier'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Supplier Name'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Supplier name is required' : null,
            ),
            TextFormField(
              controller: _contactNameController,
              decoration:
                  InputDecoration(labelText: 'Contact Name Information'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Contact information is required'
                  : null,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _contactEmailController,
              decoration:
                  InputDecoration(labelText: 'Contact Email Information'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Contact information is required'
                  : null,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _contactPhoneController,
              decoration:
                  InputDecoration(labelText: 'Contact Phone Information'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Contact information is required'
                  : null,
            ),
            TextFormField(
              controller: _contactAddressController,
              decoration:
                  InputDecoration(labelText: 'Contact Address Information'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Contact information is required'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newSupplier = Supplier(
                name: _nameController.text,
                contactName: _contactNameController.text,
                contactEmail: _contactEmailController.text,
                contactPhone: _contactPhoneController.text,
                address: _contactAddressController.text,
              );

              // Intentar guardar en la base de datos local
              int result = await DBProvider().insertSupplier(newSupplier);

              if (result > 0) {
                // Si se guardó correctamente, mostrar un mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Supplier saved successfully!')),
                );
                Get.to(HomePage()); // Cerrar el diálogo
              } else {
                // Si no se guardó, mostrar un mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to save supplier')),
                );
              }
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
