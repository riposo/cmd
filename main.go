package main

import (
	"context"
	"flag"
	"os"

	"github.com/google/subcommands"
)

func init() {
	subcommands.Register(subcommands.HelpCommand(), "general help")
	subcommands.Register(subcommands.FlagsCommand(), "general help")
	subcommands.Register(subcommands.CommandsCommand(), "general help")
}

func main() {
	flag.Parse()

	ctx := context.Background()
	os.Exit(int(subcommands.Execute(ctx)))
}
