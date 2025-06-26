import 'package:dart_console_shop/product.dart';

class ShoppingMall {
  List<Product> products;
  List<Product> cart;
  int cartPrice;

  void showProducts() {
    for (var product in products) {
      print(product.name);
    }
  }

  void addToCart(Product product) {
    cart.add(product);
    cartPrice += product.price;
  }

  void showTotal() {
    print('Total price: ${cartPrice}원');
  }

  ShoppingMall(this.products)
      : cart = [],
        cartPrice = 0;
}