package main

import (
	"fmt"
	"log"
	"os"

	"github.com/urfave/cli/v2"
)

func main() {
	app := &cli.App{
		Flags: []cli.Flag{},
		Commands: []*cli.Command{
			{
				Name:    "main",
				Aliases: []string{},
				Usage:   "sample",
				Action: func(c *cli.Context) error {
					fmt.Println("1")
					for {
					}
				},
			},
		}}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
