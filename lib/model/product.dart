class Product {
  int? id;
  String name;
  String? description;
  double price;
  double weight;
  String? dimensions;
  int? categoryId;
  int? supplierId;
  int stockQuantity;

  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.weight = 0.0, // Valor por defecto
    this.dimensions = '', // Valor por defecto
    this.categoryId,
    this.supplierId,
    this.stockQuantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'weight': weight,
      'dimensions': dimensions,
      'category_id': categoryId,
      'supplier_id': supplierId,
      'stock_quantity': stockQuantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      weight: map['weight'],
      dimensions: map['dimensions'],
      categoryId: map['category_id'],
      supplierId: map['supplier_id'],
      stockQuantity: map['stock_quantity'],
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, weight: $weight, dimensions: $dimensions, categoryId: $categoryId, supplierId: $supplierId, stockQuantity: $stockQuantity}';
  }
}