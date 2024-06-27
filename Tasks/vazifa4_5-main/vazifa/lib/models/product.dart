class Product {
  String id;
  String title;
  double price;
  String imageUrl;
  String category;
  bool isLiked;
  Product({
    required this.category,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.isLiked,
  });
}
