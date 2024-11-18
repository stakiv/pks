# Практическое задание №11 ПКС
## ЭФБО-01-22 Степанова Виктория

В этой практической необходимо было подключить регистрацию и авторизацию через почту и пароль в приложении с помощью supabase.

**Этапы работы:**

**1. Создание нового проекта в supabase**

Я создала новый проект ice cream shop в supabase и в настройках аутентификации отключила подтверждение почты при регистрации

![image](https://github.com/user-attachments/assets/4a757af7-9ee1-4244-959c-ca313853945f)
![image](https://github.com/user-attachments/assets/521ec73d-f820-43f7-b3b2-fb4e5ab5696e)

**2. Подключение supabase к проекту**

Для подключения supabase я использовала команду `flutter pub add supabase_flutter` и в файле `main.dart` создала подключение к supabase

**3. Реализация авторизации**

Я создала 2 файла в папке auth в проекте:
- `auth_gate.dart` - в нем реализована логика переключения страниц входа в аккаунт и профля в зависимости от того авторизовался пользователь или нет
- `auth_service.dart` - в нем реализованы все необходимые для входа и авторизации методы

![image](https://github.com/user-attachments/assets/014b20fa-5740-4b7d-807b-3e8ef466cfc6)

**4. Страница входа в аккаунт и решистрции**

При первом запуске приложения на странице профиля отображается `login_page.dart`. При нажатии на кнопку "Нет аккаунта? Зарегистрируйтесь" происходит переход на страницу создания аккаунта

![image](https://github.com/user-attachments/assets/2f52f334-b00a-4352-8711-73cc5ebd973e)
![image](https://github.com/user-attachments/assets/3280dff5-5342-4010-bf27-c21f32f02257)
![image](https://github.com/user-attachments/assets/dae8338e-a85f-4adf-a01d-80f4e5d1d55b)

![image](https://github.com/user-attachments/assets/8b563ed9-ca3b-424c-bcc8-d188fdcb6691)
![image](https://github.com/user-attachments/assets/a3223acc-773d-44b9-ab9b-ca4ded27aa6e)
![image](https://github.com/user-attachments/assets/3fddef5a-5af4-43f8-93ff-a1eae8d1c038)

При выходе из аккаунта на странице профиля снова отображается страница входа в аккаунт
