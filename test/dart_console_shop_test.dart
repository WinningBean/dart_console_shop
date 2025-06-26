import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_mall.dart';
import 'package:test/test.dart';

void main() {
  test('shopping', () {
    var products = {
      Product('Apple', 1000),
      Product('Banana', 5000),
      Product('Orange', 7000),
    };
    
    var mall = ShoppingMall(products);
    
    // Show products
    mall.showProducts();
    
    // Add products to cart
    // mall.addToCart(products[0]); // Apple
    // mall.addToCart(products[1]); // Banana
    
    // Show total price
    mall.showTotal();
    
    // Check if cart contains the correct products and total price
    expect(mall.cart.length, 2);
    expect(mall.cartPrice, 6000);
    
    // Add another product to cart
    // mall.addToCart(products[2]); // Orange
    expect(mall.cart.length, 3);
    expect(mall.cartPrice, 13000);
  });
}