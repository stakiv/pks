import 'package:pr7/models/cart.dart';
import 'package:pr7/models/profile.dart';
import 'package:pr7/models/items.dart';
import 'package:pr7/models/user.dart';

User userInfo = User(
  id: 0,
  name: 'Степанова Виктория',
  phone: '+7 900 800-55-33',
  email: 'email@gmail.com',
);

final List<ProfileItem> profileItems = [
  ProfileItem('Мои заказы', 'assets/profile/order.png'),
  ProfileItem('Медицинские карты', 'assets/profile/cards.png'),
  ProfileItem('Мои адреса', 'assets/profile/adress.png'),
  ProfileItem('Настройки', 'assets/profile/settings.png'),
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
  Item(3, 'Витамины группы D: D2 и D3', 7, 3270),
  Item(4, 'Общий белок (венозная кровь)', 1, 180),
  Item(5, 'Кофе IgE (F221, ImmunoCAP)', 4, 860),
];

final List<CartItem> cartItems = <CartItem>[];
