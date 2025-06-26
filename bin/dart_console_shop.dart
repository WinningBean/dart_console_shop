import 'dart:io';

void main(List<String> arguments) {
  printWelcomeMessage();
  printMenu();

  int inputNum;
  do {
    printInputPrompt();
    inputNum = int.parse(stdin.readLineSync() ?? '0');
    switch (inputNum) {
      case 1:
        stdout.writeln('상품 목록을 보여주는 기능은 아직 구현되지 않았습니다.');
        printMenu();
        break;
      case 2:
        stdout.writeln('장바구니에 담는 기능은 아직 구현되지 않았습니다.');
        printMenu();
        break;
      case 3:
        stdout.writeln('장바구니 총액을 보여주는 기능은 아직 구현되지 않았습니다.');
        printMenu();
        break;
      case 4:
        stdout.writeln('쇼핑을 종료합니다.');
        break;
      default:
        stdout.writeln('잘못된 입력입니다. 다시 시도해주세요.');
    }
  } while (inputNum != 4);

  printExitMessage();
  exit(0);
}

void printInputPrompt() {
  stdout.write('입력: ');
}

void printWelcomeMessage() {
  stdout.writeln();
  print('🛍️ 쇼핑몰에 오신 것을 환영합니다!');
}

void printExitMessage() {
  stdout.writeln();
  print('🤗 쇼핑몰에 방문해주셔서 감사합니다!');
  stdout.writeln();
}

void printMenu() {
  stdout.writeln();
  print('메뉴를 선택하세요 (숫자를 입력하세요) ⬇️');
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

void printMenuDivider() {
  stdout.write(' / ');
}

void printDivider() {
  print('=' * 100);
}