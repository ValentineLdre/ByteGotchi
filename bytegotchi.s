default rel

%define LARGEUR 160
%define HAUTEUR 144

%define ETAT_OEUF 0
%define ETAT_NOM 1
%define ETAT_JEU 2
%define ETAT_IDENTITE 3
%define ETAT_BESOINS 4
%define ETAT_MAGASIN 5
%define ETAT_SOMMEIL 6
%define ETAT_MANGER 7
%define ETAT_JOUER 8
%define ETAT_INVENTAIRE 9
%define ETAT_DEVINE 10
%define ETAT_PFC 11
%define ETAT_MORPION 12
%define ETAT_HYGIENE 13
%define ETAT_FIN 14
%define ETAT_TITRE 15

%define SON_CLIC 0
%define SON_ACHAT 1
%define SON_ERREUR 2
%define SON_MIAM 3
%define SON_REVEIL 4
%define SON_DODO 5
%define SON_CARESSE 6
%define SON_VICTOIRE 7
%define SON_DEFAITE 8
%define SON_NETTOYE 9
%define SON_CACA 10
%define SON_GUERI 11
%define SON_MALADE 12
%define SON_GRANDI 13
%define SON_MORT 14
%define CAPACITE_AUDIO 32768

%ifndef INTERVALLE_TICK
%define INTERVALLE_TICK 6000
%endif
%define DUREE_MESSAGE 3000
%define JOURS_ADULTE 3
%define NB_ANIMAUX 5
%define NB_ITEMS 12
%define MAX_CACAS 4
%define SEUIL_MALHEUREUX 36
%define SEUIL_DEPART 90
%define IMMUNITE 90
%define MAGIC 0x42595433

%macro entree 0
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
%endmacro

%macro sortie 0
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
%endmacro

extern SDL_Init, SDL_CreateWindow, SDL_CreateRenderer, SDL_RenderSetLogicalSize
extern SDL_StartTextInput, SDL_PollEvent, SDL_GetTicks, SDL_Delay
extern SDL_InitSubSystem, SDL_OpenAudioDevice, SDL_PauseAudioDevice, SDL_QueueAudio, SDL_ClearQueuedAudio
extern SDL_SetRenderDrawColor, SDL_RenderClear, SDL_RenderFillRect
extern SDL_RenderDrawRect, SDL_RenderDrawPoint, SDL_RenderPresent
extern SDL_DestroyRenderer, SDL_DestroyWindow, SDL_Quit
extern time, srand, rand, localtime
extern fopen, fwrite, fread, fclose, remove

section .rodata

%define NB_MOTS 91

police:
    db 0b000, 0b000, 0b000, 0b000, 0b000
    db 0b010, 0b010, 0b010, 0b000, 0b010
    db 0b101, 0b101, 0b000, 0b000, 0b000
    db 0b101, 0b111, 0b101, 0b111, 0b101
    db 0b011, 0b110, 0b111, 0b011, 0b110
    db 0b101, 0b001, 0b010, 0b100, 0b101
    db 0b010, 0b101, 0b010, 0b101, 0b011
    db 0b010, 0b010, 0b000, 0b000, 0b000
    db 0b001, 0b010, 0b010, 0b010, 0b001
    db 0b100, 0b010, 0b010, 0b010, 0b100
    db 0b000, 0b101, 0b010, 0b101, 0b000
    db 0b000, 0b010, 0b111, 0b010, 0b000
    db 0b000, 0b000, 0b000, 0b010, 0b100
    db 0b000, 0b000, 0b111, 0b000, 0b000
    db 0b000, 0b000, 0b000, 0b000, 0b010
    db 0b001, 0b001, 0b010, 0b100, 0b100
    db 0b111, 0b101, 0b101, 0b101, 0b111
    db 0b010, 0b110, 0b010, 0b010, 0b111
    db 0b111, 0b001, 0b111, 0b100, 0b111
    db 0b111, 0b001, 0b111, 0b001, 0b111
    db 0b101, 0b101, 0b111, 0b001, 0b001
    db 0b111, 0b100, 0b111, 0b001, 0b111
    db 0b111, 0b100, 0b111, 0b101, 0b111
    db 0b111, 0b001, 0b001, 0b010, 0b010
    db 0b111, 0b101, 0b111, 0b101, 0b111
    db 0b111, 0b101, 0b111, 0b001, 0b111
    db 0b000, 0b010, 0b000, 0b010, 0b000
    db 0b000, 0b010, 0b000, 0b010, 0b100
    db 0b001, 0b010, 0b100, 0b010, 0b001
    db 0b000, 0b111, 0b000, 0b111, 0b000
    db 0b100, 0b010, 0b001, 0b010, 0b100
    db 0b111, 0b001, 0b011, 0b000, 0b010
    db 0b011, 0b100, 0b110, 0b100, 0b011
    db 0b010, 0b101, 0b111, 0b101, 0b101
    db 0b110, 0b101, 0b110, 0b101, 0b110
    db 0b011, 0b100, 0b100, 0b100, 0b011
    db 0b110, 0b101, 0b101, 0b101, 0b110
    db 0b111, 0b100, 0b110, 0b100, 0b111
    db 0b111, 0b100, 0b110, 0b100, 0b100
    db 0b011, 0b100, 0b101, 0b101, 0b011
    db 0b101, 0b101, 0b111, 0b101, 0b101
    db 0b111, 0b010, 0b010, 0b010, 0b111
    db 0b001, 0b001, 0b001, 0b101, 0b010
    db 0b101, 0b101, 0b110, 0b101, 0b101
    db 0b100, 0b100, 0b100, 0b100, 0b111
    db 0b101, 0b111, 0b111, 0b101, 0b101
    db 0b111, 0b101, 0b101, 0b101, 0b101
    db 0b010, 0b101, 0b101, 0b101, 0b010
    db 0b110, 0b101, 0b110, 0b100, 0b100
    db 0b010, 0b101, 0b101, 0b111, 0b011
    db 0b110, 0b101, 0b110, 0b101, 0b101
    db 0b011, 0b100, 0b010, 0b001, 0b110
    db 0b111, 0b010, 0b010, 0b010, 0b010
    db 0b101, 0b101, 0b101, 0b101, 0b111
    db 0b101, 0b101, 0b101, 0b101, 0b010
    db 0b101, 0b101, 0b111, 0b111, 0b101
    db 0b101, 0b101, 0b010, 0b101, 0b101
    db 0b101, 0b101, 0b010, 0b010, 0b010
    db 0b111, 0b001, 0b010, 0b100, 0b111
    db 0b011, 0b010, 0b010, 0b010, 0b011
    db 0b100, 0b100, 0b010, 0b001, 0b001
    db 0b110, 0b010, 0b010, 0b010, 0b110
    db 0b010, 0b101, 0b000, 0b000, 0b000
    db 0b000, 0b000, 0b000, 0b000, 0b111

sprite_oeuf:
    dw 0b0000011111100000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000011111100000

sprites_animaux:
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000100000010000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001100110011000
    dw 0b0001100110011000
    dw 0b0001111111111000
    dw 0b0001111001111000
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000100000010000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001100110011000
    dw 0b0001111111111000
    dw 0b0001111001111000
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000100000010000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001100110011000
    dw 0b0001100110011000
    dw 0b0001111111111000
    dw 0b0001111001111000
    dw 0b0000110000110000
    dw 0b0000011001100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0110111111110110
    dw 0b0110110110110110
    dw 0b0110110110110110
    dw 0b0110111111110110
    dw 0b0110111001110110
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0110111111110110
    dw 0b0110111111110110
    dw 0b0110100110010110
    dw 0b0110111111110110
    dw 0b0110111001110110
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0110111111110110
    dw 0b0110110110110110
    dw 0b0110110110110110
    dw 0b0110111111110110
    dw 0b0110111001110110
    dw 0b0000110000110000
    dw 0b0000011001100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0011100000011100
    dw 0b0111110000111110
    dw 0b0111110000111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0001101111011000
    dw 0b0001101111011000
    dw 0b0001111111111000
    dw 0b0000111001110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0011100000011100
    dw 0b0111110000111110
    dw 0b0111110000111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001100110011000
    dw 0b0001111111111000
    dw 0b0000111001110000
    dw 0b0000011111100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0011100000011100
    dw 0b0111110000111110
    dw 0b0111110000111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0001101111011000
    dw 0b0001101111011000
    dw 0b0001111111111000
    dw 0b0000111001110000
    dw 0b0000010000100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000001010000000
    dw 0b0000000100000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0001101111011000
    dw 0b0001101111011000
    dw 0b0001111001111000
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000010000100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000001010000000
    dw 0b0000000100000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0001100110011000
    dw 0b0001111001111000
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000010000100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000001010000000
    dw 0b0000000100000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0001101111011000
    dw 0b0001101111011000
    dw 0b0001110000111000
    dw 0b0001111001111000
    dw 0b0000111111110000
    dw 0b0000010000100000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b0011011111101100
    dw 0b0011011111101100
    dw 0b0011111111111100
    dw 0b0011111001111100
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011001111001100
    dw 0b0011111111111100
    dw 0b0011111001111100
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0000110000110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b0011011111101100
    dw 0b0011011111101100
    dw 0b0011111111111100
    dw 0b0011111001111100
    dw 0b0001110000111000
    dw 0b0000111001110000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0110000000000110
    dw 0b0111000000001110
    dw 0b0111100000011110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111001111001110
    dw 0b0111001111001110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0110000000000110
    dw 0b0111000000001110
    dw 0b0111100000011110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111001111001110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0110000000000110
    dw 0b0111000000001110
    dw 0b0111100000011110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111001111001110
    dw 0b0111001111001110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111110000111110
    dw 0b0011111001111100
    dw 0b0001111111111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b1110111111110111
    dw 0b1110110110110111
    dw 0b1110110110110111
    dw 0b1110111111110111
    dw 0b1110111001110111
    dw 0b1110111111110111
    dw 0b0110011111100110
    dw 0b0110001111000110
    dw 0b0000001111000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b1110111111110111
    dw 0b1110111111110111
    dw 0b1110100110010111
    dw 0b1110111111110111
    dw 0b1110111001110111
    dw 0b1110111111110111
    dw 0b0110011111100110
    dw 0b0110001111000110
    dw 0b0000001111000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000111111110000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b1110111111110111
    dw 0b1110110110110111
    dw 0b1110110110110111
    dw 0b1110111111110111
    dw 0b1110111001110111
    dw 0b1110111111110111
    dw 0b0110010000100110
    dw 0b0110001001000110
    dw 0b0000001111000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0011110000111100
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111011111101110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0011110000111100
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111001111001110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0011110000111100
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0111111001111110
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111011111101110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0011110000111100
    dw 0b0001111001111000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000011110000
    dw 0b0000000111111000
    dw 0b0000000110111111
    dw 0b0000000111111100
    dw 0b0000001111111000
    dw 0b0010001111111000
    dw 0b0111011111111000
    dw 0b0111111111111100
    dw 0b0111011111111110
    dw 0b0010001111111110
    dw 0b0000000111111100
    dw 0b0000000011110000
    dw 0b0000000101000000
    dw 0b0000000101000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000011110000
    dw 0b0000000111111000
    dw 0b0000000100111111
    dw 0b0000000111111100
    dw 0b0000001111111000
    dw 0b0010001111111000
    dw 0b0111011111111000
    dw 0b0111111111111100
    dw 0b0111011111111110
    dw 0b0010001111111110
    dw 0b0000000111111100
    dw 0b0000000011110000
    dw 0b0000000101000000
    dw 0b0000000101000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000011110000
    dw 0b0000000111111000
    dw 0b0000000110111111
    dw 0b0000000111100000
    dw 0b0000001111111000
    dw 0b0010001111111000
    dw 0b0111011111111000
    dw 0b0111111111111100
    dw 0b0111011111111110
    dw 0b0010001111111110
    dw 0b0000000111111100
    dw 0b0000000011110000
    dw 0b0000000101000000
    dw 0b0000000101000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111011111101110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000

    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111001111001110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000000000000000

    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0001110000111000
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111011111101110
    dw 0b0111111111111110
    dw 0b0111111001111110
    dw 0b0111110110111110
    dw 0b0111110000111110
    dw 0b0011111001111100
    dw 0b0001111111111000
    dw 0b0000000000000000

sprites_icones:
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0111111111111110
    dw 0b0100000000000010
    dw 0b0101111011111010
    dw 0b0101111000000010
    dw 0b0101111011111010
    dw 0b0101111000000010
    dw 0b0101111011110010
    dw 0b0100000000000010
    dw 0b0101111111111010
    dw 0b0100000000000010
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0111111111100000
    dw 0b0111111111100000
    dw 0b0000000000000000
    dw 0b0111111000000000
    dw 0b0111111000000000
    dw 0b0000000000000000
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0111100000000000
    dw 0b0111100000000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000001111000000
    dw 0b0000010000100000
    dw 0b0000010000100000
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0011111111111100
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000011000000000
    dw 0b0001110000000000
    dw 0b0011100000000000
    dw 0b0011100000000000
    dw 0b0111100000000000
    dw 0b0111100000000000
    dw 0b0111100000000000
    dw 0b0111110000000000
    dw 0b0111111000000000
    dw 0b0011111100000000
    dw 0b0011111111111000
    dw 0b0001111111110000
    dw 0b0000011111000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000011110000
    dw 0b0000000011111000
    dw 0b0000011111100000
    dw 0b0000111001110000
    dw 0b0001111111111000
    dw 0b0001011111111000
    dw 0b0011011111111100
    dw 0b0011011111111100
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000011111100000
    dw 0b0000111111110000
    dw 0b0001110000111000
    dw 0b0011011001101100
    dw 0b0110001111000110
    dw 0b0110001111000110
    dw 0b0110001111000110
    dw 0b0110001111000110
    dw 0b0110001111000110
    dw 0b0110001111000110
    dw 0b0011011001101100
    dw 0b0001110000111000
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0000011111100000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000001100000000
    dw 0b0000010010001100
    dw 0b0000010010010010
    dw 0b0000001100001100
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0111111111111110
    dw 0b0111011110111110
    dw 0b0111111111111110
    dw 0b0111110111011110
    dw 0b0111111111111110
    dw 0b0110111111101110
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0000000000000000

    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0100000000000010
    dw 0b0100000000000010
    dw 0b0111111111111110
    dw 0b0100000000000010
    dw 0b0100000110000010
    dw 0b0100000110000010
    dw 0b0100000000000010
    dw 0b0100000000000010
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

sprite_spirale:
    dw 0b0000000000000000
    dw 0b0000011111110000
    dw 0b0001100000001100
    dw 0b0011000000000110
    dw 0b0010001111100010
    dw 0b0010011000110001
    dw 0b0100010000011001
    dw 0b0100010000001001
    dw 0b0110010011001001
    dw 0b0010011110001001
    dw 0b0010000000011001
    dw 0b0001000000110001
    dw 0b0000110001100010
    dw 0b0000011111000000
    dw 0b0000000000000000
    dw 0b0000000000000000

sprite_caca:
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000110000000
    dw 0b0000001111000000
    dw 0b0000011111100000
    dw 0b0001111111111000
    dw 0b0011111111111100
    dw 0b0011001111001100
    dw 0b0011001111001100
    dw 0b0011111111111100
    dw 0b0111111111111110
    dw 0b0111110000111110
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

sprite_coeur:
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0011110000111100
    dw 0b0111111001111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0111111111111110
    dw 0b0011111111111100
    dw 0b0001111111111000
    dw 0b0000111111110000
    dw 0b0000011111100000
    dw 0b0000001111000000
    dw 0b0000000110000000
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0000000000000000

sprite_odeur:
    dw 0b0000000000000000
    dw 0b0000000000000000
    dw 0b0001000001000100
    dw 0b0010000010001000
    dw 0b0010000010001000
    dw 0b0001000001000100
    dw 0b0001000001000100
    dw 0b0010000010001000
    dw 0b0010000010001000
    dw 0b0001000001000100
    dw 0b0001000001000100
    dw 0b0010000010001000
    dw 0b0010000010001000
    dw 0b0001000001000100
    dw 0b0000000000000000
    dw 0b0000000000000000

sprite_croix:
    dw 0b0000000000000000
    dw 0b0110000000000110
    dw 0b0111000000001110
    dw 0b0011100000011100
    dw 0b0001110000111000
    dw 0b0000111001110000
    dw 0b0000011111100000
    dw 0b0000001111000000
    dw 0b0000001111000000
    dw 0b0000011111100000
    dw 0b0000111001110000
    dw 0b0001110000111000
    dw 0b0011100000011100
    dw 0b0111000000001110
    dw 0b0110000000000110
    dw 0b0000000000000000

sprite_rond:
    dw 0b0000000000000000
    dw 0b0000011111100000
    dw 0b0001111111111000
    dw 0b0011111001111100
    dw 0b0011100000011100
    dw 0b0111000000001110
    dw 0b0111000000001110
    dw 0b0110000000000110
    dw 0b0110000000000110
    dw 0b0111000000001110
    dw 0b0111000000001110
    dw 0b0011100000011100
    dw 0b0011111001111100
    dw 0b0001111111111000
    dw 0b0000011111100000
    dw 0b0000000000000000

sprite_tombe:
    dw 0b0000000000000000
    dw 0b0000011111100000
    dw 0b0000111111110000
    dw 0b0001111001111000
    dw 0b0001111001111000
    dw 0b0001100000011000
    dw 0b0001100000011000
    dw 0b0001111001111000
    dw 0b0001111001111000
    dw 0b0001111001111000
    dw 0b0001111001111000
    dw 0b0001111111111000
    dw 0b0001111111111000
    dw 0b0111111111111110
    dw 0b0000000000000000
    dw 0b0000000000000000

accents:
    db 'A', 2
    db 'A', 1
    db 'A', 3
    db 'A', 0
    db 'A', 4
    db 'A', 0
    db 0, 0
    db 'C', 5
    db 'E', 2
    db 'E', 1
    db 'E', 3
    db 'E', 4
    db 'I', 2
    db 'I', 1
    db 'I', 3
    db 'I', 4
    db 0, 0
    db 'N', 0
    db 'O', 2
    db 'O', 1
    db 'O', 3
    db 'O', 0
    db 'O', 4
    db 0, 0
    db 'O', 0
    db 'U', 2
    db 'U', 1
    db 'U', 3
    db 'U', 4
    db 'Y', 1
    db 0, 0
    db 'S', 0

mot_00 db "CHAT", 0
mot_01 db "CHIEN", 0
mot_02 db "SOURIS", 0
mot_03 db "LAPIN", 0
mot_04 db "OISEAU", 0
mot_05 db "POISSON", 0
mot_06 db "TORTUE", 0
mot_07 db "GIRAFE", 0
mot_08 db "ZEBRE", 0
mot_09 db "ELEPHANT", 0
mot_10 db "LION", 0
mot_11 db "TIGRE", 0
mot_12 db "SINGE", 0
mot_13 db "PANDA", 0
mot_14 db "KOALA", 0
mot_15 db "CHEVAL", 0
mot_16 db "VACHE", 0
mot_17 db "COCHON", 0
mot_18 db "MOUTON", 0
mot_19 db "POULE", 0
mot_20 db "CANARD", 0
mot_21 db "HIBOU", 0
mot_22 db "RENARD", 0
mot_23 db "LOUP", 0
mot_24 db "OURS", 0
mot_25 db "BALEINE", 0
mot_26 db "DAUPHIN", 0
mot_27 db "REQUIN", 0
mot_28 db "PAPILLON", 0
mot_29 db "ABEILLE", 0
mot_30 db "FOURMI", 0
mot_31 db "ARAIGNEE", 0
mot_32 db "ESCARGOT", 0
mot_33 db "GRENOUILLE", 0
mot_34 db "SERPENT", 0
mot_35 db "LEZARD", 0
mot_36 db "CROCODILE", 0
mot_37 db "KANGOUROU", 0
mot_38 db "POMME", 0
mot_39 db "RAISIN", 0
mot_40 db "FRAISE", 0
mot_41 db "CERISE", 0
mot_42 db "BANANE", 0
mot_43 db "ORANGE", 0
mot_44 db "CAROTTE", 0
mot_45 db "FROMAGE", 0
mot_46 db "CHOCOLAT", 0
mot_47 db "BONBON", 0
mot_48 db "GATEAU", 0
mot_49 db "BISCUIT", 0
mot_50 db "YAOURT", 0
mot_51 db "TOMATE", 0
mot_52 db "POIREAU", 0
mot_53 db "BALLON", 0
mot_54 db "JARDIN", 0
mot_55 db "MAISON", 0
mot_56 db "FLEUR", 0
mot_57 db "VOITURE", 0
mot_58 db "VELO", 0
mot_59 db "AVION", 0
mot_60 db "BATEAU", 0
mot_61 db "TRAIN", 0
mot_62 db "LIVRE", 0
mot_63 db "CRAYON", 0
mot_64 db "CHAISE", 0
mot_65 db "TABLE", 0
mot_66 db "LAMPE", 0
mot_67 db "FENETRE", 0
mot_68 db "MONTAGNE", 0
mot_69 db "FORET", 0
mot_70 db "RIVIERE", 0
mot_71 db "SOLEIL", 0
mot_72 db "NUAGE", 0
mot_73 db "ETOILE", 0
mot_74 db "PLAGE", 0
mot_75 db "ASSEMBLEUR", 0
mot_76 db "ORDINATEUR", 0
mot_77 db "CLAVIER", 0
mot_78 db "PROCESSEUR", 0
mot_79 db "MEMOIRE", 0
mot_80 db "REGISTRE", 0
mot_81 db "PROGRAMME", 0
mot_82 db "COMPILATEUR", 0
mot_83 db "OCTET", 0
mot_84 db "BINAIRE", 0
mot_85 db "PIXEL", 0
mot_86 db "ECRAN", 0
mot_87 db "LINUX", 0
mot_88 db "DEBIAN", 0
mot_89 db "TERMINAL", 0
mot_90 db "RESEAU", 0

mots dq mot_00, mot_01, mot_02, mot_03, mot_04, mot_05, mot_06, mot_07, mot_08, mot_09, mot_10, mot_11, mot_12, mot_13, mot_14, mot_15, mot_16, mot_17, mot_18, mot_19, mot_20, mot_21, mot_22, mot_23, mot_24, mot_25, mot_26, mot_27, mot_28, mot_29, mot_30, mot_31, mot_32, mot_33, mot_34, mot_35, mot_36, mot_37, mot_38, mot_39, mot_40, mot_41, mot_42, mot_43, mot_44, mot_45, mot_46, mot_47, mot_48, mot_49, mot_50, mot_51, mot_52, mot_53, mot_54, mot_55, mot_56, mot_57, mot_58, mot_59, mot_60, mot_61, mot_62, mot_63, mot_64, mot_65, mot_66, mot_67, mot_68, mot_69, mot_70, mot_71, mot_72, mot_73, mot_74, mot_75, mot_76, mot_77, mot_78, mot_79, mot_80, mot_81, mot_82, mot_83, mot_84, mot_85, mot_86, mot_87, mot_88, mot_89, mot_90


titre db "BYTEGOTCHI", 0
nom_fichier db "bytegotchi.sav", 0
mode_ecriture db "wb", 0
mode_lecture db "rb", 0

txt_clique_oeuf db "CLIQUE SUR L'OEUF !", 0
txt_cest_un db "C'EST UN ", 0
txt_excl db " !", 0
txt_donne_nom db "DONNE-LUI UN NOM :", 0
txt_ok db "OK", 0
txt_retour db "RETOUR", 0
txt_reveiller db "RÉVEILLER", 0
txt_zzz db "ZZZ", 0
txt_points db "...", 0
txt_malade db "MALADE !", 0
txt_malheureux db "MALHEUREUX...", 0
txt_carte db "CARTE D'IDENTITÉ", 0
txt_nom db "NOM: ", 0
txt_espece db "ESPECE: ", 0
txt_ne_le db "NÉ LE", 0
txt_age db "ÂGE: ", 0
txt_jours db " J", 0
txt_stade db "STADE: ", 0
txt_bebe db "BÉBÉ", 0
txt_adulte db "ADULTE", 0
txt_faim db "FAIM", 0
txt_sommeil db "SOMMEIL", 0
txt_humeur db "HUMEUR", 0
txt_proprete db "PROPRETÉ", 0
txt_sante db "SANTÉ: ", 0
txt_bonne db "BONNE", 0
txt_malade_etat db "MALADE", 0
txt_acheter db "ACHETER", 0
txt_donner db "DONNER", 0
txt_utiliser db "UTILISER", 0
txt_fois db "X ", 0
txt_etoile db "*", 0
txt_legende db "* = SON PRÉFÉRÉ", 0
txt_page_suivante db "PAGE 2 >", 0
txt_page_precedente db "< PAGE 1", 0
txt_vide db "INVENTAIRE VIDE", 0
txt_mettre_lit db "METTRE AU LIT", 0
txt_donner_cafe db "DONNER DU CAFÉ", 0
txt_cafe_stock db "CAFÉ EN STOCK: ", 0
txt_balle db "DONNER LA BALLE", 0
txt_caresser db "CARESSER", 0
txt_devine db "DEVINE LE MOT", 0
txt_pfc db "PIERRE-FEUILLE-CISEAUX", 0
txt_morpion db "MORPION", 0
txt_devine_titre db "DEVINE LE MOT", 0
txt_pfc_titre db "PIERRE FEUILLE CISEAUX", 0
txt_toi db "TOI: ", 0
txt_lui db "   LUI: ", 0
txt_erreurs db "ERREURS: ", 0
txt_sur6 db "/6", 0
txt_rejouer db "REJOUER", 0
txt_bravo db "BRAVO ! +3@", 0
txt_perdu db "PERDU !", 0
txt_nouvel_oeuf db "NOUVEL OEUF", 0
txt_a_toi db "A TOI DE JOUER !", 0
txt_morpion_gagne db "BRAVO ! +4@", 0
txt_morpion_perdu db "PERDU... IL A GAGNE", 0
txt_morpion_nul db "MATCH NUL !", 0
txt_manche_gagnee db "MANCHE GAGNEE !", 0
txt_manche_perdue db "MANCHE PERDUE !", 0
txt_egalite db "ÉGALITÉ !", 0
txt_pierre db "PIERRE", 0
txt_feuille db "FEUILLE", 0
txt_ciseaux db "CISEAUX", 0
txt_mort db " NOUS A QUITTÉS...", 0
txt_fuite db " S'EST ENFUI...", 0
txt_a_vecu db "IL A VECU ", 0
txt_conseil db "PRENDS MIEUX SOIN DU PROCHAIN !", 0
txt_continuer db "CONTINUER", 0
txt_nouvelle_partie db "NOUVELLE PARTIE", 0
txt_ecraser db "ÉCRASER LA PARTIE EN COURS ?", 0
txt_oui db "OUI", 0
txt_non db "NON", 0

msg_besoin_nom db "IL FAUT LUI DONNER UN NOM !", 0
msg_il_dort db "CHUT, IL DORT !", 0
msg_acheter_nourriture db "IL FAUT D'ABORD ACHETER À MANGER !", 0
msg_acheter_hygiene db "IL FAUT D'ABORD ACHETER DES PRODUITS !", 0
msg_pas_malade db "IL N'EST PAS MALADE !", 0
msg_acheter_remede db "IL FAUT ACHETER UN REMÈDE !", 0
msg_gueri db "IL EST GUÉRI !", 0
msg_achat_ok db "ACHAT EFFECTUE !", 0
msg_pas_assez db "PAS ASSEZ D'ARGENT !", 0
msg_plus_faim db "IL N'A PLUS FAIM !", 0
msg_miam db "MIAM MIAM !", 0
msg_favori db "SON PRÉFÉRÉ ! MIAM MIAM !", 0
msg_pas_sommeil db "IL N'A PAS SOMMEIL !", 0
msg_dort db "IL S'ENDORT...", 0
msg_acheter_cafe db "IL FAUT ACHETER DU CAFÉ !", 0
msg_cafe db "ÇA RÉVEILLE !", 0
msg_trouve db "TON ANIMAL VIENT DE TROUVER 1@ !", 0
msg_balle db "IL ADORE JOUER A LA BALLE !", 0
msg_caresse db "IL ADORE LES CARESSES !", 0
msg_comble db "IL EST COMBLE !", 0
msg_reveille db "IL EST RÉVEILLÉ !", 0
msg_reveille_seul db "IL S'EST RÉVEILLÉ !", 0
msg_malade db "OH NON, IL EST MALADE !", 0
msg_gagne db "BRAVO ! TU GAGNES 3@ !", 0
msg_perdu db "PERDU... ESSAIE ENCORE !", 0
msg_pfc_gagne db "MATCH GAGNE ! +3@", 0
msg_pfc_perdu db "MATCH PERDU...", 0
msg_morpion_gagne db "BRAVO, TU GAGNES 4@ !", 0
msg_morpion_defaite db "IL A GAGNE CETTE FOIS !", 0
msg_morpion_nul db "MATCH NUL ! +1@", 0
msg_caca db "OUPS, UN CACA !", 0
msg_beurk db "BEURK... C'EST NETTOYÉ !", 0
msg_propre db "IL EST TOUT PROPRE !", 0
msg_parfum db "IL SENT TRES BON !", 0
msg_deja_propre db "IL EST DEJA PROPRE !", 0
msg_grandi db "IL A GRANDI !", 0
msg_malheureux db "IL EST MALHEUREUX !", 0

lib_identite db "CARTE D'IDENTITÉ", 0
lib_besoins db "SES BESOINS", 0
lib_magasin db "MAGASIN", 0
lib_sommeil db "SOMMEIL", 0
lib_manger db "MANGER", 0
lib_jouer db "JOUER", 0
lib_soigner db "SOIGNER", 0
lib_hygiene db "HYGIÈNE", 0
lib_inventaire db "INVENTAIRE", 0

esp_chat db "CHAT", 0
esp_chien db "CHIEN", 0
esp_souris db "SOURIS", 0
esp_oiseau db "OISEAU", 0
esp_lapin db "LAPIN", 0

item_bonbons db "BONBONS", 0
item_croquettes db "CROQUETTES", 0
item_eau db "EAU", 0
item_cafe db "CAFÉ", 0
item_pommes db "POMMES", 0
item_raisin db "RAISIN", 0
item_carottes db "CAROTTES", 0
item_fromage db "FROMAGE", 0
item_remede db "REMÈDE", 0
item_eponge db "ÉPONGE", 0
item_savon db "SAVON", 0
item_parfum db "PARFUM", 0

prix_items db 2, 4, 1, 3, 3, 3, 2, 5, 8, 2, 4, 3
gains_items db 8, 40, 10, 0, 20, 20, 15, 30, 0, 0, 0, 0
gains_proprete db 15, 35, 10
favoris db 1, 1, 7, 5, 6
positions_cacas db 14, 48, 14, 72, 14, 96, 136, 104
etats_icones db ETAT_IDENTITE, ETAT_BESOINS, ETAT_MAGASIN, ETAT_SOMMEIL, ETAT_MANGER, ETAT_JOUER, ETAT_JEU, ETAT_HYGIENE, ETAT_INVENTAIRE
lignes_morpion db 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 3, 6, 1, 4, 7, 2, 5, 8, 0, 4, 8, 2, 4, 6

forme_aigu db 2, -2, 1, -1, 127
forme_grave db 0, -2, 1, -1, 127
forme_circ db 1, -2, 0, -1, 2, -1, 127
forme_trema db 0, -1, 2, -1, 127
forme_cedille db 1, 5, 0, 6, 127

son_clic dw 900, 25, 0, 0
son_achat dw 988, 60, 1319, 130, 0, 0
son_erreur dw 220, 160, 0, 0
son_miam dw 523, 50, 659, 50, 523, 50, 784, 90, 0, 0
son_reveil dw 523, 80, 659, 80, 784, 80, 1047, 180, 0, 0
son_dodo dw 784, 110, 659, 110, 523, 200, 0, 0
son_caresse dw 1047, 60, 1319, 110, 0, 0
son_victoire dw 523, 100, 659, 100, 784, 100, 1047, 260, 0, 0
son_defaite dw 392, 150, 330, 150, 262, 320, 0, 0
son_nettoye dw 1319, 40, 1568, 40, 1976, 90, 0, 0
son_caca dw 196, 120, 147, 200, 0, 0
son_gueri dw 659, 80, 784, 80, 988, 170, 0, 0
son_malade dw 330, 150, 277, 150, 233, 260, 0, 0
son_grandi dw 523, 90, 659, 90, 784, 90, 659, 90, 784, 90, 1047, 280, 0, 0
son_mort dw 330, 250, 294, 250, 262, 250, 196, 500, 0, 0

section .data

libelles_icones dq lib_identite, lib_besoins, lib_magasin, lib_sommeil, lib_manger, lib_jouer, lib_soigner, lib_hygiene, lib_inventaire
noms_animaux dq esp_chat, esp_chien, esp_souris, esp_oiseau, esp_lapin
noms_items dq item_bonbons, item_croquettes, item_eau, item_cafe, item_pommes, item_raisin, item_carottes, item_fromage, item_remede, item_eponge, item_savon, item_parfum
noms_pfc dq txt_pierre, txt_feuille, txt_ciseaux
textes_manche dq 0, txt_manche_gagnee, txt_manche_perdue, txt_egalite
textes_morpion dq txt_a_toi, txt_morpion_gagne, txt_morpion_perdu, txt_morpion_nul
sons dq son_clic, son_achat, son_erreur, son_miam, son_reveil, son_dodo, son_caresse, son_victoire, son_defaite, son_nettoye, son_caca, son_gueri, son_malade, son_grandi, son_mort
formes_accents dq 0, forme_aigu, forme_grave, forme_circ, forme_trema, forme_cedille
table_ecrans dq ecran_jeu, ecran_identite, ecran_besoins, ecran_magasin, ecran_sommeil, ecran_manger, ecran_jouer, ecran_inventaire, ecran_devine, ecran_pfc, ecran_morpion, ecran_hygiene

section .bss

fenetre resq 1
rendu resq 1
rect_tmp resd 4
evenement resb 64
souris_x resd 1
souris_y resd 1
clic_x resd 1
clic_y resd 1
clic_actif resd 1
touche resd 1
car_saisi resd 1
etat resd 1
clics_oeuf resd 1
nom_longueur resd 1
message_ptr resq 1
message_fin resd 1
dernier_tick resd 1
hors_ligne resd 1
coeur_fin resd 1
mange_fin resd 1
saut_debut resd 1
save_existe resd 1
titre_confirm resd 1
audio_dev resd 1
audio_n resd 1
spec_audio resb 32
caresse_prochaine resd 1
boutique_page resd 1
fin_cause resd 1
mot_index resd 1
mot_erreurs resd 1
mot_fin resd 1
mot_essayees resb 32
pfc_j resd 1
pfc_a resd 1
pfc_cj resd 1
pfc_ca resd 1
pfc_res resd 1
pfc_fin resd 1
morpion_g resb 12
morpion_fin resd 1
tampon_nombre resb 16
tampon_texte resb 64
tampon_date resb 16
tampon_lettre resb 4
tampon_audio resw CAPACITE_AUDIO

sauv_debut:
sauv_magic resd 1
animal resd 1
nom resb 16
naissance resq 1
derniere_maj resq 1
faim resd 1
sommeil resd 1
humeur resd 1
proprete resd 1
malade resd 1
dort resd 1
argent resd 1
stade resd 1
negligence resd 1
immunite resd 1
compteur_tick resd 1
delai_caca resd 1
nb_cacas resd 1
cacas resd 4
stock resd 12
sauv_fin:

TAILLE_SAUV equ sauv_fin - sauv_debut

section .text
global main

main:
    entree
    mov dword [souris_x], -1
    mov dword [souris_y], -1
    mov dword [mot_index], -1
    mov dword [saut_debut], -1000

    mov edi, 0x20
    call SDL_Init
    test eax, eax
    jnz .erreur_init

    xor edi, edi
    call time
    mov edi, eax
    call srand

    lea rdi, [titre]
    mov esi, 0x2FFF0000
    mov edx, 0x2FFF0000
    mov ecx, 640
    mov r8d, 576
    mov r9d, 4
    call SDL_CreateWindow
    test rax, rax
    jz .erreur_sdl
    mov [fenetre], rax

    mov rdi, rax
    mov esi, -1
    xor edx, edx
    call SDL_CreateRenderer
    test rax, rax
    jz .erreur_fenetre
    mov [rendu], rax

    mov rdi, rax
    mov esi, LARGEUR
    mov edx, HAUTEUR
    call SDL_RenderSetLogicalSize

    call SDL_StartTextInput

    mov edi, 0x10
    call SDL_InitSubSystem
    call ouvrir_audio

    call charger
    mov [save_existe], eax
    mov dword [etat], ETAT_TITRE
    call SDL_GetTicks
    mov [dernier_tick], eax

.boucle:
    mov dword [clic_actif], 0
    mov dword [touche], 0
    mov dword [car_saisi], 0

.evenements:
    lea rdi, [evenement]
    call SDL_PollEvent
    test eax, eax
    jz .logique
    mov eax, [evenement]
    cmp eax, 0x100
    je .quitter
    cmp eax, 0x400
    je .mouvement
    cmp eax, 0x401
    je .bouton
    cmp eax, 0x300
    je .touche_enfoncee
    cmp eax, 0x303
    je .texte_saisi
    jmp .evenements

.mouvement:
    mov eax, [evenement + 20]
    mov [souris_x], eax
    mov eax, [evenement + 24]
    mov [souris_y], eax
    jmp .evenements

.bouton:
    mov eax, [evenement + 20]
    mov [clic_x], eax
    mov [souris_x], eax
    mov eax, [evenement + 24]
    mov [clic_y], eax
    mov [souris_y], eax
    mov dword [clic_actif], 1
    jmp .evenements

.touche_enfoncee:
    mov eax, [evenement + 20]
    mov [touche], eax
    jmp .evenements

.texte_saisi:
    movzx eax, byte [evenement + 12]
    mov [car_saisi], eax
    jmp .evenements

.logique:
    mov eax, [etat]
    cmp eax, ETAT_JEU
    jb .dessin
    cmp eax, ETAT_FIN
    jae .dessin
    call SDL_GetTicks
    mov ecx, eax
    sub ecx, [dernier_tick]
    cmp ecx, INTERVALLE_TICK
    jb .dessin
    mov [dernier_tick], eax
    call tick_besoins
    call sauvegarder

.dessin:
    call dessiner_tout
    mov rdi, [rendu]
    call SDL_RenderPresent
    mov edi, 16
    call SDL_Delay
    jmp .boucle

.quitter:
    call sauvegarder
    mov rdi, [rendu]
    call SDL_DestroyRenderer
.erreur_fenetre:
    mov rdi, [fenetre]
    call SDL_DestroyWindow
.erreur_sdl:
    call SDL_Quit
    xor eax, eax
    jmp .retour

.erreur_init:
    mov eax, 1

.retour:
    sortie

couleur_blanc:
    entree
    mov rdi, [rendu]
    mov esi, 255
    mov edx, 255
    mov ecx, 255
    mov r8d, 255
    call SDL_SetRenderDrawColor
    sortie

couleur_noir:
    entree
    mov rdi, [rendu]
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    mov r8d, 255
    call SDL_SetRenderDrawColor
    sortie

remplir_rect:
    entree
    mov [rect_tmp], edi
    mov [rect_tmp + 4], esi
    mov [rect_tmp + 8], edx
    mov [rect_tmp + 12], ecx
    mov rdi, [rendu]
    lea rsi, [rect_tmp]
    call SDL_RenderFillRect
    sortie

contour_rect:
    entree
    mov [rect_tmp], edi
    mov [rect_tmp + 4], esi
    mov [rect_tmp + 8], edx
    mov [rect_tmp + 12], ecx
    mov rdi, [rendu]
    lea rsi, [rect_tmp]
    call SDL_RenderDrawRect
    sortie

dans_rect:
    xor eax, eax
    cmp r8d, edi
    jl .non
    add edi, edx
    cmp r8d, edi
    jge .non
    cmp r9d, esi
    jl .non
    add esi, ecx
    cmp r9d, esi
    jge .non
    mov eax, 1
.non:
    ret

souris_dans:
    mov r8d, [souris_x]
    mov r9d, [souris_y]
    jmp dans_rect

clic_dans:
    xor eax, eax
    cmp dword [clic_actif], 0
    je .non
    mov r8d, [clic_x]
    mov r9d, [clic_y]
    jmp dans_rect
.non:
    ret

longueur_texte:
    xor eax, eax
    xor ecx, ecx
.boucle:
    movzx edx, byte [rdi + rcx]
    test edx, edx
    jz .fin
    inc ecx
    and edx, 0xC0
    cmp edx, 0x80
    je .boucle
    inc eax
    jmp .boucle
.fin:
    ret

copier_chaine:
    mov al, [rsi]
    mov [rdi], al
    test al, al
    jz .fin
    inc rsi
    inc rdi
    jmp copier_chaine
.fin:
    ret

texte_nombre:
    mov eax, edi
    lea rsi, [tampon_nombre + 15]
    mov byte [rsi], 0
    mov ecx, 10
.chiffre:
    xor edx, edx
    div ecx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test eax, eax
    jnz .chiffre
    mov rax, rsi
    ret

ajuster:
    mov eax, [rdi]
    add eax, esi
    jns .positif
    xor eax, eax
.positif:
    cmp eax, 100
    jle .borne
    mov eax, 100
.borne:
    mov [rdi], eax
    ret

gagner_argent:
    add dword [argent], edi
    cmp dword [argent], 999
    jbe .fin
    mov dword [argent], 999
.fin:
    ret

stock_nourriture:
    lea rcx, [stock]
    xor eax, eax
    xor edx, edx
.boucle:
    cmp edx, 3
    je .suivant
    add eax, [rcx + rdx * 4]
.suivant:
    inc edx
    cmp edx, 8
    jb .boucle
    ret

stock_hygiene:
    lea rcx, [stock]
    mov eax, [rcx + 36]
    add eax, [rcx + 40]
    add eax, [rcx + 44]
    ret

sprite_animal_variante:
    mov eax, [stade]
    imul eax, NB_ANIMAUX
    add eax, [animal]
    imul eax, eax, 3
    add eax, edi
    shl eax, 5
    lea rdi, [sprites_animaux]
    add rdi, rax
    ret

sprite_animal:
    xor edi, edi
    jmp sprite_animal_variante

deux_chiffres:
    xor edx, edx
    mov ecx, 10
    div ecx
    add al, '0'
    mov [rdi], al
    add dl, '0'
    mov [rdi + 1], dl
    add rdi, 2
    ret

construire_date:
    mov r8d, esi
    mov r9d, edx
    mov eax, edi
    lea rdi, [tampon_date]
    call deux_chiffres
    mov byte [rdi], '/'
    inc rdi
    mov eax, r8d
    call deux_chiffres
    mov byte [rdi], '/'
    inc rdi
    mov eax, r9d
    xor edx, edx
    mov ecx, 100
    div ecx
    mov r10d, edx
    call deux_chiffres
    mov eax, r10d
    call deux_chiffres
    mov byte [rdi], 0
    ret

age_jours:
    entree
    xor edi, edi
    call time
    sub rax, [naissance]
    jns .positif
    xor eax, eax
.positif:
    xor edx, edx
    mov ecx, 86400
    div rcx
    sortie

mettre_a_jour_stade:
    entree
    call age_jours
    xor ebx, ebx
    cmp eax, JOURS_ADULTE
    jb .comparer
    mov ebx, 1
.comparer:
    cmp ebx, [stade]
    jbe .fin
    mov [stade], ebx
    lea rdi, [msg_grandi]
    mov esi, SON_GRANDI
    call poser_message_son
.fin:
    sortie

dessiner_texte:
    mov ecx, 1

dessiner_texte_echelle:
    entree
    mov [rsp], ecx
    mov r12, rdi
    mov r13d, esi
    mov r14d, edx

.caractere:
    movzx eax, byte [r12]
    test eax, eax
    jz .fin
    cmp eax, 0xC3
    jne .ascii
    inc r12
    movzx eax, byte [r12]
    test eax, eax
    jz .fin
    and eax, 0x3F
    cmp eax, 32
    jb .table
    sub eax, 32
.table:
    lea rcx, [accents]
    movzx edi, byte [rcx + rax * 2 + 1]
    movzx eax, byte [rcx + rax * 2]
    test eax, eax
    jz .espace
    mov r15d, eax
    mov esi, r13d
    mov edx, r14d
    mov ecx, [rsp]
    call dessiner_accent
    mov eax, r15d
    jmp .majuscule
.ascii:
    cmp eax, 'a'
    jb .majuscule
    cmp eax, 'z'
    ja .majuscule
    sub eax, 32
.majuscule:
    sub eax, 32
    cmp eax, 63
    ja .espace
    lea rcx, [police]
    lea eax, [rax + rax * 4]
    lea r15, [rcx + rax]
    xor ebx, ebx

.ligne:
    xor ebp, ebp

.colonne:
    movzx eax, byte [r15 + rbx]
    mov ecx, 2
    sub ecx, ebp
    shr eax, cl
    test eax, 1
    jz .pixel_suivant
    mov eax, ebp
    imul eax, [rsp]
    add eax, r13d
    mov [rect_tmp], eax
    mov eax, ebx
    imul eax, [rsp]
    add eax, r14d
    mov [rect_tmp + 4], eax
    mov eax, [rsp]
    mov [rect_tmp + 8], eax
    mov [rect_tmp + 12], eax
    mov rdi, [rendu]
    lea rsi, [rect_tmp]
    call SDL_RenderFillRect

.pixel_suivant:
    inc ebp
    cmp ebp, 3
    jb .colonne
    inc ebx
    cmp ebx, 5
    jb .ligne

.espace:
    mov eax, [rsp]
    shl eax, 2
    add r13d, eax
    inc r12
    jmp .caractere

.fin:
    sortie

dessiner_accent:
    entree
    test edi, edi
    jz .fin
    mov r12d, esi
    mov r13d, edx
    mov [rsp], ecx
    lea rax, [formes_accents]
    mov r14, [rax + rdi * 8]
.point:
    movsx rax, byte [r14]
    cmp rax, 127
    je .fin
    movsx rdx, byte [r14 + 1]
    add r14, 2
    imul eax, [rsp]
    add eax, r12d
    mov [rect_tmp], eax
    imul edx, [rsp]
    add edx, r13d
    mov [rect_tmp + 4], edx
    mov eax, [rsp]
    mov [rect_tmp + 8], eax
    mov [rect_tmp + 12], eax
    mov rdi, [rendu]
    lea rsi, [rect_tmp]
    call SDL_RenderFillRect
    jmp .point
.fin:
    sortie

texte_centre:
    entree
    mov r12, rdi
    mov r13d, edx
    call longueur_texte
    shl eax, 2
    mov esi, LARGEUR
    sub esi, eax
    sar esi, 1
    mov rdi, r12
    mov edx, r13d
    call dessiner_texte
    sortie

dessiner_nombre:
    entree
    mov r12d, esi
    mov r13d, edx
    call texte_nombre
    mov rdi, rax
    mov esi, r12d
    mov edx, r13d
    call dessiner_texte
    sortie

texte_x_nombre:
    entree
    call texte_nombre
    mov r12, rax
    lea rdi, [tampon_texte]
    lea rsi, [txt_fois]
    call copier_chaine
    mov rsi, r12
    call copier_chaine
    sortie

dessiner_sprite:
    entree
    mov r12, rdi
    mov r13d, esi
    mov r14d, edx
    mov ebp, ecx
    xor r15d, r15d

.pixel:
    mov eax, r15d
    shr eax, 4
    movzx ebx, word [r12 + rax * 2]
    mov ecx, r15d
    and ecx, 15
    mov eax, 15
    sub eax, ecx
    mov ecx, eax
    shr ebx, cl
    test ebx, 1
    jz .suivant
    mov eax, r15d
    and eax, 15
    imul eax, ebp
    add eax, r13d
    mov [rect_tmp], eax
    mov eax, r15d
    shr eax, 4
    imul eax, ebp
    add eax, r14d
    mov [rect_tmp + 4], eax
    mov [rect_tmp + 8], ebp
    mov [rect_tmp + 12], ebp
    mov rdi, [rendu]
    lea rsi, [rect_tmp]
    call SDL_RenderFillRect

.suivant:
    inc r15d
    cmp r15d, 256
    jb .pixel
    sortie

dessiner_barre:
    entree
    mov r12d, edi
    mov r13d, esi
    mov r14d, edx
    mov edx, 72
    mov ecx, 9
    call contour_rect
    mov eax, r14d
    imul eax, 70
    xor edx, edx
    mov ecx, 100
    div ecx
    test eax, eax
    jz .fin
    mov edx, eax
    lea edi, [r12 + 1]
    lea esi, [r13 + 1]
    mov ecx, 7
    call remplir_rect
.fin:
    sortie

bouton:
    entree
    mov r12d, edi
    mov r13d, esi
    mov r14d, edx
    mov r15d, ecx
    mov rbx, r8
    call souris_dans
    mov ebp, eax
    call couleur_blanc
    mov edi, r12d
    mov esi, r13d
    mov edx, r14d
    mov ecx, r15d
    test ebp, ebp
    jz .contour
    call remplir_rect
    call couleur_noir
    jmp .texte
.contour:
    call contour_rect
.texte:
    mov rdi, rbx
    call longueur_texte
    shl eax, 2
    mov esi, r14d
    sub esi, eax
    inc esi
    sar esi, 1
    add esi, r12d
    mov edx, r15d
    sub edx, 5
    shr edx, 1
    add edx, r13d
    mov rdi, rbx
    call dessiner_texte
    call couleur_blanc
    mov edi, r12d
    mov esi, r13d
    mov edx, r14d
    mov ecx, r15d
    call clic_dans
    test eax, eax
    jz .fin
    mov dword [clic_actif], 0
    mov edi, SON_CLIC
    call jouer_son
    mov eax, 1
.fin:
    sortie

bouton_retour_vers:
    entree
    mov ebx, edi
    mov edi, 112
    mov esi, 130
    mov edx, 44
    mov ecx, 11
    lea r8, [txt_retour]
    call bouton
    test eax, eax
    jz .fin
    mov [etat], ebx
.fin:
    sortie

bouton_retour:
    mov edi, ETAT_JEU
    jmp bouton_retour_vers

poser_message:
    entree
    mov [message_ptr], rdi
    call SDL_GetTicks
    add eax, DUREE_MESSAGE
    mov [message_fin], eax
    sortie

message_actif:
    entree
    xor ebx, ebx
    cmp qword [message_ptr], 0
    je .fin
    call SDL_GetTicks
    cmp eax, [message_fin]
    jae .fin
    mov ebx, 1
.fin:
    mov eax, ebx
    sortie

afficher_message:
    entree
    call message_actif
    test eax, eax
    jz .fin
    mov rdi, [message_ptr]
    mov esi, 4
    mov edx, 25
    call dessiner_texte
.fin:
    sortie

afficher_argent:
    entree
    mov edi, [argent]
    call texte_nombre
    lea rdi, [tampon_texte]
    mov rsi, rax
    call copier_chaine
    mov word [rdi], 0x40
    lea rdi, [tampon_texte]
    mov esi, 4
    mov edx, 134
    call dessiner_texte
    sortie

dessiner_tout:
    entree
    call couleur_noir
    mov rdi, [rendu]
    call SDL_RenderClear
    call couleur_blanc
    mov eax, [etat]
    cmp eax, ETAT_TITRE
    jne .pas_titre
    call ecran_titre
    jmp .fin
.pas_titre:
    cmp eax, ETAT_OEUF
    jne .pas_oeuf
    call ecran_oeuf
    jmp .fin
.pas_oeuf:
    cmp eax, ETAT_NOM
    jne .pas_nom
    call ecran_nom
    call afficher_message
    jmp .fin
.pas_nom:
    cmp eax, ETAT_FIN
    jne .jeu
    call ecran_fin
    jmp .fin
.jeu:
    call barre_icones
    mov eax, [etat]
    sub eax, ETAT_JEU
    lea rcx, [table_ecrans]
    call qword [rcx + rax * 8]
    call afficher_message
    call afficher_argent
.fin:
    sortie

ecran_oeuf:
    entree
    lea rdi, [sprite_oeuf]
    mov esi, [clics_oeuf]
    and esi, 1
    shl esi, 1
    add esi, 48
    mov edx, 36
    mov ecx, 4
    call dessiner_sprite
    call couleur_noir
    xor ebx, ebx
.fissure:
    cmp ebx, [clics_oeuf]
    jae .fin_fissures
    mov eax, ebx
    and eax, 1
    shl eax, 3
    add eax, 60
    mov edi, eax
    mov eax, ebx
    imul eax, 6
    add eax, 50
    mov esi, eax
    mov edx, 8
    mov ecx, 4
    call remplir_rect
    inc ebx
    jmp .fissure
.fin_fissures:
    call couleur_blanc
    lea rdi, [txt_clique_oeuf]
    mov edx, 118
    call texte_centre
    mov edi, 48
    mov esi, 36
    mov edx, 64
    mov ecx, 64
    call clic_dans
    test eax, eax
    jz .fin
    inc dword [clics_oeuf]
    mov edi, SON_CLIC
    call jouer_son
    cmp dword [clics_oeuf], 5
    jb .fin
    call eclosion
.fin:
    sortie

eclosion:
    entree
    lea rdi, [sauv_debut]
    xor eax, eax
    mov ecx, TAILLE_SAUV
    rep stosb
    mov dword [sauv_magic], MAGIC
    call rand
    xor edx, edx
    mov ecx, NB_ANIMAUX
    div ecx
    mov [animal], edx
    xor edi, edi
    call time
    mov [naissance], rax
    mov dword [faim], 70
    mov dword [sommeil], 80
    mov dword [humeur], 70
    mov dword [proprete], 80
    mov dword [argent], 10
    mov dword [nom_longueur], 0
    mov dword [etat], ETAT_NOM
    mov edi, SON_GRANDI
    call jouer_son
    sortie

nouvelle_partie:
    mov dword [clics_oeuf], 0
    mov dword [nom_longueur], 0
    mov dword [boutique_page], 0
    mov dword [etat], ETAT_OEUF
    ret

effacer_sauvegarde:
    entree
    lea rdi, [nom_fichier]
    call remove
    sortie

ecran_nom:
    entree
    call sprite_animal
    mov esi, 56
    mov edx, 32
    mov ecx, 3
    call dessiner_sprite

    lea rdi, [tampon_texte]
    lea rsi, [txt_cest_un]
    call copier_chaine
    mov eax, [animal]
    lea rcx, [noms_animaux]
    mov rsi, [rcx + rax * 8]
    call copier_chaine
    lea rsi, [txt_excl]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 86
    call texte_centre

    lea rdi, [txt_donne_nom]
    mov edx, 98
    call texte_centre

    lea rdi, [tampon_texte]
    lea rsi, [nom]
    call copier_chaine
    mov r12, rdi
    call SDL_GetTicks
    test eax, 0x200
    jz .sans_curseur
    mov word [r12], 0x5F
.sans_curseur:
    lea rdi, [tampon_texte]
    mov edx, 110
    call texte_centre

    mov eax, [touche]
    cmp eax, 8
    jne .pas_effacer
    cmp dword [nom_longueur], 0
    je .pas_effacer
    dec dword [nom_longueur]
    mov ecx, [nom_longueur]
    lea rdx, [nom]
    mov byte [rdx + rcx], 0
.pas_effacer:
    cmp eax, 13
    je .valider

    mov eax, [car_saisi]
    cmp eax, 'a'
    jb .majuscule
    cmp eax, 'z'
    ja .majuscule
    sub eax, 32
.majuscule:
    cmp eax, 'A'
    jb .chiffre
    cmp eax, 'Z'
    jbe .ajouter
.chiffre:
    cmp eax, '0'
    jb .tiret
    cmp eax, '9'
    jbe .ajouter
.tiret:
    cmp eax, '-'
    jne .bouton_ok
.ajouter:
    mov ecx, [nom_longueur]
    cmp ecx, 10
    jae .bouton_ok
    lea rdx, [nom]
    mov [rdx + rcx], al
    mov byte [rdx + rcx + 1], 0
    inc dword [nom_longueur]

.bouton_ok:
    mov edi, 56
    mov esi, 123
    mov edx, 48
    mov ecx, 13
    lea r8, [txt_ok]
    call bouton
    test eax, eax
    jnz .valider
    jmp .fin

.valider:
    cmp dword [nom_longueur], 0
    jne .nom_valide
    lea rdi, [msg_besoin_nom]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.nom_valide:
    mov dword [etat], ETAT_JEU
    call SDL_GetTicks
    mov [dernier_tick], eax
    call sauvegarder
.fin:
    sortie

barre_icones:
    entree
    xor ebx, ebx
.icone:
    imul r12d, ebx, 17
    add r12d, 3
    mov edi, r12d
    xor esi, esi
    mov edx, 17
    mov ecx, 20
    call souris_dans
    mov r13d, eax
    test r13d, r13d
    jz .dessin_icone
    mov edi, r12d
    mov esi, 1
    mov edx, 17
    mov ecx, 18
    call remplir_rect
    call couleur_noir
.dessin_icone:
    lea rdi, [sprites_icones]
    mov eax, ebx
    shl eax, 5
    add rdi, rax
    mov esi, r12d
    mov edx, 2
    mov ecx, 1
    call dessiner_sprite
    call couleur_blanc
    test r13d, r13d
    jz .suivant
    call message_actif
    test eax, eax
    jnz .clic
    mov eax, ebx
    lea rcx, [libelles_icones]
    mov rdi, [rcx + rax * 8]
    mov esi, 4
    mov edx, 25
    call dessiner_texte
.clic:
    mov edi, r12d
    xor esi, esi
    mov edx, 17
    mov ecx, 20
    call clic_dans
    test eax, eax
    jz .suivant
    mov dword [clic_actif], 0
    mov edi, SON_CLIC
    call jouer_son
    mov edi, ebx
    call action_icone
.suivant:
    inc ebx
    cmp ebx, 9
    jb .icone
    xor edi, edi
    mov esi, 21
    mov edx, LARGEUR
    mov ecx, 1
    call remplir_rect
    sortie

action_icone:
    entree
    mov ebx, edi
    cmp ebx, 3
    jb .libre
    cmp ebx, 7
    ja .libre
    cmp dword [dort], 0
    je .libre
    lea rdi, [msg_il_dort]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.libre:
    cmp ebx, 4
    je .manger
    cmp ebx, 6
    je .soigner
    cmp ebx, 7
    je .hygiene
    lea rcx, [etats_icones]
    movzx eax, byte [rcx + rbx]
    mov [etat], eax
    jmp .fin
.manger:
    call stock_nourriture
    test eax, eax
    jnz .vers_manger
    lea rdi, [msg_acheter_nourriture]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.vers_manger:
    mov dword [etat], ETAT_MANGER
    jmp .fin
.hygiene:
    call stock_hygiene
    test eax, eax
    jnz .vers_hygiene
    lea rdi, [msg_acheter_hygiene]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.vers_hygiene:
    mov dword [etat], ETAT_HYGIENE
    jmp .fin
.soigner:
    call soigner
.fin:
    sortie

soigner:
    entree
    cmp dword [malade], 0
    jne .malade
    lea rdi, [msg_pas_malade]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.malade:
    cmp dword [stock + 32], 0
    jne .remede
    lea rdi, [msg_acheter_remede]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.remede:
    dec dword [stock + 32]
    mov dword [malade], 0
    mov dword [immunite], IMMUNITE
    call declencher_saut
    mov dword [etat], ETAT_JEU
    lea rdi, [msg_gueri]
    mov esi, SON_GUERI
    call poser_message_son
.fin:
    sortie

ramasser_caca:
    entree
    lea rcx, [cacas]
    mov dword [rcx + rdi * 4], 0
    cmp dword [nb_cacas], 0
    jle .propre
    dec dword [nb_cacas]
.propre:
    lea rdi, [proprete]
    mov esi, 8
    call ajuster
    lea rdi, [msg_beurk]
    mov esi, SON_NETTOYE
    call poser_message_son
    sortie

caresser:
    entree
    cmp dword [dort], 0
    je .eveille
    lea rdi, [msg_il_dort]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.eveille:
    call SDL_GetTicks
    cmp eax, [caresse_prochaine]
    jb .fin
    mov ebx, eax
    add eax, 700
    mov [caresse_prochaine], eax
    add ebx, 1000
    mov [coeur_fin], ebx
    cmp dword [humeur], 100
    jl .caresse
    lea rdi, [msg_comble]
    mov esi, SON_CARESSE
    call poser_message_son
    jmp .fin
.caresse:
    lea rdi, [humeur]
    mov esi, 4
    call ajuster
    call declencher_saut
    lea rdi, [msg_caresse]
    mov esi, SON_CARESSE
    call poser_message_son
.fin:
    sortie

ecran_jeu:
    entree
    call SDL_GetTicks
    mov r15d, eax
    shr eax, 9
    and eax, 1
    shl eax, 1
    mov r12d, eax

    mov eax, r15d
    sub eax, [saut_debut]
    cmp eax, 700
    jae .pas_saut
    mov ecx, 700
    sub ecx, eax
    imul eax, ecx
    imul eax, 56
    xor edx, edx
    mov ecx, 490000
    div ecx
    sub r12d, eax
.pas_saut:

    xor edi, edi
    cmp dword [dort], 0
    je .pas_dort
    mov edi, 1
    jmp .variante
.pas_dort:
    cmp r15d, [mange_fin]
    jae .pas_mange
    test r15d, 0x100
    jz .variante
    mov edi, 2
    jmp .variante
.pas_mange:
    mov eax, r15d
    shr eax, 8
    and eax, 15
    jnz .variante
    mov edi, 1
.variante:
    call sprite_animal_variante
    mov esi, 48
    mov edx, 44
    add edx, r12d
    mov ecx, 4
    call dessiner_sprite

    xor ebx, ebx
.caca:
    lea rcx, [cacas]
    cmp dword [rcx + rbx * 4], 0
    je .caca_suivant
    lea rcx, [positions_cacas]
    movzx r13d, byte [rcx + rbx * 2]
    movzx r14d, byte [rcx + rbx * 2 + 1]
    lea rdi, [sprite_caca]
    mov esi, r13d
    mov edx, r14d
    mov ecx, 1
    call dessiner_sprite
    mov edi, r13d
    mov esi, r14d
    mov edx, 16
    mov ecx, 16
    call clic_dans
    test eax, eax
    jz .caca_suivant
    mov dword [clic_actif], 0
    mov edi, ebx
    call ramasser_caca
.caca_suivant:
    inc ebx
    cmp ebx, MAX_CACAS
    jb .caca

    mov edi, 48
    mov esi, 44
    mov edx, 64
    mov ecx, 64
    call clic_dans
    test eax, eax
    jz .signes
    mov dword [clic_actif], 0
    call caresser

.signes:
    call SDL_GetTicks
    cmp eax, [coeur_fin]
    jae .sans_coeur
    lea rdi, [sprite_coeur]
    mov esi, 72
    mov edx, 30
    mov ecx, 1
    call dessiner_sprite
.sans_coeur:
    cmp dword [dort], 0
    jne .zzz
    cmp dword [sommeil], 30
    jge .pas_zzz
.zzz:
    lea rdi, [txt_zzz]
    mov esi, 118
    mov edx, 46
    add edx, r12d
    call dessiner_texte
.pas_zzz:
    cmp dword [humeur], 30
    jge .pas_humeur
    lea rdi, [txt_points]
    mov esi, 118
    mov edx, 56
    add edx, r12d
    call dessiner_texte
.pas_humeur:
    cmp dword [faim], 30
    jge .pas_faim
    lea rdi, [sprite_spirale]
    mov esi, 118
    mov edx, 64
    add edx, r12d
    mov ecx, 1
    call dessiner_sprite
.pas_faim:
    cmp dword [proprete], 30
    jge .pas_sale
    lea rdi, [sprite_odeur]
    mov esi, 118
    mov edx, 82
    add edx, r12d
    mov ecx, 1
    call dessiner_sprite
.pas_sale:

    lea rdi, [nom]
    mov edx, 110
    call texte_centre

    call SDL_GetTicks
    mov ebx, eax
    cmp dword [malade], 0
    je .pas_malade
    test ebx, 0x200
    jz .pas_malade
    lea rdi, [txt_malade]
    mov edx, 117
    call texte_centre
.pas_malade:
    cmp dword [negligence], SEUIL_MALHEUREUX
    jb .pas_triste
    test ebx, 0x200
    jnz .pas_triste
    lea rdi, [txt_malheureux]
    mov edx, 117
    call texte_centre
.pas_triste:
    cmp dword [dort], 0
    je .fin
    mov edi, 50
    mov esi, 125
    mov edx, 60
    mov ecx, 12
    lea r8, [txt_reveiller]
    call bouton
    test eax, eax
    jz .fin
    mov dword [dort], 0
    lea rdi, [msg_reveille]
    mov esi, SON_REVEIL
    call poser_message_son
.fin:
    sortie

ecran_identite:
    entree
    mov edi, 8
    mov esi, 32
    mov edx, 144
    mov ecx, 92
    call contour_rect
    lea rdi, [txt_carte]
    mov edx, 36
    call texte_centre
    mov edi, 14
    mov esi, 46
    mov edx, 52
    mov ecx, 52
    call contour_rect
    call sprite_animal
    mov esi, 16
    mov edx, 48
    mov ecx, 3
    call dessiner_sprite

    lea rdi, [tampon_texte]
    lea rsi, [txt_nom]
    call copier_chaine
    lea rsi, [nom]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov esi, 74
    mov edx, 48
    call dessiner_texte

    lea rdi, [tampon_texte]
    lea rsi, [txt_espece]
    call copier_chaine
    mov eax, [animal]
    lea rcx, [noms_animaux]
    mov rsi, [rcx + rax * 8]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov esi, 74
    mov edx, 58
    call dessiner_texte

    lea rdi, [txt_ne_le]
    mov esi, 74
    mov edx, 70
    call dessiner_texte
    lea rdi, [naissance]
    call localtime
    mov edi, [rax + 12]
    mov esi, [rax + 16]
    inc esi
    mov edx, [rax + 20]
    add edx, 1900
    call construire_date
    lea rdi, [tampon_date]
    mov esi, 74
    mov edx, 78
    call dessiner_texte

    call age_jours
    mov edi, eax
    call texte_nombre
    mov r12, rax
    lea rdi, [tampon_texte]
    lea rsi, [txt_age]
    call copier_chaine
    mov rsi, r12
    call copier_chaine
    lea rsi, [txt_jours]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov esi, 74
    mov edx, 90
    call dessiner_texte

    lea rdi, [tampon_texte]
    lea rsi, [txt_stade]
    call copier_chaine
    lea rsi, [txt_bebe]
    cmp dword [stade], 0
    je .stade
    lea rsi, [txt_adulte]
.stade:
    call copier_chaine
    lea rdi, [tampon_texte]
    mov esi, 74
    mov edx, 100
    call dessiner_texte

    call bouton_retour
    sortie

ligne_besoin:
    entree
    mov r12d, esi
    mov r13d, edx
    mov esi, 6
    lea edx, [r12 + 2]
    call dessiner_texte
    mov edi, 46
    mov esi, r12d
    mov edx, r13d
    call dessiner_barre
    mov edi, r13d
    mov esi, 124
    lea edx, [r12 + 2]
    call dessiner_nombre
    sortie

ecran_besoins:
    entree
    lea rdi, [txt_faim]
    mov esi, 38
    mov edx, [faim]
    call ligne_besoin
    lea rdi, [txt_sommeil]
    mov esi, 54
    mov edx, [sommeil]
    call ligne_besoin
    lea rdi, [txt_humeur]
    mov esi, 70
    mov edx, [humeur]
    call ligne_besoin
    lea rdi, [txt_proprete]
    mov esi, 86
    mov edx, [proprete]
    call ligne_besoin

    lea rdi, [tampon_texte]
    lea rsi, [txt_sante]
    call copier_chaine
    lea rsi, [txt_bonne]
    cmp dword [malade], 0
    je .sante
    lea rsi, [txt_malade_etat]
.sante:
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 106
    call texte_centre

    cmp dword [negligence], SEUIL_MALHEUREUX
    jb .fin
    lea rdi, [txt_malheureux]
    mov edx, 116
    call texte_centre
.fin:
    call bouton_retour
    sortie

ecran_magasin:
    entree
    xor ebx, ebx
.ligne:
    mov eax, [boutique_page]
    imul eax, 6
    add eax, ebx
    mov r14d, eax
    mov eax, ebx
    imul eax, 12
    add eax, 34
    mov r12d, eax

    mov eax, [animal]
    lea rcx, [favoris]
    movzx eax, byte [rcx + rax]
    cmp eax, r14d
    jne .pas_favori
    lea rdi, [txt_etoile]
    mov esi, 1
    lea edx, [r12 + 1]
    call dessiner_texte
.pas_favori:
    lea rcx, [noms_items]
    mov rdi, [rcx + r14 * 8]
    mov esi, 6
    lea edx, [r12 + 1]
    call dessiner_texte

    lea rcx, [prix_items]
    movzx edi, byte [rcx + r14]
    call texte_nombre
    lea rdi, [tampon_texte]
    mov rsi, rax
    call copier_chaine
    mov word [rdi], 0x40
    lea rdi, [tampon_texte]
    mov esi, 92
    lea edx, [r12 + 1]
    call dessiner_texte

    mov edi, 116
    lea esi, [r12 - 1]
    mov edx, 40
    mov ecx, 9
    lea r8, [txt_acheter]
    call bouton
    test eax, eax
    jz .suivant
    mov edi, r14d
    call acheter
.suivant:
    inc ebx
    cmp ebx, 6
    jb .ligne

    lea rdi, [txt_legende]
    mov edx, 112
    call texte_centre

    mov edi, 50
    mov esi, 130
    mov edx, 56
    mov ecx, 11
    lea r8, [txt_page_suivante]
    cmp dword [boutique_page], 0
    je .bouton_page
    lea r8, [txt_page_precedente]
.bouton_page:
    call bouton
    test eax, eax
    jz .fin
    xor dword [boutique_page], 1
.fin:
    call bouton_retour
    sortie

acheter:
    entree
    lea rcx, [prix_items]
    movzx eax, byte [rcx + rdi]
    cmp dword [argent], eax
    jb .pas_assez
    sub dword [argent], eax
    lea rcx, [stock]
    inc dword [rcx + rdi * 4]
    lea rdi, [msg_achat_ok]
    mov esi, SON_ACHAT
    call poser_message_son
    jmp .fin
.pas_assez:
    lea rdi, [msg_pas_assez]
    mov esi, SON_ERREUR
    call poser_message_son
.fin:
    sortie

ecran_inventaire:
    entree
    xor ebx, ebx
    xor r14d, r14d
.ligne:
    mov eax, ebx
    mov r12d, 4
    cmp eax, 6
    jb .colonne
    sub eax, 6
    mov r12d, 84
.colonne:
    imul eax, 10
    add eax, 34
    mov r13d, eax
    lea rcx, [noms_items]
    mov rdi, [rcx + rbx * 8]
    mov esi, r12d
    lea edx, [r13 + 1]
    call dessiner_texte
    lea rcx, [stock]
    mov edi, [rcx + rbx * 4]
    add r14d, edi
    call texte_x_nombre
    lea rdi, [tampon_texte]
    lea esi, [r12 + 46]
    lea edx, [r13 + 1]
    call dessiner_texte
    inc ebx
    cmp ebx, NB_ITEMS
    jb .ligne
    test r14d, r14d
    jnz .fin
    lea rdi, [txt_vide]
    mov edx, 112
    call texte_centre
.fin:
    call bouton_retour
    sortie

ecran_manger:
    entree
    xor ebx, ebx
    mov r12d, 34
.item:
    cmp ebx, 3
    je .suivant

    mov eax, [animal]
    lea rcx, [favoris]
    movzx eax, byte [rcx + rax]
    cmp eax, ebx
    jne .pas_favori
    lea rdi, [txt_etoile]
    mov esi, 1
    lea edx, [r12 + 1]
    call dessiner_texte
.pas_favori:
    lea rcx, [noms_items]
    mov rdi, [rcx + rbx * 8]
    mov esi, 6
    lea edx, [r12 + 1]
    call dessiner_texte

    lea rcx, [stock]
    mov edi, [rcx + rbx * 4]
    call texte_x_nombre
    lea rdi, [tampon_texte]
    mov esi, 90
    lea edx, [r12 + 1]
    call dessiner_texte

    lea rcx, [stock]
    cmp dword [rcx + rbx * 4], 0
    je .ligne_suivante
    mov edi, 116
    lea esi, [r12 - 1]
    mov edx, 40
    mov ecx, 9
    lea r8, [txt_donner]
    call bouton
    test eax, eax
    jz .ligne_suivante
    mov edi, ebx
    call nourrir
.ligne_suivante:
    add r12d, 10
.suivant:
    inc ebx
    cmp ebx, 8
    jb .item
    lea rdi, [txt_legende]
    mov edx, 118
    call texte_centre
    call bouton_retour
    sortie

nourrir:
    entree
    mov ebx, edi
    cmp dword [faim], 100
    jl .manger
    lea rdi, [msg_plus_faim]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.manger:
    lea rcx, [stock]
    dec dword [rcx + rbx * 4]
    lea rcx, [gains_items]
    movzx r12d, byte [rcx + rbx]
    mov eax, [animal]
    lea rcx, [favoris]
    movzx eax, byte [rcx + rax]
    cmp eax, ebx
    jne .normal
    shl r12d, 1
    lea rdi, [humeur]
    mov esi, 5
    call ajuster
    lea rdi, [msg_favori]
    jmp .appliquer
.normal:
    lea rdi, [msg_miam]
.appliquer:
    mov r13, rdi
    lea rdi, [faim]
    mov esi, r12d
    call ajuster
    mov rdi, r13
    mov esi, SON_MIAM
    call poser_message_son
    call SDL_GetTicks
    add eax, 1600
    mov [mange_fin], eax
    mov dword [etat], ETAT_JEU
    cmp dword [delai_caca], 0
    jg .fin
    call rand
    test eax, 1
    jz .fin
    mov dword [delai_caca], 5
.fin:
    sortie

ecran_sommeil:
    entree
    mov edi, 30
    mov esi, 46
    mov edx, 100
    mov ecx, 18
    lea r8, [txt_mettre_lit]
    call bouton
    test eax, eax
    jz .cafe
    call coucher
.cafe:
    mov edi, 30
    mov esi, 72
    mov edx, 100
    mov ecx, 18
    lea r8, [txt_donner_cafe]
    call bouton
    test eax, eax
    jz .stock
    call donner_cafe
.stock:
    mov edi, [stock + 12]
    call texte_nombre
    mov r12, rax
    lea rdi, [tampon_texte]
    lea rsi, [txt_cafe_stock]
    call copier_chaine
    mov rsi, r12
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 98
    call texte_centre
    call bouton_retour
    sortie

coucher:
    entree
    cmp dword [sommeil], 90
    jl .lit
    lea rdi, [msg_pas_sommeil]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.lit:
    mov dword [dort], 1
    mov dword [etat], ETAT_JEU
    lea rdi, [msg_dort]
    mov esi, SON_DODO
    call poser_message_son
.fin:
    sortie

donner_cafe:
    entree
    cmp dword [stock + 12], 0
    jne .cafe
    lea rdi, [msg_acheter_cafe]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.cafe:
    dec dword [stock + 12]
    lea rdi, [sommeil]
    mov esi, 15
    call ajuster
    lea rdi, [msg_cafe]
    mov esi, SON_MIAM
    call poser_message_son
.fin:
    sortie

ecran_hygiene:
    entree
    xor ebx, ebx
    mov r12d, 40
.produit:
    lea r13d, [rbx + 9]
    lea rcx, [noms_items]
    mov rdi, [rcx + r13 * 8]
    mov esi, 6
    lea edx, [r12 + 1]
    call dessiner_texte
    lea rcx, [stock]
    mov edi, [rcx + r13 * 4]
    call texte_x_nombre
    lea rdi, [tampon_texte]
    mov esi, 60
    lea edx, [r12 + 1]
    call dessiner_texte
    lea rcx, [stock]
    cmp dword [rcx + r13 * 4], 0
    je .suivant
    mov edi, 104
    lea esi, [r12 - 1]
    mov edx, 52
    mov ecx, 9
    lea r8, [txt_utiliser]
    call bouton
    test eax, eax
    jz .suivant
    mov edi, r13d
    call nettoyer
.suivant:
    add r12d, 14
    inc ebx
    cmp ebx, 3
    jb .produit
    lea rdi, [txt_proprete]
    mov esi, 92
    mov edx, [proprete]
    call ligne_besoin
    call bouton_retour
    sortie

nettoyer:
    entree
    mov ebx, edi
    cmp dword [proprete], 100
    jl .ok
    lea rdi, [msg_deja_propre]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.ok:
    lea rcx, [stock]
    dec dword [rcx + rbx * 4]
    lea rcx, [gains_proprete]
    movzx esi, byte [rcx + rbx - 9]
    lea rdi, [proprete]
    call ajuster
    cmp ebx, 11
    jne .message
    lea rdi, [humeur]
    mov esi, 5
    call ajuster
    call declencher_saut
    lea rdi, [msg_parfum]
    mov esi, SON_NETTOYE
    call poser_message_son
    jmp .fin
.message:
    call declencher_saut
    lea rdi, [msg_propre]
    mov esi, SON_NETTOYE
    call poser_message_son
.fin:
    sortie

ecran_jouer:
    entree
    mov edi, 20
    mov esi, 34
    mov edx, 120
    mov ecx, 14
    lea r8, [txt_balle]
    call bouton
    test eax, eax
    jz .caresse
    call jouer_balle
.caresse:
    mov edi, 20
    mov esi, 51
    mov edx, 120
    mov ecx, 14
    lea r8, [txt_caresser]
    call bouton
    test eax, eax
    jz .mot
    mov dword [etat], ETAT_JEU
    call caresser
.mot:
    mov edi, 20
    mov esi, 68
    mov edx, 120
    mov ecx, 14
    lea r8, [txt_devine]
    call bouton
    test eax, eax
    jz .pfc
    call initialiser_mot
    mov dword [etat], ETAT_DEVINE
.pfc:
    mov edi, 20
    mov esi, 85
    mov edx, 120
    mov ecx, 14
    lea r8, [txt_pfc]
    call bouton
    test eax, eax
    jz .morpion
    call initialiser_pfc
    mov dword [etat], ETAT_PFC
.morpion:
    mov edi, 20
    mov esi, 102
    mov edx, 120
    mov ecx, 14
    lea r8, [txt_morpion]
    call bouton
    test eax, eax
    jz .fin
    call initialiser_morpion
    mov dword [etat], ETAT_MORPION
.fin:
    call bouton_retour
    sortie

jouer_balle:
    entree
    lea rdi, [humeur]
    mov esi, 20
    call ajuster
    call declencher_saut
    call rand
    xor edx, edx
    mov ecx, 3
    div ecx
    test edx, edx
    jnz .simple
    mov edi, 1
    call gagner_argent
    lea rdi, [msg_trouve]
    mov esi, SON_ACHAT
    call poser_message_son
    jmp .fin
.simple:
    lea rdi, [msg_balle]
    mov esi, SON_CARESSE
    call poser_message_son
.fin:
    sortie

initialiser_mot:
    entree
.tirage:
    call rand
    xor edx, edx
    mov ecx, NB_MOTS
    div ecx
    cmp edx, [mot_index]
    je .tirage
    mov [mot_index], edx
    mov dword [mot_erreurs], 0
    mov dword [mot_fin], 0
    lea rdi, [mot_essayees]
    xor eax, eax
    mov ecx, 32
    rep stosb
    sortie

essayer_lettre:
    entree
    mov ebx, edi
    sub ebx, 'A'
    lea rcx, [mot_essayees]
    cmp byte [rcx + rbx], 0
    jne .fin
    mov byte [rcx + rbx], 1
    mov eax, [mot_index]
    lea rcx, [mots]
    mov rsi, [rcx + rax * 8]
    xor r12d, r12d
.cherche:
    movzx eax, byte [rsi]
    test eax, eax
    jz .fin_cherche
    lea ecx, [rbx + 'A']
    cmp eax, ecx
    jne .suite
    mov r12d, 1
.suite:
    inc rsi
    jmp .cherche
.fin_cherche:
    test r12d, r12d
    jnz .verifier
    inc dword [mot_erreurs]
.verifier:
    cmp dword [mot_erreurs], 6
    jb .test_victoire
    mov dword [mot_fin], 2
    lea rdi, [humeur]
    mov esi, 10
    call ajuster
    lea rdi, [msg_perdu]
    mov esi, SON_DEFAITE
    call poser_message_son
    jmp .fin
.test_victoire:
    mov eax, [mot_index]
    lea rcx, [mots]
    mov rsi, [rcx + rax * 8]
    lea rdx, [mot_essayees]
.test:
    movzx eax, byte [rsi]
    test eax, eax
    jz .victoire
    cmp byte [rdx + rax - 'A'], 0
    je .fin
    inc rsi
    jmp .test
.victoire:
    call declencher_saut
    mov dword [mot_fin], 1
    mov edi, 3
    call gagner_argent
    lea rdi, [humeur]
    mov esi, 30
    call ajuster
    lea rdi, [msg_gagne]
    mov esi, SON_VICTOIRE
    call poser_message_son
.fin:
    sortie

ecran_devine:
    entree
    lea rdi, [txt_devine_titre]
    mov edx, 34
    call texte_centre

    mov eax, [mot_index]
    lea rcx, [mots]
    mov r13, [rcx + rax * 8]
    lea rdi, [tampon_texte]
.lettre_aff:
    movzx eax, byte [r13]
    test eax, eax
    jz .fin_aff
    cmp dword [mot_fin], 0
    jne .montrer
    lea rcx, [mot_essayees]
    cmp byte [rcx + rax - 'A'], 0
    jne .montrer
    mov eax, '_'
.montrer:
    mov [rdi], al
    mov byte [rdi + 1], ' '
    add rdi, 2
    inc r13
    jmp .lettre_aff
.fin_aff:
    mov byte [rdi - 1], 0
    lea rdi, [tampon_texte]
    mov edx, 50
    call texte_centre

    lea rdi, [tampon_texte]
    lea rsi, [txt_erreurs]
    call copier_chaine
    mov r14, rdi
    mov edi, [mot_erreurs]
    call texte_nombre
    mov rdi, r14
    mov rsi, rax
    call copier_chaine
    lea rsi, [txt_sur6]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 64
    call texte_centre

    cmp dword [mot_fin], 0
    jne .resultat

    mov eax, [car_saisi]
    cmp eax, 'a'
    jb .majuscule
    cmp eax, 'z'
    ja .majuscule
    sub eax, 32
.majuscule:
    cmp eax, 'A'
    jb .clavier
    cmp eax, 'Z'
    ja .clavier
    mov edi, eax
    call essayer_lettre

.clavier:
    cmp dword [mot_fin], 0
    jne .resultat
    xor ebx, ebx
.touche:
    lea rcx, [mot_essayees]
    cmp byte [rcx + rbx], 0
    jne .touche_suivante
    mov eax, ebx
    xor edx, edx
    mov ecx, 9
    div ecx
    imul edx, 16
    add edx, 8
    imul eax, 13
    add eax, 80
    mov r12d, edx
    mov r13d, eax
    lea eax, [rbx + 'A']
    mov [tampon_lettre], al
    mov byte [tampon_lettre + 1], 0
    mov edi, r12d
    mov esi, r13d
    mov edx, 15
    mov ecx, 12
    lea r8, [tampon_lettre]
    call bouton
    test eax, eax
    jz .touche_suivante
    lea edi, [rbx + 'A']
    call essayer_lettre
.touche_suivante:
    inc ebx
    cmp ebx, 26
    jb .touche
    jmp .fin

.resultat:
    cmp dword [mot_fin], 1
    jne .perdu
    lea rdi, [txt_bravo]
    jmp .texte_resultat
.perdu:
    lea rdi, [txt_perdu]
.texte_resultat:
    mov edx, 88
    call texte_centre
    mov edi, 50
    mov esi, 104
    mov edx, 60
    mov ecx, 13
    lea r8, [txt_rejouer]
    call bouton
    test eax, eax
    jz .fin
    call initialiser_mot
.fin:
    mov edi, ETAT_JOUER
    call bouton_retour_vers
    sortie

initialiser_pfc:
    mov dword [pfc_j], 0
    mov dword [pfc_a], 0
    mov dword [pfc_cj], 0
    mov dword [pfc_ca], 0
    mov dword [pfc_res], 0
    mov dword [pfc_fin], 0
    ret

jouer_pfc:
    entree
    mov ebx, edi
    call rand
    xor edx, edx
    mov ecx, 3
    div ecx
    mov [pfc_cj], ebx
    mov [pfc_ca], edx
    cmp edx, ebx
    jne .different
    mov dword [pfc_res], 3
    jmp .fin
.different:
    mov eax, ebx
    sub eax, edx
    add eax, 3
    xor edx, edx
    mov ecx, 3
    div ecx
    cmp edx, 1
    jne .manche_perdue
    mov dword [pfc_res], 1
    inc dword [pfc_j]
    jmp .verifier
.manche_perdue:
    mov dword [pfc_res], 2
    inc dword [pfc_a]
.verifier:
    cmp dword [pfc_j], 3
    jb .test_defaite
    call declencher_saut
    mov dword [pfc_fin], 1
    mov edi, 3
    call gagner_argent
    lea rdi, [humeur]
    mov esi, 30
    call ajuster
    lea rdi, [msg_pfc_gagne]
    mov esi, SON_VICTOIRE
    call poser_message_son
    jmp .fin
.test_defaite:
    cmp dword [pfc_a], 3
    jb .fin
    mov dword [pfc_fin], 2
    lea rdi, [humeur]
    mov esi, 10
    call ajuster
    lea rdi, [msg_pfc_perdu]
    mov esi, SON_DEFAITE
    call poser_message_son
.fin:
    sortie

ecran_pfc:
    entree
    lea rdi, [txt_pfc_titre]
    mov edx, 34
    call texte_centre

    lea rdi, [tampon_texte]
    lea rsi, [txt_toi]
    call copier_chaine
    mov r12, rdi
    mov edi, [pfc_j]
    call texte_nombre
    mov rdi, r12
    mov rsi, rax
    call copier_chaine
    lea rsi, [txt_lui]
    call copier_chaine
    mov r12, rdi
    mov edi, [pfc_a]
    call texte_nombre
    mov rdi, r12
    mov rsi, rax
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 46
    call texte_centre

    cmp dword [pfc_res], 0
    je .boutons
    lea rdi, [tampon_texte]
    lea rsi, [txt_toi]
    call copier_chaine
    mov eax, [pfc_cj]
    lea rcx, [noms_pfc]
    mov rsi, [rcx + rax * 8]
    call copier_chaine
    lea rsi, [txt_lui]
    call copier_chaine
    mov eax, [pfc_ca]
    lea rcx, [noms_pfc]
    mov rsi, [rcx + rax * 8]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 58
    call texte_centre
    mov eax, [pfc_res]
    lea rcx, [textes_manche]
    mov rdi, [rcx + rax * 8]
    mov edx, 68
    call texte_centre

.boutons:
    cmp dword [pfc_fin], 0
    jne .fin_match
    xor ebx, ebx
.choix:
    mov eax, ebx
    imul eax, 49
    add eax, 8
    mov edi, eax
    mov esi, 88
    mov edx, 46
    mov ecx, 14
    lea rax, [noms_pfc]
    mov r8, [rax + rbx * 8]
    call bouton
    test eax, eax
    jz .choix_suivant
    mov edi, ebx
    call jouer_pfc
.choix_suivant:
    inc ebx
    cmp ebx, 3
    jb .choix
    jmp .retour

.fin_match:
    cmp dword [pfc_fin], 1
    jne .perdu
    lea rdi, [txt_bravo]
    jmp .texte
.perdu:
    lea rdi, [txt_perdu]
.texte:
    mov edx, 88
    call texte_centre
    mov edi, 50
    mov esi, 104
    mov edx, 60
    mov ecx, 13
    lea r8, [txt_rejouer]
    call bouton
    test eax, eax
    jz .retour
    call initialiser_pfc
.retour:
    mov edi, ETAT_JOUER
    call bouton_retour_vers
    sortie

initialiser_morpion:
    lea rdi, [morpion_g]
    xor eax, eax
    mov ecx, 12
    rep stosb
    mov dword [morpion_fin], 0
    ret

gagnant_morpion:
    lea rsi, [lignes_morpion]
    lea rdi, [morpion_g]
    xor ecx, ecx
.ligne:
    movzx eax, byte [rsi]
    movzx edx, byte [rdi + rax]
    test edx, edx
    jz .suivante
    movzx eax, byte [rsi + 1]
    cmp dl, [rdi + rax]
    jne .suivante
    movzx eax, byte [rsi + 2]
    cmp dl, [rdi + rax]
    jne .suivante
    mov eax, edx
    ret
.suivante:
    add rsi, 3
    inc ecx
    cmp ecx, 8
    jb .ligne
    xor eax, eax
    ret

grille_pleine:
    lea rcx, [morpion_g]
    xor edx, edx
.boucle:
    cmp byte [rcx + rdx], 0
    je .non
    inc edx
    cmp edx, 9
    jb .boucle
    mov eax, 1
    ret
.non:
    xor eax, eax
    ret

coup_gagnant:
    lea rsi, [lignes_morpion]
    lea r8, [morpion_g]
    xor ecx, ecx
.ligne:
    xor r9d, r9d
    mov r10d, -1
    xor r11d, r11d
.cases:
    movzx eax, byte [rsi + r11]
    movzx edx, byte [r8 + rax]
    cmp edx, edi
    jne .pas_symbole
    inc r9d
    jmp .case_suivante
.pas_symbole:
    test edx, edx
    jnz .case_suivante
    mov r10d, eax
.case_suivante:
    inc r11d
    cmp r11d, 3
    jb .cases
    cmp r9d, 2
    jne .suivante
    cmp r10d, 0
    jl .suivante
    mov eax, r10d
    ret
.suivante:
    add rsi, 3
    inc ecx
    cmp ecx, 8
    jb .ligne
    mov eax, -1
    ret

coup_ia:
    entree
    mov edi, 2
    call coup_gagnant
    cmp eax, 0
    jge .joue
    mov edi, 1
    call coup_gagnant
    cmp eax, 0
    jge .joue
    lea rcx, [morpion_g]
    cmp byte [rcx + 4], 0
    jne .hasard
    mov eax, 4
    jmp .joue
.hasard:
    call rand
    xor edx, edx
    mov ecx, 9
    div ecx
    mov ebx, edx
.cherche:
    lea rcx, [morpion_g]
    cmp byte [rcx + rbx], 0
    je .trouve
    inc ebx
    cmp ebx, 9
    jb .cherche
    xor ebx, ebx
    jmp .cherche
.trouve:
    mov eax, ebx
.joue:
    lea rcx, [morpion_g]
    mov byte [rcx + rax], 2
    sortie

jouer_morpion:
    entree
    mov ebx, edi
    lea rcx, [morpion_g]
    mov byte [rcx + rbx], 1
    call gagnant_morpion
    cmp eax, 1
    je .victoire
    call grille_pleine
    test eax, eax
    jnz .nul
    call coup_ia
    call gagnant_morpion
    cmp eax, 2
    je .defaite
    call grille_pleine
    test eax, eax
    jnz .nul
    jmp .fin
.victoire:
    call declencher_saut
    mov dword [morpion_fin], 1
    mov edi, 4
    call gagner_argent
    lea rdi, [humeur]
    mov esi, 30
    call ajuster
    lea rdi, [msg_morpion_gagne]
    mov esi, SON_VICTOIRE
    call poser_message_son
    jmp .fin
.defaite:
    mov dword [morpion_fin], 2
    lea rdi, [humeur]
    mov esi, 5
    call ajuster
    lea rdi, [msg_morpion_defaite]
    mov esi, SON_DEFAITE
    call poser_message_son
    jmp .fin
.nul:
    mov dword [morpion_fin], 3
    mov edi, 1
    call gagner_argent
    lea rdi, [humeur]
    mov esi, 15
    call ajuster
    lea rdi, [msg_morpion_nul]
    mov esi, SON_ACHAT
    call poser_message_son
.fin:
    sortie

ecran_morpion:
    entree
    mov eax, [morpion_fin]
    lea rcx, [textes_morpion]
    mov rdi, [rcx + rax * 8]
    mov edx, 34
    call texte_centre
    xor ebx, ebx
.case:
    mov eax, ebx
    xor edx, edx
    mov ecx, 3
    div ecx
    imul edx, 24
    add edx, 44
    mov r12d, edx
    imul eax, 24
    add eax, 46
    mov r13d, eax
    mov edi, r12d
    mov esi, r13d
    mov edx, 24
    mov ecx, 24
    call contour_rect
    lea rcx, [morpion_g]
    movzx eax, byte [rcx + rbx]
    cmp eax, 1
    jne .pas_croix
    lea rdi, [sprite_croix]
    lea esi, [r12 + 4]
    lea edx, [r13 + 4]
    mov ecx, 1
    call dessiner_sprite
    jmp .clic
.pas_croix:
    cmp eax, 2
    jne .clic
    lea rdi, [sprite_rond]
    lea esi, [r12 + 4]
    lea edx, [r13 + 4]
    mov ecx, 1
    call dessiner_sprite
.clic:
    cmp dword [morpion_fin], 0
    jne .case_suivante
    lea rcx, [morpion_g]
    cmp byte [rcx + rbx], 0
    jne .case_suivante
    mov edi, r12d
    mov esi, r13d
    mov edx, 24
    mov ecx, 24
    call clic_dans
    test eax, eax
    jz .case_suivante
    mov dword [clic_actif], 0
    mov edi, ebx
    call jouer_morpion
.case_suivante:
    inc ebx
    cmp ebx, 9
    jb .case
    cmp dword [morpion_fin], 0
    je .retour
    mov edi, 52
    mov esi, 120
    mov edx, 56
    mov ecx, 10
    lea r8, [txt_rejouer]
    call bouton
    test eax, eax
    jz .retour
    call initialiser_morpion
.retour:
    mov edi, ETAT_JOUER
    call bouton_retour_vers
    sortie

ajouter_caca:
    entree
    cmp dword [nb_cacas], MAX_CACAS
    jae .fin
    call rand
    and eax, 3
    mov ebx, eax
    xor r12d, r12d
.essai:
    mov eax, ebx
    and eax, 3
    lea rcx, [cacas]
    cmp dword [rcx + rax * 4], 0
    je .libre
    inc ebx
    inc r12d
    cmp r12d, MAX_CACAS
    jb .essai
    jmp .fin
.libre:
    mov dword [rcx + rax * 4], 1
    inc dword [nb_cacas]
    lea rdi, [msg_caca]
    mov esi, SON_CACA
    call poser_message_son
.fin:
    sortie

evenements_tick:
    entree
    cmp dword [immunite], 0
    jle .caca
    dec dword [immunite]
.caca:
    cmp dword [delai_caca], 0
    jle .caca_hasard
    dec dword [delai_caca]
    jnz .maladie
    call ajouter_caca
    jmp .maladie
.caca_hasard:
    cmp dword [dort], 0
    jne .maladie
    call rand
    xor edx, edx
    mov ecx, 100
    div ecx
    cmp edx, 4
    jge .maladie
    call ajouter_caca
.maladie:
    cmp dword [malade], 0
    jne .fin
    cmp dword [immunite], 0
    jg .fin
    mov ebx, 4
    cmp dword [faim], 15
    jl .fragile
    cmp dword [sommeil], 15
    jl .fragile
    cmp dword [humeur], 15
    jl .fragile
    cmp dword [proprete], 15
    jge .tirage
.fragile:
    mov ebx, 30
.tirage:
    call rand
    xor edx, edx
    mov ecx, 1000
    div ecx
    cmp edx, ebx
    jge .fin
    mov dword [malade], 1
    lea rdi, [msg_malade]
    mov esi, SON_MALADE
    call poser_message_son
.fin:
    sortie

evaluer_negligence:
    entree
    xor ecx, ecx
    xor edx, edx
    cmp dword [faim], 0
    je .zero
    cmp dword [sommeil], 0
    je .zero
    cmp dword [humeur], 0
    je .zero
    cmp dword [proprete], 0
    jne .maladie
.zero:
    mov ecx, 1
    mov edx, 1
.maladie:
    cmp dword [malade], 0
    je .total
    mov edx, 1
    test dword [compteur_tick], 1
    jnz .total
    inc ecx
.total:
    test edx, edx
    jz .recuperer
    test ecx, ecx
    jz .fin
    add dword [negligence], ecx
    mov eax, [negligence]
    cmp eax, SEUIL_DEPART
    jae .depart
    cmp eax, SEUIL_MALHEUREUX
    jb .fin
    test dword [compteur_tick], 7
    jnz .fin
    lea rdi, [msg_malheureux]
    mov esi, SON_ERREUR
    call poser_message_son
    jmp .fin
.recuperer:
    mov eax, [negligence]
    sub eax, 2
    jns .garder
    xor eax, eax
.garder:
    mov [negligence], eax
    jmp .fin
.depart:
    mov dword [fin_cause], 0
    cmp dword [faim], 0
    je .mort
    cmp dword [malade], 0
    je .termine
.mort:
    mov dword [fin_cause], 1
.termine:
    mov dword [etat], ETAT_FIN
    mov edi, SON_MORT
    call jouer_son
    call effacer_sauvegarde
.fin:
    sortie

tick_besoins:
    entree
    inc dword [compteur_tick]
    mov ebx, [compteur_tick]
    cmp dword [dort], 0
    jne .dort

    lea rdi, [faim]
    mov esi, -1
    call ajuster
    test ebx, 1
    jnz .sommeil
    lea rdi, [humeur]
    mov esi, -1
    call ajuster
    lea rdi, [proprete]
    mov esi, -1
    call ajuster
.sommeil:
    mov eax, ebx
    xor edx, edx
    mov ecx, 3
    div ecx
    test edx, edx
    jnz .extras
    lea rdi, [sommeil]
    mov esi, -1
    call ajuster
.extras:
    cmp dword [nb_cacas], 0
    je .pas_cacas
    lea rdi, [proprete]
    mov esi, -1
    call ajuster
.pas_cacas:
    cmp dword [malade], 0
    je .suite
    lea rdi, [humeur]
    mov esi, -1
    call ajuster
    jmp .suite

.dort:
    lea rdi, [sommeil]
    mov esi, 5
    call ajuster
    test ebx, 1
    jnz .reveil
    lea rdi, [faim]
    mov esi, -1
    call ajuster
.reveil:
    cmp dword [sommeil], 100
    jl .suite
    mov dword [dort], 0
    lea rdi, [msg_reveille_seul]
    mov esi, SON_REVEIL
    call poser_message_son

.suite:
    cmp dword [hors_ligne], 0
    jne .fin
    call evenements_tick
    call evaluer_negligence
.fin:
    call mettre_a_jour_stade
    sortie

rattrapage:
    entree
    xor edi, edi
    call time
    sub rax, [derniere_maj]
    jle .fin
    xor edx, edx
    mov ecx, 10
    div rcx
    cmp rax, 120
    jbe .borne
    mov eax, 120
.borne:
    mov ebx, eax
    mov dword [hors_ligne], 1
.boucle:
    test ebx, ebx
    jz .termine
    call tick_besoins
    dec ebx
    jmp .boucle
.termine:
    mov dword [hors_ligne], 0
.fin:
    sortie

ecran_fin:
    entree
    cmp dword [fin_cause], 0
    je .fuite
    lea rdi, [sprite_tombe]
    jmp .dessin
.fuite:
    call sprite_animal
.dessin:
    mov esi, 56
    mov edx, 20
    mov ecx, 3
    call dessiner_sprite

    lea rdi, [tampon_texte]
    lea rsi, [nom]
    call copier_chaine
    lea rsi, [txt_fuite]
    cmp dword [fin_cause], 0
    je .phrase
    lea rsi, [txt_mort]
.phrase:
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 78
    call texte_centre

    call age_jours
    mov edi, eax
    call texte_nombre
    mov r12, rax
    lea rdi, [tampon_texte]
    lea rsi, [txt_a_vecu]
    call copier_chaine
    mov rsi, r12
    call copier_chaine
    lea rsi, [txt_jours]
    call copier_chaine
    lea rdi, [tampon_texte]
    mov edx, 90
    call texte_centre

    lea rdi, [txt_conseil]
    mov edx, 102
    call texte_centre

    mov edi, 45
    mov esi, 118
    mov edx, 70
    mov ecx, 14
    lea r8, [txt_nouvel_oeuf]
    call bouton
    test eax, eax
    jz .fin
    call nouvelle_partie
.fin:
    sortie

sauvegarder:
    entree
    mov eax, [etat]
    cmp eax, ETAT_JEU
    jb .fin
    cmp eax, ETAT_FIN
    jae .fin
    xor edi, edi
    call time
    mov [derniere_maj], rax
    lea rdi, [nom_fichier]
    lea rsi, [mode_ecriture]
    call fopen
    test rax, rax
    jz .fin
    mov r12, rax
    lea rdi, [sauv_debut]
    mov esi, 1
    mov edx, TAILLE_SAUV
    mov rcx, r12
    call fwrite
    mov rdi, r12
    call fclose
.fin:
    sortie

charger:
    entree
    lea rdi, [nom_fichier]
    lea rsi, [mode_lecture]
    call fopen
    test rax, rax
    jz .echec
    mov r12, rax
    lea rdi, [sauv_debut]
    mov esi, 1
    mov edx, TAILLE_SAUV
    mov rcx, r12
    call fread
    mov rbx, rax
    mov rdi, r12
    call fclose
    cmp rbx, TAILLE_SAUV
    jne .echec
    cmp dword [sauv_magic], MAGIC
    jne .echec
    cmp dword [animal], NB_ANIMAUX
    jae .echec
    cmp dword [stade], 1
    ja .echec
    cmp dword [nb_cacas], MAX_CACAS
    ja .echec
    mov byte [nom + 15], 0
    lea rdi, [faim]
    xor esi, esi
    call ajuster
    lea rdi, [sommeil]
    xor esi, esi
    call ajuster
    lea rdi, [humeur]
    xor esi, esi
    call ajuster
    lea rdi, [proprete]
    xor esi, esi
    call ajuster
    mov eax, 1
    jmp .fin
.echec:
    lea rdi, [sauv_debut]
    xor eax, eax
    mov ecx, TAILLE_SAUV
    rep stosb
    xor eax, eax
.fin:
    sortie

declencher_saut:
    entree
    call SDL_GetTicks
    mov [saut_debut], eax
    sortie

poser_message_son:
    entree
    mov r12, rdi
    mov edi, esi
    call jouer_son
    mov rdi, r12
    call poser_message
    sortie

ouvrir_audio:
    entree
    lea rdi, [spec_audio]
    mov dword [rdi], 22050
    mov word [rdi + 4], 0x8010
    mov byte [rdi + 6], 1
    mov word [rdi + 8], 1024
    xor edi, edi
    xor esi, esi
    lea rdx, [spec_audio]
    xor ecx, ecx
    xor r8d, r8d
    call SDL_OpenAudioDevice
    mov [audio_dev], eax
    test eax, eax
    jz .fin
    mov edi, eax
    xor esi, esi
    call SDL_PauseAudioDevice
.fin:
    sortie

ajouter_note:
    entree
    mov r12d, edi
    mov eax, esi
    imul eax, 22050
    xor edx, edx
    mov ecx, 1000
    div ecx
    mov r13d, eax
    xor r14d, r14d
    test r12d, r12d
    jz .capacite
    mov eax, 11025
    xor edx, edx
    div r12d
    mov r14d, eax
    test r14d, r14d
    jnz .capacite
    mov r14d, 1
.capacite:
    mov eax, [audio_n]
    add eax, r13d
    cmp eax, CAPACITE_AUDIO
    ja .fin
    xor ebx, ebx
.echantillon:
    cmp ebx, r13d
    jae .fin
    xor ecx, ecx
    test r14d, r14d
    jz .ecrire
    mov eax, ebx
    xor edx, edx
    div r14d
    mov ecx, 2500
    test eax, 1
    jz .ecrire
    neg ecx
.ecrire:
    mov eax, [audio_n]
    lea rdx, [tampon_audio]
    mov [rdx + rax * 2], cx
    inc dword [audio_n]
    inc ebx
    jmp .echantillon
.fin:
    sortie

jouer_son:
    entree
    cmp dword [audio_dev], 0
    je .fin
    cmp dword [hors_ligne], 0
    jne .fin
    mov dword [audio_n], 0
    lea rcx, [sons]
    mov r12, [rcx + rdi * 8]
.note:
    movzx edi, word [r12]
    movzx esi, word [r12 + 2]
    test esi, esi
    jz .envoyer
    call ajouter_note
    add r12, 4
    jmp .note
.envoyer:
    mov edi, [audio_dev]
    call SDL_ClearQueuedAudio
    mov edi, [audio_dev]
    lea rsi, [tampon_audio]
    mov edx, [audio_n]
    shl edx, 1
    call SDL_QueueAudio
.fin:
    sortie

continuer_partie:
    entree
    mov dword [etat], ETAT_JEU
    call rattrapage
    call mettre_a_jour_stade
    call SDL_GetTicks
    mov [dernier_tick], eax
    sortie

ecran_titre:
    entree
    lea rdi, [titre]
    mov esi, 20
    mov edx, 14
    mov ecx, 3
    call dessiner_texte_echelle

    call SDL_GetTicks
    shr eax, 8
    and eax, 1
    shl eax, 1
    add eax, 56
    mov r12d, eax
    cmp dword [save_existe], 0
    je .oeuf
    call sprite_animal
    jmp .sprite
.oeuf:
    lea rdi, [sprite_oeuf]
.sprite:
    mov esi, r12d
    mov edx, 38
    mov ecx, 3
    call dessiner_sprite

    cmp dword [titre_confirm], 0
    jne .confirmation
    cmp dword [save_existe], 0
    je .nouvelle_seule
    lea rdi, [nom]
    mov edx, 90
    call texte_centre
    mov edi, 40
    mov esi, 104
    mov edx, 80
    mov ecx, 13
    lea r8, [txt_continuer]
    call bouton
    test eax, eax
    jz .nouvelle
    call continuer_partie
    jmp .fin
.nouvelle:
    mov edi, 40
    mov esi, 122
    mov edx, 80
    mov ecx, 13
    lea r8, [txt_nouvelle_partie]
    call bouton
    test eax, eax
    jz .fin
    mov dword [titre_confirm], 1
    jmp .fin
.nouvelle_seule:
    mov edi, 40
    mov esi, 112
    mov edx, 80
    mov ecx, 13
    lea r8, [txt_nouvelle_partie]
    call bouton
    test eax, eax
    jz .fin
    call nouvelle_partie
    jmp .fin
.confirmation:
    lea rdi, [txt_ecraser]
    mov edx, 94
    call texte_centre
    mov edi, 30
    mov esi, 108
    mov edx, 40
    mov ecx, 14
    lea r8, [txt_oui]
    call bouton
    test eax, eax
    jz .non
    call effacer_sauvegarde
    mov dword [save_existe], 0
    mov dword [titre_confirm], 0
    call nouvelle_partie
    jmp .fin
.non:
    mov edi, 90
    mov esi, 108
    mov edx, 40
    mov ecx, 14
    lea r8, [txt_non]
    call bouton
    test eax, eax
    jz .fin
    mov dword [titre_confirm], 0
.fin:
    sortie

section .note.GNU-stack noalloc noexec nowrite progbits
