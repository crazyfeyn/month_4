class Shop {
  String id;
  String title;
  String imageUrl;
  bool isFavorite;
  double price;

  Shop(
      {required this.id,
      required this.title,
      required this.imageUrl,
      this.isFavorite = false,
      required this.price});
}
