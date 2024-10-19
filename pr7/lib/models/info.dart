import 'package:pr7/models/cart.dart';
import 'package:pr7/models/profile.dart';
import 'package:pr7/models/items.dart';

final List<String> profileInfo = [
  'Эдуард',
  '+7 900 800-55-33',
  'email@gmail.com'
];

final List<profileItem> profileItems = [
  profileItem('Мои заказы', 'assets/profile/order.png'),
  profileItem('Медицинские карты', 'assets/profile/cards.png'),
  profileItem('Мои адреса', 'assets/profile/adress.png'),
  profileItem('Настройки', 'assets/profile/settings.png'),
];

final List<String> footerMenu = [
  'Ответы на вопросы',
  'Политика конфиденциальности',
  'Пользовательское соглашение',
  'Выход'
];

final List<Item> items = [
  Item(0, 'ПЦР-тест на определение РНК коронавируса стандартный', 2, 1800),
  Item(1, 'Клинический анализ крови с лейкоцитарной формулировкой', 1, 690),
  Item(2, 'Биохимический анализ крови, базовый', 1, 2440),
];

final List<CartItem> cartItems = <CartItem>[];
