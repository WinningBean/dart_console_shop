import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_mall.dart';

void main(List<String> arguments) {
  ShoppingMall mall = ShoppingMall([]);
  mall.startShopping();
  exit(0);
}