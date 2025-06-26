import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_message.dart';

class ShoppingMall {
  List<Product> products;
  List<Product> cart;
  int cartPrice;

  void showProducts() {
    for (var product in products) {
      stdout.writeln(product.name);
    }
  }

  void addToCart(Product product) {
    cart.add(product);
    cartPrice += product.price;
  }

  void showTotal() {
    stdout.writeln('Total price: ${cartPrice}원');
  }

  void startShopping() {
    ShoppingMessage.printWelcomeMessage();
    ShoppingMessage.printMenu();

    int inputNum;
    do {
      ShoppingMessage.printInputPrompt();
      inputNum = int.parse(stdin.readLineSync() ?? '0');
      switch (inputNum) {
        case 1:
          stdout.writeln('상품 목록을 보여주는 기능은 아직 구현되지 않았습니다.');
          ShoppingMessage.printMenu();
          break;
        case 2:
          stdout.writeln('장바구니에 담는 기능은 아직 구현되지 않았습니다.');
          ShoppingMessage.printMenu();
          break;
        case 3:
          stdout.writeln('장바구니 총액을 보여주는 기능은 아직 구현되지 않았습니다.');
          ShoppingMessage.printMenu();
          break;
        case 4:
          stdout.writeln('쇼핑을 종료합니다.');
          break;
        default:
          stdout.writeln('잘못된 입력입니다. 다시 시도해주세요.');
      }
    } while (inputNum != 4);

    ShoppingMessage.printExitMessage();
  }

  ShoppingMall(this.products) : cart = [], cartPrice = 0;
}
