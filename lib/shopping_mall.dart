import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_menu.dart';
import 'package:dart_console_shop/shopping_message.dart';

/// 쇼핑몰 클래스
class ShoppingMall {
  Set<Product> products;
  Map<Product, int> cart;
  int cartPrice;

  /// 상품 목록을 출력하는 메소드
  void showProducts() {
    for (var product in products) {
      stdout.writeln('${product.name} / ${product.price}원');
    }
  }

  /// 장바구니에 담긴 상품의 총 가격을 출력하는 메소드
  void showTotal() {
    stdout.writeln('💰 장바구니에 $cartPrice원 어치를 담있습니다.');
  }

  /// 장바구니에 상품을 추가하는 메소드
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
    Product product = products.firstWhere(
      (product) => product.name == productName,
    );
    addProductToCart(product, count);
    stdout.writeln('🛒 $count개의 ${product.name}을(를) 장바구니에 담았습니다.');
  }

  /// 장바구니에 상품을 추가하는 내부 메소드
  void addProductToCart(Product product, int count) {
    // 장바구니에 추가
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + count;
    } else {
      cart[product] = count;
    }
    cartPrice += product.price * count;
  }

  /// 쇼핑을 시작하는 메소드
  void startShopping() {
    ShoppingMessage.printWelcomeMessage();
    ShoppingMessage.printMenu();

    ShoppingMenu? menu;
    do {
      // 메뉴 선택
      menu = selectedMenu;
      if (menu == null) {
        ShoppingMessage.printMenu();
        continue; // 잘못된 입력이면 다시 메뉴 출력
      }
      actionMenu(menu);
    } while (menu != ShoppingMenu.exit);

    ShoppingMessage.printExitMessage();
  }

  /// 사용자로부터 메뉴 선택을 받는 메소드
  ShoppingMenu? get selectedMenu {
    ShoppingMenu? menu;
    ShoppingMessage.printInputPrompt();

    try {
      menu = ShoppingMenu.getMenuFromMenuNum(
        int.tryParse(stdin.readLineSync() ?? '') ?? 0,
      );
    } on ArgumentError catch (e) {
      stdout.write(e.message + ' ');
      ShoppingMessage.printRetryMessage();
      return null;
    }
    return menu;
  }

  /// 선택한 메뉴에 따라 동작을 수행하는 메소드
  void actionMenu(ShoppingMenu menu) {
    switch (menu) {
      case ShoppingMenu.viewProducts:
        showProducts();
        ShoppingMessage.printMenu();
        break;
      case ShoppingMenu.addToCart:
        addToCart();
        ShoppingMessage.printMenu();
        break;
      case ShoppingMenu.viewTotal:
        showTotal();
        ShoppingMessage.printMenu();
        break;
      case ShoppingMenu.exit:
        stdout.writeln('쇼핑을 종료합니다.');
        break;
    }
  }

  /// 생성자
  ShoppingMall(this.products) : cart = {}, cartPrice = 0;
}
