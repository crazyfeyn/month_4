import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/product.dart';
import 'package:flutter_application/services/product_services.dart';

class ProductController extends ChangeNotifier {
  final productServices = ProductServices();
  final List<Product> _productList = [
    Product(
      category: "living",
      id: UniqueKey().toString(),
      imageUrl:
          "https://ae01.alicdn.com/kf/H7d52e052f63b4d1f8871c116a884268cS.jpg_640x640Q90.jpg_.webp",
      price: 1555.0,
      title: "Aquarium",
      isLiked: false,
    ),
    Product(
      category: "living",
      id: UniqueKey().toString(),
      imageUrl:
          "https://5.imimg.com/data5/SELLER/Default/2023/1/EL/QL/NA/39295374/wooden-floor-lamp-beige-natural-jute-lamp-for-living-room-corners-and-bedroom.jpg",
      price: 1545.0,
      title: "Lamp",
      isLiked: false,
    ),
    Product(
      category: "living",
      id: UniqueKey().toString(),
      imageUrl:
          "https://mysleepyhead.com/media/catalog/product/4/t/4thaug_2ndhalf5934_green.jpg",
      price: 1535.0,
      title: "Sofa",
      isLiked: false,
    ),
    Product(
      category: "wall",
      id: UniqueKey().toString(),
      imageUrl:
          "https://thearchinsider.com/wp-content/uploads/2020/07/611dsYePavL.jpg",
      price: 1555.0,
      title: "Mirror",
      isLiked: false,
    ),
    Product(
      category: "wall",
      id: UniqueKey().toString(),
      imageUrl:
          "https://assets.wfcdn.com/im/12553609/c_crop_resize_zoom-h624-w900%5Ecompr-r85/1391/139101496/default_name.jpg",
      price: 1545.0,
      title: "Wayfair",
      isLiked: false,
    ),
    Product(
      category: "wall",
      id: UniqueKey().toString(),
      imageUrl: "https://m.media-amazon.com/images/I/519-OvMxrOL._SS400_.jpg",
      price: 1535.0,
      title: "Wall decor",
      isLiked: false,
    ),
    Product(
      category: "table",
      id: UniqueKey().toString(),
      imageUrl:
          "https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",
      price: 1555.0,
      title: "Lamp",
      isLiked: false,
    ),
    Product(
      category: "table",
      id: UniqueKey().toString(),
      imageUrl:
          "https://interiorstylehunter.com/wp-content/uploads/2023/11/A-close-up-image-of-an-arrangement-of-elegant-decorative-items-on-a-surface.-The-composition-includes-a-crystal-candle-holder-with-a-lit-scented-candl.png",
      price: 1545.0,
      title: "Candle",
      isLiked: false,
    ),
    Product(
      category: "table",
      id: UniqueKey().toString(),
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb2V_TKpivveSXVmsG8_cgfajgK6k5E5bLqw&s",
      price: 1535.0,
      title: "Table organization",
      isLiked: false,
    ),
  ];

  List<Product> get productList {
    return _productList;
  }

  int productCategoryCount(String category) {
    int count = 0;
    for (var element in _productList) {
      if (element.category == category) {
        count++;
      }
    }
    return count;
  }

  void updateProduct(String id, String category, File imageUrl, bool isLiked,
      double price, String title) {
    productServices.updateProduct(id, category, imageUrl, price, title);
    notifyListeners();
  }

  void addProduct(String category, String? imageUrl, double price, String title,
      bool isLiked) {
    productServices.addproduct(
        category,
        imageUrl ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb2V_TKpivveSXVmsG8_cgfajgK6k5E5bLqw&s',
        price,
        title,
        isLiked);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    productServices.toggleFavorite(id);
    notifyListeners();
  }
}
