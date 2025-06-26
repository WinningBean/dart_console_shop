import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_message.dart';

class ShoppingMall {
  Set<Product> products;
  Map<Product, int> cart;
  int cartPrice;

  void showProducts() {
    for (var product in products) {
      stdout.writeln('${product.name} / ${product.price}원');
    }
  }

  void addToCart() {
    String? productName = ShoppingMessage.getInputProductName();
    if (!products.any((product) => product.name == productName)) {
      stdout.write('해당 상품이 존재하지 않습니다. ');
      ShoppingMessage.printRetryMessage();
      return; // 상품 이름이 유효하지 않으면 종료
    }

    int? count = ShoppingMessage.getInputWantedCount();
    if (count == null) {
      return; // 상품 개수가 유효하지 않으면 종료
    }

    // 상품 찾고 장바구니 추가
    Product product = products.firstWhere((product) => product.name == productName);
    addProductToCart(product, count);
    stdout.writeln('🛒 $count ${product.name}을(를) 장바구니에 담았습니다.');
  }

  void addProductToCart(Product product, int count) {
    // 장바구니에 추가
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + count;
    } else {
      cart[product] = count;
    }
    cartPrice += product.price * count;
  }

  void showTotal() {
    stdout.writeln('💰 장바구니에 $cartPrice원 어치를 담있습니다.');
  }

  void startShopping() {
    ShoppingMessage.printWelcomeMessage();
    ShoppingMessage.printMenu();

    int? inputNum;
    do {
      ShoppingMessage.printInputPrompt();
      inputNum = int.tryParse(stdin.readLineSync() ?? '');
      switch (inputNum) {
        case 1:
          showProducts();
          ShoppingMessage.printMenu();
          break;
        case 2:
          addToCart();
          ShoppingMessage.printMenu();
          break;
        case 3:
          showTotal();
          ShoppingMessage.printMenu();
          break;
        case 4:
          stdout.writeln('쇼핑을 종료합니다.');
          break;
        default:
          stdout.write('잘못된 입력입니다. ');
          ShoppingMessage.printRetryMessage();
          ShoppingMessage.printMenu();
      }
    } while (inputNum != 4);

    ShoppingMessage.printExitMessage();
  }

  ShoppingMall(this.products) : cart = {}, cartPrice = 0;
}
