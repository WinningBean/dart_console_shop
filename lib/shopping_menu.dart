/// 쇼핑 메뉴를 정의하는 enum
enum ShoppingMenu {
  viewProducts(menuNum: 1, description: '상품 목록 보기'),
  addToCart(menuNum: 2, description: '장바구니에 담기'),
  viewCart(menuNum: 3, description: '장바구니 보기'),
  resetCart(menuNum: 4, description: '장바구니 초기화'),
  exit(menuNum: 5, description: '쇼핑몰 종료');

  const ShoppingMenu({required this.menuNum, required this.description});

  final int menuNum;
  final String description;

  /// menuNum을 기준으로 정렬된 메뉴 목록과 출력 문자열 생성
  static final sortedMenus = ShoppingMenu.values.toList()
    ..sort((a, b) => a.menuNum.compareTo(b.menuNum));
  static final sortedMenuGuide = sortedMenus
      .map((menu) => '[${menu.menuNum}] ${menu.description}')
      .toList()
      .join(' / ');

  /// menuNum에 해당하는 메뉴를 반환하는 메소드
  static ShoppingMenu? getMenuFromMenuNum(int menuNum) {
    return ShoppingMenu.values.firstWhere(
      (menu) => menu.menuNum == menuNum,
      orElse: () => throw ArgumentError('유효하지 않은 메뉴입니다.'),
    );
  }
}
