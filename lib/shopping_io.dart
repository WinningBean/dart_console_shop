import 'dart:io';

import 'package:dart_console_shop/product.dart';
import 'package:dart_console_shop/shopping_menu.dart';

/// 쇼핑몰 메시지를 입출력 클래스
class ShoppingIO {
  /// 시작 메시지를 출력하는 메시지
  static void printWelcomeMessage() {
    stdout.writeln();
    stdout.writeln('🥳 쇼핑몰에 오신 것을 환영합니다!');
  }

  /// 종료 메시지를 출력하는 메시지
  static void printExitMessage() {
    stdout.writeln();
    stdout.writeln('🤗 안녕히 가세요! 이용해 주셔서 감사합니다.');
    stdout.writeln();
  }

  /// 메뉴 목록을 출력하는 메소드
  static void printMenu() {
    stdout.writeln();
    stdout.writeln('메뉴를 선택하세요 (숫자를 입력하세요) ⬇️');
    printDivider();
    stdout.writeln(ShoppingMenu.sortedMenuGuide);
    printDivider();
  }

  /// 상품 내역을 출력하는 메소드
  static void printProduct(String name, int price) {
    stdout.writeln('$name / ${formatPrice(price)}');
  }

  /// 존재하지 않는 상품일 때 출력하는 메시지
  static void printProductNotFoundMessage(String productName) {
    stdout.writeln('해당 상품 "$productName"이 존재하지 않습니다. ');
    printRetryMessage();
  }

  /// 장바구니에 담긴 상품을 출력하는 메시지
  static void printCartItems(Map<Product, int> cart, int cartPrice) {
    if (cart.isEmpty) {
      printEmptyCartMessage();
      return; // 장바구니가 비어있으면 종료
    }

    stdout.writeln('🛒 장바구니에 담긴 상품 리스트:');
    stdout.writeln(
      cart.entries
          .map(
            (entry) =>
                '${entry.key.name} '
                '${formatPrice(entry.key.price)}원 × ${entry.value}개$menuDivider'
                '${formatPrice(entry.key.price * entry.value)}',
          )
          .join('\n'),
    );

    stdout.writeln(ShoppingIO.lineDivideChar * 50);
    printCartTotalPrice(cartPrice);
  }

  /// 장바구니에 담긴 상품의 총 가격을 출력하는 메시지
  static void printCartTotalPrice(int cartPrice) {
    stdout.writeln('💰 장바구니 총 가격: ${formatPrice(cartPrice)}');
  }

  /// 장바구니에 상품을 추가했을 때 출력하는 메시지
  static void printAddToCartMessage(String productName, int count) {
    stdout.writeln('🛍️ $count개의 $productName을(를) 장바구니에 담았습니다.');
  }

  /// 장바구니가 비어있을 때 출력하는 메시지
  static void printEmptyCartMessage() {
    stdout.writeln('장바구니가 비어 있습니다. 상품을 추가해주세요.');
  }

  /// 장바구니가 초기화되었을 때 출력하는 메시지
  static void printCartResetMessage() {
    stdout.writeln('장바구니가 초기화되었습니다.');
  }

  /// 장바구니 초기화 시 이미 비어있을 때 출력하는 메시지
  static void printCartAlreadyResetMessage() {
    stdout.writeln('장바구니가 이미 비어 있습니다.');
  }

  /// 장바구니에 담긴 상품이 100개를 넘어갈 때 출력하는 메시지
  static void printCartOverLimitMessage() {
    stdout.writeln('장바구니에 담을 수 있는 상품은 최대 100개입니다.');
    stdout.writeln('장바구니를 초기화하고 다시 시도해주세요.');
  }

  /// 상품 이름을 입력받는 메소드
  static String? getInputProductName() {
    stdout.write('상품 이름을 입력해 주세요: ');
    String? inputName = stdin.readLineSync();
    if (inputName == null || inputName.isEmpty) {
      stdout.write('상품 이름이 입력되지 않았습니다. ');
      printRetryMessage();
      return null;
    }

    return inputName;
  }

  /// 상품 개수를 입력받는 메소드
  static int? getInputWantedCount() {
    stdout.write('상품 개수를 입력해 주세요: ');
    int? inputCount = int.tryParse(stdin.readLineSync() ?? '');
    if (inputCount == null) {
      stdout.write('상품 개수가 올바르지 않습니다. ');
      printRetryMessage();
      return null;
    }

    if (inputCount <= 0) {
      stdout.write('최소 1개 이상 입력해야 합니다. ');
      printRetryMessage();
      return null;
    }

    return inputCount;
  }

  /// 사용자로부터 메뉴 선택을 받는 getter
  static ShoppingMenu? get selectedMenu {
    printInputPrompt();

    ShoppingMenu? menu;
    try {
      menu = ShoppingMenu.getMenuFromMenuNum(
        int.tryParse(stdin.readLineSync() ?? '') ?? 0,
      );
    } on ArgumentError catch (e) {
      stdout.write(e.message + ' ');
      printRetryMessage();
      return null;
    }
    return menu;
  }

  /// 쇼핑을 종료할지 여부를 묻고, 종료 여부를 반환하는 getter
  static bool get isExit {
    stdout.write("쇼핑을 종료하시겠습니까? ('y'입력 시 종료): ");

    String? input = stdin.readLineSync();
    if (input?.toLowerCase() == 'y') {
      stdout.writeln('쇼핑을 종료합니다.');
      return true;
    }

    stdout.writeln('쇼핑을 계속합니다.');
    return false;
  }

  /// 메뉴 구분자를 반환하는 getter
  static String get menuDivider => ' / ';

  /// 라인 구분자를 반환하는 getter
  static String get lineDivideChar => '=';

  /// 구분선을 출력하는 메소드
  static void printDivider() {
    stdout.writeln('=' * 100);
  }

  /// 입력 프롬프트를 출력하는 메소드
  static void printInputPrompt() {
    stdout.write('입력: ');
  }

  /// 재시도 메시지를 출력하는 메소드
  static void printRetryMessage() {
    stdout.writeln('다시 시도해주세요.');
  }

  /// 가격을 포맷팅하는 메소드
  static String formatPrice(int price) {
    return '${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}원';
  }
}
