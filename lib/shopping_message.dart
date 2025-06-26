import 'dart:io';

class ShoppingMessage {
    static void printInputPrompt() {
    stdout.write('입력: ');
  }

  static void printWelcomeMessage() {
    stdout.writeln();
    stdout.writeln('🛍️ 쇼핑몰에 오신 것을 환영합니다!');
  }

  static void printExitMessage() {
    stdout.writeln();
    stdout.writeln('🤗 쇼핑몰에 방문해주셔서 감사합니다!');
    stdout.writeln();
  }

  static void printMenu() {
    stdout.writeln();
    stdout.writeln('메뉴를 선택하세요 (숫자를 입력하세요) ⬇️');
    printDivider();
    stdout.write('[1] 상품 목록 보기');
    printMenuDivider();
    stdout.write('[2] 장바구니에 담기');
    printMenuDivider();
    stdout.write('[3] 장바구니 총액 보기');
    printMenuDivider();
    stdout.write('[4] 종료');
    stdout.writeln();
    printDivider();
  }

  static void printMenuDivider() {
    stdout.write(' / ');
  }

  static void printDivider() {
    stdout.writeln('=' * 100);
  }
}