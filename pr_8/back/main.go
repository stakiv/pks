package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Product представляет продукт
type Product struct {
	ID          int
	ImageURL    string
	Name        string
	Description string
	Price       float64
	Features    string
	IsFavourite bool
	IsInCart    bool
	Quantity    int
}

/*
type CartItem struct {
	ProductID int
	Quantity  int
	//Options   map[string]string // Для хранения дополнительных опций продукта
}

type Cart struct {
	//UserID  int
	Items []CartItem
}

type Favourites struct {
	ProductID int
}*/

type User struct {
	ID    int
	Image string
	Name  string
	Phone string
	Mail  string
}

// Пример списка продуктов
var products = []Product{{
	ID:          0,
	ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Rainbow-Sherbet.jpg",
	Name:        "Радужный щербет",
	Description: "Щербеты со вкусом апельсина, ананаса и малины",
	Features:    "без сои, без орехов, без глютена",
	Price:       200,
	IsFavourite: false,
	IsInCart:    false,
	Quantity:    0,
},
	{
		ID:          1,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Pineapple-Papaya-Scoop1.jpg",
		Name:        "Ананас-папайя",
		Description: "Мороженое со вкусом папайи и ананаса с сочными кусочками ананаса.",
		Features:    "без сои, без орехов, без глютена",
		Price:       400,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          2,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-12/ChocolateCookieCrackle--%28oreo%29.jpg",
		Name:        "Шоколадное с печеньем",
		Description: "Классическое шоколадное мороженое с кусочками шоколадного печенья и хрустящей лентой из сливочной помадки",
		Features:    "без орехов, без яиц",
		Price:       100,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          3,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Green-Tea.jpg",
		Name:        "Зеленый чай",
		Description: "Мороженое, приготовленное из листьев зеленого чая.",
		Features:    "без сои, без орехов, без глютена",
		Price:       300,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          4,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Strawberry-Cheesecake.jpg",
		Name:        "Клубничный чизкейк",
		Description: "Нежное мороженое со вкусом чизкейка с кусочками чизкейка и клубничной лентой",
		Features:    "без орехов",
		Price:       100,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          5,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2024-01/Website%20-%20Ice%20cream%20Tile%20%281%29.png",
		Name:        "Клубника-питайя",
		Description: "Клубнично-фруктовое мороженое с завитком из клубничного драгонфрута.",
		Features:    "без сои, без орехов, без глютена, без яиц",
		Price:       200,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          6,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2024-01/Website%20-%20Ice%20cream%20Tile%20%286%29.png",
		Name:        "Шоколадный торт с ежевикой и лесными орехами",
		Description: "Ежевичное мороженое в сочетании с шоколадным мороженым со вкусом лесного ореха и кусочками печенья со вкусом лесного ореха.",
		Features:    "без яиц",
		Price:       400,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          7,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Beach-Day.jpg",
		Name:        "День на пляже",
		Description: "Мороженое с ванилью и голубой морской солью, украшенное черепашками в молочном шоколаде с карамельной начинкой и украшенное лентой из соленого крекера Грэм.",
		Features:    "без орехов, без яиц",
		Price:       100,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          8,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/It-Takes-Two-to-Mango.jpg",
		Name:        "Двойной манго",
		Description: "Манговое мороженое с кусочками настоящего манго, с манговым сорбетом и украшенное сладкой манговой лентой",
		Features:    "без сои, без орехов, без глютена, без яиц",
		Price:       100,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	},
	{
		ID:          9,
		ImageURL:    "https://www.baskinrobbins.com.my/sites/default/files/2023-11/Cotton-Candy.jpg",
		Name:        "Сахарная вата",
		Description: "Мороженое со вкусом розовой и фиолетовой сахарной ваты.",
		Features:    "без молочных продуктов, без орехов, без глютена, без яиц",
		Price:       100,
		IsFavourite: false,
		IsInCart:    false,
		Quantity:    0,
	}}

var users = []User{{
	ID:    1,
	Image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAd5avdba8EiOZH8lmV3XshrXx7dKRZvhx-A&s",
	Name:  "Виктория Степанова",
	Mail:  "example@mail.ru",
	Phone: "3463485352",
}}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {
			products[i].Name = updatedProduct.Name
			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Price = updatedProduct.Price
			products[i].Features = updatedProduct.Features
			products[i].Description = updatedProduct.Description
			products[i].IsFavourite = updatedProduct.IsFavourite
			products[i].IsInCart = updatedProduct.IsInCart
			products[i].Quantity = updatedProduct.Quantity

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func getCartHandler(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodGet {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	var cartProducts = []Product{}

	for _, Product := range products {
		if Product.IsInCart == true {
			w.Header().Set("Content-Type", "application/json")
			cartProducts = append(cartProducts, Product)
		}
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(cartProducts)
}
func getFavoritesHandler(w http.ResponseWriter, r *http.Request) {

	// Преобразуем список заметок в JSON
	var favoriteProducts = []Product{}

	for _, Product := range products {
		if Product.IsFavourite == true {
			w.Header().Set("Content-Type", "application/json")
			favoriteProducts = append(favoriteProducts, Product)
		}
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(favoriteProducts)
}

func getUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Users/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, user := range users {
		if user.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(user)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func updateUserHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/users/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedUser User
	err = json.NewDecoder(r.Body).Decode(&updatedUser)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, user := range users {
		if user.ID == id {
			users[i].Name = updatedUser.Name
			users[i].Image = updatedUser.Image
			users[i].Phone = updatedUser.Phone
			users[i].Mail = updatedUser.Mail

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	http.HandleFunc("/cart", getCartHandler)             // Получить все продукты в корзине
	http.HandleFunc("/favourites", getFavoritesHandler)  // Получить избранные продукты
	http.HandleFunc("/users/", getUserByIDHandler)       // получить данные пользователя
	http.HandleFunc("/users/update/", updateUserHandler) // обновить данные пользователя

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
