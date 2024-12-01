package handlers

import (
	"log"
	"net/http"
	"shopApi/models"

	//"back/models"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
)

// GetOrders godoc
// @Summary Get user orders
// @Description Retrieves all orders for a specific user.
// @Tags Orders
// @Produce json
// @Param id path int true "User ID"
// @Success 200 {array} models.Order
// @Failure 400 {object} ErrorResponse "Invalid User ID"
// @Failure 500 {object} ErrorResponse "Internal server error"
// @Router /orders/{id} [get]
// GetOrders godoc
// @Summary Get user orders
// @Description Retrieves all orders for a specific user.
// @Tags Orders
// @Produce json
// @Param id path int true "User ID"
// @Success 200 {array} models.Order
// @Failure 400 {object} ErrorResponse "Invalid User ID"
// @Failure 500 {object} ErrorResponse "Internal server error"
// @Router /orders/{id} [get]
func GetOrders(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		// Получаем ID пользователя
		idStr := c.Param("id")
		id, err := strconv.Atoi(strings.TrimSpace(idStr))
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректный ID пользователя"})
			return
		}

		// Получаем заказы пользователя
		var orders []models.Order
		err = db.Select(&orders, `SELECT * FROM orders WHERE user_id = $1`, id)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка получения заказов"})
			return
		}

		// Если заказы найдены, загружаем товары для каждого заказа
		for i := range orders {
			var products []models.Product
			query := `
                SELECT p.product_id, p.image_url, p.name, p.description, p.features, p.price, p.stock, p.created_at
                FROM product p
                INNER JOIN order_products op ON p.product_id = op.product_id
                WHERE op.order_id = $1
				`

			err := db.Select(&products, query, orders[i].OrderID)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка получения товаров для заказа"})
				return
			}
			orders[i].Products = products
		}

		// Отправляем ответ
		c.JSON(http.StatusOK, orders)
	}
}

// CreateOrder godoc
// @Summary Create a new order
// @Description Adds a new order for a user, including products in the order.
// @Tags Orders
// @Accept json
// @Produce json
// @Param order body models.Order true "Order details"
// @Success 201 {object} models.Order
// @Failure 400 {object} ErrorResponse "Invalid request data"
// @Failure 500 {object} ErrorResponse "Internal server error"
// @Router /orders [post]
func CreateOrder(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var order models.Order

		// Логируем начало запроса
		log.Println("CreateOrder: Start processing order creation")
		log.Printf("recieved order: %+v", order)

		// Привязываем данные из тела запроса
		if err := c.ShouldBindJSON(&order); err != nil {
			log.Printf("CreateOrder: JSON binding error: %v", err)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректные данные"})
			return
		}
		log.Printf("CreateOrder: Received order: %+v", order)

		// Начинаем транзакцию
		tx, err := db.Beginx()
		if err != nil {
			log.Printf("CreateOrder: Transaction initialization error: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка инициализации транзакции"})
			return
		}
		log.Println("CreateOrder: Transaction started")

		// Вставляем заказ в таблицу orders
		queryOrder :=
			`INSERT INTO orders (user_id, total)
		VALUES (:user_id, :total)
		RETURNING order_id`

		rows, err := tx.NamedQuery(queryOrder, &order)
		if err != nil {
			log.Printf("CreateOrder: Error inserting order into 'orders': %v", err)
			tx.Rollback()
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка добавления заказа"})
			return
		}
		log.Println("CreateOrder: Order inserted successfully into 'orders'")

		if rows.Next() {
			if err := rows.Scan(&order.OrderID); err != nil {
				log.Printf("CreateOrder: Error scanning order ID: %v", err)
				tx.Rollback()
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка получения ID заказа"})
				return
			}
			log.Printf("CreateOrder: Retrieved order ID: %d", order.OrderID)
		}
		rows.Close()

		// Вставляем товары в таблицу order_products
		queryProducts := `
		INSERT INTO order_products (order_id, product_id, quantity)
		VALUES (:order_id, :product_id, :stock)
	  `

		for _, product := range order.Products {
			productData := map[string]interface{}{
				"order_id":   order.OrderID,
				"product_id": product.ProductID,
				"stock":      product.Stock,
			}
			log.Printf("inserting product into order_products: order_id=%d, product_id=%d, stock=%d", order.OrderID, product.ProductID, product.Stock)
			log.Printf("CreateOrder: Adding product to order_products: %+v", productData)

			_, err := tx.NamedExec(queryProducts, productData)
			if err != nil {
				log.Printf("CreateOrder: Error inserting product into 'order_products': %v", err)
				tx.Rollback()
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка добавления товаров к заказу"})
				return
			}
		}
		log.Println("CreateOrder: All products added successfully to 'order_products'")

		// Завершаем транзакцию
		if err := tx.Commit(); err != nil {
			log.Printf("CreateOrder: Transaction commit error: %v", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка сохранения заказа"})
			return
		}
		log.Println("CreateOrder: Transaction committed successfully")

		// Отправляем ответ
		c.JSON(http.StatusCreated, order)
	}
}
