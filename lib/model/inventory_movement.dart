class InventoryMovement {
  int? id;
  int productId;
  int locationId;
  int quantity;
  String movementType; // 'IN' or 'OUT'
  DateTime movementDate;

  InventoryMovement({
    this.id,
    required this.productId,
    required this.locationId,
    required this.quantity,
    required this.movementType,
    DateTime? movementDate,
  }) : movementDate = movementDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'location_id': locationId,
      'quantity': quantity,
      'movement_type': movementType,
      'movement_date': movementDate.toIso8601String(),
    };
  }

  factory InventoryMovement.fromMap(Map<String, dynamic> map) {
    return InventoryMovement(
      id: map['id'],
      productId: map['product_id'],
      locationId: map['location_id'],
      quantity: map['quantity'],
      movementType: map['movement_type'],
      movementDate: DateTime.parse(map['movement_date']),
    );
  }
}
