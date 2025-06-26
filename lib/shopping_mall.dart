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
    String? productName = findProductName();
    if (productName == null) {
      return; // 상품 이름이 유효하지 않으면 종료
    }

    int? inputCount = getWantedCount();
    if (inputCount == null) {
      return; // 상품 개수가 유효하지 않으면 종료
    }

    // 상품 찾기
    Product product = products.firstWhere((product) => product.name == productName);
    addProductToCart(product, inputCount);
    cartPrice += product.price * inputCount;

    stdout.writeln('🛒 $inputCount개의 ${product.name}을(를) 장바구니에 담았습니다.');
  }

  void addProductToCart(Product product, int count) {
    // 장바구니에 추가
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + count;
    } else {
      cart[product] = count;
    }
  }

  String? findProductName() {
    // 상품 이름 입력
    stdout.write('상품 이름을 입력해 주세요: ');
    String? inputName = stdin.readLineSync();
    if (inputName == null || inputName.isEmpty) {
      stdout.write('상품 이름이 입력되지 않았습니다. ');
      ShoppingMessage.printRetryMessage();
      return null;
    }

    if (!products.any((product) => product.name == inputName)) {
      stdout.write('해당 상품이 존재하지 않습니다. ');
      ShoppingMessage.printRetryMessage();
      return null;
    }

    return inputName;
  }

  int? getWantedCount() {
    // 상품 개수 입력
    stdout.write('상품 개수를 입력해 주세요: ');
    int? inputCount = int.tryParse(stdin.readLineSync() ?? '');
    if (inputCount == null) {
      stdout.write('상품 개수가 올바르지 않습니다. ');
      ShoppingMessage.printRetryMessage();
      return null;
    }

    if (inputCount <= 0) {
      stdout.write('최소 1개 이상 입력해야 합니다. ');
      ShoppingMessage.printRetryMessage();
      return null;
    }

    return inputCount;
  }

  void showTotal() {
    stdout.writeln('Total price: $cartPrice원');
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
          showProducts();
          ShoppingMessage.printMenu();
          break;
        case 2:
          addToCart();
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

  ShoppingMall(this.products) : cart = {}, cartPrice = 0;
}
