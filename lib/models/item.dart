class Item {
  final String id;
  final String name;
  final String owner;
  final String price;
  final String unit;
  final bool isavailable;
  final String description;
  final List<dynamic> colors;
  final List<dynamic> sizes;
  final List<dynamic> images;

  const Item({
    required this.id,
    required this.name,
    required this.owner,
    required this.price,
    required this.unit,
    required this.isavailable,
    required this.description,
    required this.colors,
    required this.sizes,
    required this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      owner: json['owner'],
      price: json['price'],
      unit: json['unit'],
      isavailable: json['isavailable'],
      description: json['description'],
      colors: json['colors'],
      sizes: json['sizes'],
      images: json['images'],
    );
  }
}
