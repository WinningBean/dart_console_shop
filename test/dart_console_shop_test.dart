import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_mall.dart';
import 'package:test/test.dart';

void main() {
  test('shopping', () {
    Product apple = Product('Apple', 1000);
    Product banana = Product('Banana', 5000);
    Product orange = Product('Orange', 7000);

    var products = {
      apple,
      banana,
      orange,
    };
    
    var mall = ShoppingMall(products);
    
    // Show products
    mall.showProducts();
    
    // Add products to cart
    mall.addProductToCart(apple, 1); // Apple
    mall.addProductToCart(banana, 2); // Banana
    
    // Show total price
    mall.showTotal();
    
    // Check if cart contains the correct products and total price
    expect(mall.cart.length, 2);
    expect(mall.cartPrice, 11000);
    
    // Add another product to cart
    mall.addProductToCart(orange, 1); // Orange
    expect(mall.cart.length, 3);
    expect(mall.cartPrice, 18000);
  });
}