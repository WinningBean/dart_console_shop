import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_mall.dart';

void main(List<String> arguments) {
  ShoppingMall mall = ShoppingMall({
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  });

  mall.startShopping();
  exit(0);
}