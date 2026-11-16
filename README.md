# ByteGotchi

How to play to ByteGotchi?

Have a Linux environment:
```
wsl --install -d Debian
```
Install tools:
```
sudo apt update
sudo apt install nasm gcc libsdl2-dev
```

Get the file:
```
mkdir -p ~/bytegotchi
cp /mnt/c/Users/User/Downloads/bytegotchi.s ~/bytegotchi/
cd ~/bytegotchi
```

Compilation:
```
nasm -f elf64 bytegotchi.s -o bytegotchi.o
gcc -no-pie bytegotchi.o -o bytegotchi $(sdl2-config --libs)
```

Play:
```
./bytegotchi
```


