#! /bin/sh

case "$1" in
	"select") flameshot gui ;;
	"window") flameshot full -p ~/screenshots ;;
	*) flameshot full -p ~/screenshots ;;
esac
