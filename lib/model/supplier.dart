class Supplier {
  int? id;
  String name;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? address;

  Supplier({
    this.id,
    required this.name,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact_name': contactName,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'address': address,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      contactName: map['contact_name'],
      contactEmail: map['contact_email'],
      contactPhone: map['contact_phone'],
      address: map['address'],
    );
  }
  @override
  String toString() {
    return 'Supplier{id: $id, name: $name, contactName: $contactName, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address}';
  }
}
