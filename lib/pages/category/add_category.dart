import 'package:eunice_app/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:eunice_app/model/category.dart';

class AddCategory extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Category'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Category name is required' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Description is required'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newCategory = Category(
                name: _nameController.text,
                description: _descriptionController.text,
              );

              // Guardar en la base de datos local
              await DBProvider().insertCategory(newCategory);

              Navigator.of(context).pop();
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
