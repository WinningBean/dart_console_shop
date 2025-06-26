import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_menu.dart';
import 'package:dart_console_shop/shopping_io.dart';

/// 쇼핑몰 클래스
class ShoppingMall {
  Set<Product> products;
  Map<Product, int> cart;
  int cartPrice;

  bool isStillShopping = true;

  /// 상품 목록을 출력하는 메소드
  void showProducts() {
    for (var product in products) {
      stdout.writeln('${product.name} / ${product.price}원');
    }
  }

  /// 장바구니에 담긴 상품을 출력하는 메소드
  void showCart() {
    if (cart.isEmpty) {
      stdout.writeln('장바구니가 비어 있습니다.');
      return; // 장바구니가 비어있으면 종료
    }

    stdout.writeln('🛒 장바구니에 담긴 상품 리스트');
    stdout.writeln(
      cart.entries
          .map(
            (entry) =>
                '${entry.key.name} '
                '${entry.key.price}원 × ${entry.value}개${ShoppingIO.menuDivider}'
                '${entry.key.price * entry.value}원',
          )
          .join('\n'),
    );

    stdout.writeln(ShoppingIO.lineDivideChar * 30);
    showTotal(); // 총 가격 출력
  }

  /// 장바구니에 담긴 상품의 총 가격을 출력하는 메소드
  void showTotal() {
    stdout.writeln('💰 장바구니 총 가격: $cartPrice원');
  }

  /// 장바구니에 상품을 추가하는 메소드
  void addToCart() {
    String? productName = ShoppingIO.getInputProductName();
    if (!products.any((product) => product.name == productName)) {
      stdout.write('해당 상품이 존재하지 않습니다. ');
      ShoppingIO.printRetryMessage();
      return; // 상품 이름이 유효하지 않으면 종료
    }

    int? count = ShoppingIO.getInputWantedCount();
    if (count == null) {
      return; // 상품 개수가 유효하지 않으면 종료
    }

    // 상품 찾고 장바구니 추가
    Product product = products.firstWhere(
      (product) => product.name == productName,
    );
    addProductToCart(product, count);
    stdout.writeln('🛍️ $count개의 ${product.name}을(를) 장바구니에 담았습니다.');
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

  /// 장바구니를 초기화하는 메소드
  void resetCart() {
    if (cart.isEmpty) {
      stdout.writeln('장바구니가 이미 비어 있습니다.');
      return; // 장바구니가 비어있으면 초기화하지 않음
    }

    cart.clear();
    cartPrice = 0;
    stdout.writeln('장바구니가 초기화되었습니다.');
  }

  /// 쇼핑을 시작하는 메소드
  void startShopping() {
    ShoppingIO.printWelcomeMessage();
    ShoppingIO.printMenu();

    do {
      // 메뉴 선택
      ShoppingMenu? menu = ShoppingIO.selectedMenu;
      if (menu == null) {
        ShoppingIO.printMenu();
        continue; // 잘못된 입력이면 다시 메뉴 출력
      }
      actionMenu(menu);
    } while (isStillShopping);

    ShoppingIO.printExitMessage();
  }

  /// 선택한 메뉴에 따라 동작을 수행하는 메소드
  void actionMenu(ShoppingMenu menu) {
    switch (menu) {
      case ShoppingMenu.viewProducts:
        showProducts();
        break;
      case ShoppingMenu.addToCart:
        addToCart();
        break;
      case ShoppingMenu.resetCart:
        resetCart();
        break;
      case ShoppingMenu.viewCart:
        showCart();
        break;
      case ShoppingMenu.exit:
        if (isRealyExit) return; // 쇼핑 종료
        break;
    }

    ShoppingIO.printMenu(); // 메뉴 출력
  }

  /// 쇼핑몰을 종료할지 여부를 묻는 getter
  bool get isRealyExit {
    stdout.write("정말 종료하시겠습니까? ('y'입력 시 종료): ");
    String? input = stdin.readLineSync();
    if (input?.toLowerCase() == 'y') {
      isStillShopping = false; // 쇼핑 종료
      stdout.writeln('쇼핑을 종료합니다.');
      return true; // 종료
    }

    isStillShopping = true; // 쇼핑 지속
    stdout.writeln('쇼핑을 계속합니다.');
    return false; // 종료하지 않음
  }

  /// 생성자
  ShoppingMall(this.products) : cart = {}, cartPrice = 0;
}
