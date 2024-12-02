# Практическое задание №13 ПКС
## ЭФБО-01-22 Степанова Виктория

В этой практической необходимо было создать систему заказов.

**Этапы работы:**

**1. Создание таблиц в бд**

Для для хранению данных заказов были созданы соответствующие таблицы в бд: orders и order_products

![image](https://github.com/user-attachments/assets/23cffa0a-1675-4bf4-9cfa-66ae9d13799e)
![image](https://github.com/user-attachments/assets/64122fa9-64d8-432e-a637-55a8a0a983bc)

**2. Серверная часть**

Были добавлены новые роуты, модель и функции получения данных заказов и создания нового заказа

![image](https://github.com/user-attachments/assets/02a2776f-ae9c-4a92-b4f5-670f93b03a0d)
![image](https://github.com/user-attachments/assets/890d584f-e7e5-430c-8238-c8a8bab1df25)

**3. Клиентская часть**

Для корректоного подключения необходимо было изменить файл `api_service`. Также необходимо было создать структуру данных для заказов - `order_model.dart` и страницу, где будут отображаться данные заказов.

![image](https://github.com/user-attachments/assets/f3194ebc-1c7f-4a66-bd90-846dfff87cd1)
![image](https://github.com/user-attachments/assets/e66db17f-548a-4014-a340-5b7108703d5a)

**Примеры работы приложения**


