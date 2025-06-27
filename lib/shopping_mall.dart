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
      ShoppingIO.printProduct(product.name, product.price);
    }
  }

  /// 장바구니에 담긴 상품을 출력하는 메소드
  void showCart() {
    ShoppingIO.printCartItems(cart, cartPrice);
  }

  /// 장바구니에 상품을 추가하는 메소드
  void addToCart() {
    String? productName = ShoppingIO.getInputProductName();
    if (productName == null) {
      return; // 상품 이름이 유효하지 않으면 종료
    }

    if (!products.any((product) => product.name == productName)) {
      ShoppingIO.printProductNotFoundMessage(productName);
      return; // 상품이 존재하지 않으면 종료
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
    ShoppingIO.printAddToCartMessage(product.name, count);
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
      ShoppingIO.printCartAlreadyResetMessage();
      return; // 장바구니가 비어있으면 초기화하지 않음
    }

    cart.clear();
    cartPrice = 0;
    ShoppingIO.printCartResetMessage();
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
        if (ShoppingIO.isExit) {
          isStillShopping = false; // 쇼핑 종료 플래그 설정
          return; // 쇼핑몰 종료
        }
        break;
    }

    ShoppingIO.printMenu(); // 메뉴 출력
  }

  /// 생성자
  ShoppingMall(this.products) : cart = {}, cartPrice = 0;
}
