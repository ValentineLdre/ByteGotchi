# ByteGotchi

How to play to ByteGotchi?

Have a Linux environment:
```
wsl --install -d Debian
```
Install tools:
sudo apt update
sudo apt install nasm gcc libsdl2-dev

Get the file:
mkdir -p ~/bytegotchi
cp /mnt/c/Users/User/Downloads/bytegotchi.s ~/tama/
cd ~/bytegotchi

Compilation:
nasm -f elf64 tamagotchi_lapin.s -o tamagotchi.o
gcc -no-pie tamagotchi.o -o tamagotchi $(sdl2-config --libs)

Play:
./bytegotchi

Your game is saved even if you close the game. To start over, delete the bytegotchi.sav file (in the folder where you launch the game).
