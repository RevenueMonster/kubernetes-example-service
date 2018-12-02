package main

import (
	"os"
	"time"

	"github.com/labstack/echo"
)

var podDescription = ""

func init() {
	podDescription = "Pod started at " + time.Now().UTC().String()
}

func main() {
	e := echo.New()

	e.GET("/", func(c echo.Context) error {

		return c.JSON(200, map[string]interface{}{
			"message":     os.Getenv("SYSTEM_NAME"),
			"description": podDescription,
		})
	})

	e.Logger.Fatal(e.Start(":5000"))
}
