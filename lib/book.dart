class Book {
  String? id;
  String name;
  int price;

  Book(this.name, this.price);

  factory Book.fromMap(Map<String, dynamic> map, String id) =>
      Book(map['name'], map['price'])..id = id;

  Map<String, dynamic> toMap() => {'name': name, 'price': price};
}

