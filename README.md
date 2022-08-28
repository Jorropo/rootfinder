# Root Finder

This is how I find `0000000000008678a96967b303dab11d433b2a17eeceb557d381ab26258e42aa` (48 leading zero bits) also known as `230:f30e:ad2d:3099:f84a:9dc5:7989:abd0` on the [yggdrasil network](https://yggdrasil-network.github.io/).

This is an abandoned project for example sake, feel free to fork and take this code as example but I will not maintain it.

## Disclaimer

I don't know if scaleway allows bruteforcing keys using their machines, you might get in trouble (account banned, ...) if you use this code.

## How to use it

You will need the [scaleway CLI](https://yggdrasil-network.github.io/) settupped.

1. Start `go run record.go` (this will collect run logs) on a machine reachable from yggdrasil.
2. Edit peering and IPs inside [`bootscript.sh`](./bootscript.sh).
  - You need whatever peering that works on yggdrasil.
  - For the netcat IP and ports setup whatever the machine of step 1 listens on.
3. Start the cluster with `./make.bash`
4. You can watch the progress with `watch "rgrep -I Compression | cut -f2 -d' ' | sort --version-sort --reverse"`.
  - To find keys found you can do `rgrep -I -n3 Compression`.
