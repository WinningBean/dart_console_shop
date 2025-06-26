import 'dart:io';

import 'package:dart_console_shop/shopping_menu.dart';

/// 쇼핑몰 메시지를 입출력 클래스
class ShoppingMessage {
  /// 시작 메시지를 출력하는 메소드
  static void printWelcomeMessage() {
    stdout.writeln();
    stdout.writeln('🛍️ 쇼핑몰에 오신 것을 환영합니다!');
  }

  /// 종료 메시지를 출력하는 메소드
  static void printExitMessage() {
    stdout.writeln();
    stdout.writeln('🤗 쇼핑몰에 방문해주셔서 감사합니다!');
    stdout.writeln();
  }

  /// 메뉴 목록을 출력하는 메소드
  static void printMenu() {
    stdout.writeln();
    stdout.writeln('메뉴를 선택하세요 (숫자를 입력하세요) ⬇️');
    printDivider();
    ShoppingMenu.printSortedMenu();
    printDivider();
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

  /// 메뉴 구분자를 출력하는 메소드
  static void printMenuDivider() {
    stdout.write(' / ');
  }

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
}
