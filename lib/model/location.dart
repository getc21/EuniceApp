class Location {
  int? id;
  String name;
  String? description;
  int capacity;

  Location({this.id, required this.name, this.description, required this.capacity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      capacity: map['capacity'],
    );
  }
}
