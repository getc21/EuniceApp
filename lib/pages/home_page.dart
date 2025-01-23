import 'package:eunice_app/database/db_provider.dart';
import 'package:eunice_app/model/category.dart';
import 'package:eunice_app/model/order.dart';
import 'package:eunice_app/model/product.dart';
import 'package:eunice_app/model/supplier.dart';
import 'package:eunice_app/pages/category/add_category.dart';
import 'package:eunice_app/pages/order/add_order.dart';
import 'package:eunice_app/pages/product/add_product.dart';
import 'package:eunice_app/pages/supplier/add_supplier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home_page';

  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Database _database;

  List<Product> _products = [];
  List<Category> _categories = [];
  List<Supplier> _suppliers = [];
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Asegúrate de que la base de datos esté creada
    DBProvider().database.then((db) {
      print("Base de datos inicializada");
      _openDatabase();
    });
  }

  // Abre la base de datos SQLite
  _openDatabase() async {
    _database = await openDatabase('app_database.db', version: 1,
        onCreate: (db, version) {
      // Crear tablas aquí si es necesario
    });
    await _fetchData();
  }

  // Fetch datos de la base de datos
 _fetchData() async {
  print("Fetching data...");
  
  var productsList = await _database.query('products');
  print("Productos: $productsList");
  
  var categoriesList = await _database.query('categories');
  print("Categories: $categoriesList");
  
  var suppliersList = await _database.query('suppliers');
  print("Supplier: $suppliersList");
  
  var ordersList = await _database.query('orders');
  print("Order: $ordersList");

  setState(() {
    _products = productsList.map((item) => Product.fromMap(item)).toList();
    _categories = categoriesList.map((item) => Category.fromMap(item)).toList();
    _suppliers = suppliersList.map((item) => Supplier.fromMap(item)).toList();
    _orders = ordersList.map((item) => Order.fromMap(item)).toList();
  });
}


  // Crear un ListView para cada entidad
  Widget _buildListView(List items, String entityName) {
  print('Displaying list for $entityName');
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      var item = items[index];
      return ListTile(
        title: Text(item.toString()),  // Aquí se usará toString() para mostrar la información del objeto
        onTap: () {
          // Acción al seleccionar el elemento (por ejemplo, editar)
          _editEntity(entityName);
        },
      );
    },
  );
}

  void _addEntity(String entityName) {
    // Mapa de rutas
    final routeMap = {
      'Product': () => AddProduct(),
      'Category': () => AddCategory(),
      'Supplier': () => AddSupplier(),
      'Order': () => AddOrder(),
    };

    // Verifica si el entityName existe en el mapa
    if (routeMap.containsKey(entityName)) {
      Get.to(routeMap[entityName]!()); // Navega a la página correspondiente
    } else {
      // Si no existe, muestra un error o maneja el caso
      print('La entidad "$entityName" no tiene una página asignada.');
    }
  }

  // Acción para editar
  _editEntity(String entityName) {
    // Lógica para editar la entidad
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Edit $entityName')));
  }

  // Acción para eliminar
  _deleteEntity(String entityName) {
    // Lógica para eliminar la entidad
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Delete $entityName')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Products'),
            Tab(text: 'Categories'),
            Tab(text: 'Suppliers'),
            Tab(text: 'Orders'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Llamar a la acción de agregar para la pestaña activa
              if (_tabController.index == 0) {
                _addEntity('Product');
              } else if (_tabController.index == 1) {
                _addEntity('Category');
              } else if (_tabController.index == 2) {
                _addEntity('Supplier');
              } else if (_tabController.index == 3) {
                _addEntity('Order');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Llamar a la acción de editar para la pestaña activa
              if (_tabController.index == 0) {
                _editEntity('Product');
              } else if (_tabController.index == 1) {
                _editEntity('Category');
              } else if (_tabController.index == 2) {
                _editEntity('Supplier');
              } else if (_tabController.index == 3) {
                _editEntity('Order');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Llamar a la acción de eliminar para la pestaña activa
              if (_tabController.index == 0) {
                _deleteEntity('Product');
              } else if (_tabController.index == 1) {
                _deleteEntity('Category');
              } else if (_tabController.index == 2) {
                _deleteEntity('Supplier');
              } else if (_tabController.index == 3) {
                _deleteEntity('Order');
              }
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView(_products, 'Products'),
          _buildListView(_categories, 'Categories'),
          _buildListView(_suppliers, 'Suppliers'),
          _buildListView(_orders, 'Orders'),
        ],
      ),
    );
  }
}
