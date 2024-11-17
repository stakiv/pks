# Практическое задание №10 ПКС
## ЭФБО-01-22 Степанова Виктория

В этой практической необходимо было подключить базу данных PostgreSQL и новые API к проекту, а также реализовать работу приложения с этими инструментами.

**Этапы работы:**

**1. Создание базы данных в postgreSQL**

Структура бд

![image](https://github.com/user-attachments/assets/50fc6d01-d6a5-4a66-8933-9c15c0ef0842)

**2. Серверная часть**

Для работы с бд была создана серверная программа, которая состоит из:

- Описания структур данных
- Запросов (get, delete, post, put)
- Подключения к базе данных
- Описания роутеров

![image](https://github.com/user-attachments/assets/dedb0e79-8cb4-4599-8394-6e6cfb25e425)

**3. Клиентская часть**

Для корректоного подключения необходимо было изменить файл api_service для работы с новыми API. Также необходимо было создать структуры данных (cart, favourites, product, model).

Пример запроса из api_service

![image](https://github.com/user-attachments/assets/19682dbc-72a0-4182-abc7-e77baab1609c)



**Примеры работы приложения**

При запуске приложения изначально в корзине и избранном нет товаров, на этих страницах отображается заглушка

![image](https://github.com/user-attachments/assets/0dfb8772-373d-427c-b76b-5c0087666123)
![image](https://github.com/user-attachments/assets/bbad7a15-20f1-4a14-93a5-623c28712571)
![image](https://github.com/user-attachments/assets/facbef98-4f49-4bd3-a1cb-b8d9932add78)

Обработка запросов к избранному и корзине

![image](https://github.com/user-attachments/assets/0fe92d2f-6d29-44af-8dc4-f9ae00fd8da6)

Добавление объектов в избранное и корзину

![image](https://github.com/user-attachments/assets/4a61d21b-fd2c-4a88-aaaa-9b50c533a651)
![image](https://github.com/user-attachments/assets/97c31c58-5e0f-44e9-a1cd-78322474b88a)
![image](https://github.com/user-attachments/assets/c070032e-879c-4958-8e24-3b8bf9f4ea63)

обработка запросов добавления

![image](https://github.com/user-attachments/assets/e89ad17b-91da-4bf6-be0e-15cf8d601a0d)
![image](https://github.com/user-attachments/assets/68e2c220-268a-412e-bd3a-5cdafa03f733)

обработка запросов удаления

![image](https://github.com/user-attachments/assets/0180a6c3-88cd-4f74-a3e7-0953577b1b22)
![image](https://github.com/user-attachments/assets/b19c7113-b132-4deb-9ca0-e8244b407143)

Создание нового продукта

![image](https://github.com/user-attachments/assets/07023db7-7d67-446d-af3f-c4b48bb1c4e3)
![image](https://github.com/user-attachments/assets/5122af65-1a20-4648-9404-e8d9072dfa0e)

обработка запроса создания

![image](https://github.com/user-attachments/assets/8148abbb-7119-4c7a-b881-e13261d2d491)

Удаление продукта

![image](https://github.com/user-attachments/assets/5df9d500-b0bd-4822-bc8c-b0349132bf35)

обработка запроса удаления

![image](https://github.com/user-attachments/assets/e93df411-e048-4182-8a15-44db8ef29be7)
