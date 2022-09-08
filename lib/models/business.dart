class Business {
  final String id;
  final String title;
  final String owner;
  final String phone;
  final String email;
  final int status;
  final double latitude;
  final double longitude;
  final String address;
  final List<dynamic> imgs;
  final String sheba;
  final int delivery;
  final String description;

  const Business({
    required this.id,
    required this.title,
    required this.owner,
    required this.phone,
    required this.email,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.imgs,
    required this.sheba,
    required this.delivery,
    required this.description,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      title: json['title'],
      owner: json['owner'],
      phone: json['phone'],
      email: json['email'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      imgs: json['imgs'],
      sheba: json['sheba'],
      delivery: json['delivery'],
      description: json['description'],
    );
  }
}
