# Практическое задание №8 ПКС
## ЭФБО-01-22 Степанова Виктория

В этой практической необходимо было дополнить шестую работу api хапросами, а так же создать программу которая будет эти запросы обрабатывать.

Реализация работы:

**1. main.go**

Здесь созданы 2 структуры, которые обеспечивают хранение данных. В этом же файле я заполнила список продуктов и данные пользователя.
 
![image](https://github.com/user-attachments/assets/65864d97-b030-47d0-80e4-56fe891a8f07)
![image](https://github.com/user-attachments/assets/b0e4d78e-b8dd-4c8c-8c9b-0be51b8ee667)

Далее я дополнила функции обработки запросов (реализовала следующие функции: получение элементов в корзине, получение элементов в избранном, получение данных пользователя, обновление данных пользователя)

![image](https://github.com/user-attachments/assets/4b6ea8f8-d97c-47c6-9a4e-998e0509b123)

**2. api_service.dart**

В этом файле я создала сами запросы. Пример запроса получения списка эелемнтов в корзине:

![image](https://github.com/user-attachments/assets/332ee331-d11f-413c-8217-8292898831f4)

Также реализовала 2 файла со структурами продукта и пользователя

**3. Изменение остальных файлов для работы с api**

Для корректной работы нужно было заменить старую работу с файлом info.dart, где хранились все данные, на работу с api_service.dart

Пример работы:

![image](https://github.com/user-attachments/assets/986d0fb2-3b6a-434f-8882-935cd0c081a2)
![image](https://github.com/user-attachments/assets/302ffeab-4175-473b-b8c3-219b286d136b)
![image](https://github.com/user-attachments/assets/47c15bfe-e6bc-47e1-8089-5052f5836325)
![image](https://github.com/user-attachments/assets/202f3f3d-8dd1-4b18-b992-4fd84e65a01e)
![image](https://github.com/user-attachments/assets/c44c94e8-f006-49d4-aa83-f792b8162517)

Добавление в избранное

![image](https://github.com/user-attachments/assets/9c584df8-4860-43eb-9ae7-c40c777aefa1)
![image](https://github.com/user-attachments/assets/2de4f265-304f-425c-8469-e6dfeb9dcbce)

Добавление в корзину

![image](https://github.com/user-attachments/assets/c3991d75-75ba-47fe-b8f1-2cb8a6fa65f2)
![image](https://github.com/user-attachments/assets/91d54cc8-3586-4cd2-9a2e-ccfb875bcfe5)


