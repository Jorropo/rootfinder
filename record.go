package main

import (
	"fmt"
	"net"
	"os"
	"time"
)

func main() {
	l, err := net.Listen("tcp6", "[::]:12222")
	c(err)

	for {
		c, err := l.Accept()
		if err != nil {
			fmt.Println(err)
			continue
		}

		go func(c net.Conn) {
			defer c.Close()

			addr := c.RemoteAddr().String()

			f, err := os.Create(addr)
			if err != nil {
				fmt.Println(err)
				return
			}
			defer f.Close()

			fmt.Println("new conn from", addr)

			var buf [4096]byte

			for {
				err = c.SetReadDeadline(time.Now().Add(time.Second * 20))
				if err != nil {
					fmt.Println(err)
					return
				}

				n, err := c.Read(buf[:])
				if err != nil {
					fmt.Println(err)
					return
				}

				_, err = f.Write(buf[:n])
				if err != nil {
					fmt.Println(err)
					return
				}
			}
		}(c)
	}
}

func c(e error) {
	if e != nil {
		panic(e)
	}
}
