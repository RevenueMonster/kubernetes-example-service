package main

import (
	"os"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {
	e := echo.New()
	e.Use(middleware.Logger())

	e.GET("/", func(c echo.Context) error {
		return c.String(200, os.Getenv("SYSTEM_NAME"))
	})

	e.Logger.Fatal(e.Start(":5000"))
}
