package handlers

import (
	"net/http"
	"shopApi/models"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
)

func GetUser(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		email := c.Param("email")

		var user models.User
		err := db.Get(&user, "SELECT * FROM users WHERE email = $1", email)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{
				"error":   "Пользователь не найден",
				"details": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, user)
	}
	/*
		return func(c *gin.Context) {
			userIdStr := c.Param("email")
			userId, err := strconv.Atoi(userIdStr)
			if err != nil {
				c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректный ID пользователя"})
				return
			}

			var user models.User
			err = db.Get(&user, "SELECT * FROM users WHERE user_id = $1", userId)
			if err != nil {
				c.JSON(http.StatusNotFound, gin.H{
					"error":   "Ошибка получения данных пользователя",
					"details": err.Error(),
				})
				return
			}

			c.JSON(http.StatusOK, user)
		}*/
}

// Получение пользователя по email
func GetUserByEmail(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		email := c.Param("email")

		var user models.User
		err := db.Get(&user, "SELECT * FROM users WHERE email = $1", email)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{
				"error":   "Пользователь не найден",
				"details": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, user)
	}
}

// Обновление существующего пользователя по его ID
func UpdateUser(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		idStr := c.Param("userId")
		id, err := strconv.Atoi(idStr)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректный ID пользователя"})
			return
		}

		var user models.User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректные данные"})
			return
		}

		user.UserID = id
		query := `UPDATE Users SET username = :username, email = :email, phone_number = :phone, image_url = :image_url WHERE user_id = :user_id`

		_, err = db.NamedExec(query, &user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка обновления данных пользователя"})
			return
		}

		c.JSON(http.StatusOK, user)
	}
}

// Создание нового пользователя
func CreateUser(db *sqlx.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var user models.User
		// Привязываем данные из JSON к структуре User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Некорректные данные"})
			return
		}

		// Вставляем нового пользователя в базу данных
		query := `INSERT INTO users (username, email, phone_number, password, image_url) 
		          VALUES (:username, :email, :phone, :password, :image_url) RETURNING user_id`

		// Выполняем запрос и получаем сгенерированный ID
		err := db.Get(&user.UserID, query, user)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Ошибка создания пользователя"})
			return
		}

		c.JSON(http.StatusCreated, user)
	}
}
