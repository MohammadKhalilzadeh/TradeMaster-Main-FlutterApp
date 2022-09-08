class Category {
  final String id;
  final String title;
  final String owner;

  const Category({
    required this.id,
    required this.title,
    required this.owner,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      title: json['title'],
      owner: json['owner'],
    );
  }
}
