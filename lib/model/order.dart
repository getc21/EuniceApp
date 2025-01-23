class Order {
  int? id;
  String customerName;
  String? customerEmail;
  String? customerPhone;
  DateTime orderDate;
  String status; // 'PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED'

  Order({
    this.id,
    required this.customerName,
    this.customerEmail,
    this.customerPhone,
    DateTime? orderDate,
    required this.status,
  }) : orderDate = orderDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
      'order_date': orderDate.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      customerName: map['customer_name'],
      customerEmail: map['customer_email'],
      customerPhone: map['customer_phone'],
      orderDate: DateTime.parse(map['order_date']),
      status: map['status'],
    );
  }
}
