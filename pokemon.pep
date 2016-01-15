BR main

myLife: .BLOCK 2
oppLife: .BLOCK 2
myPoke:  .BLOCK 2           ;global variable #2d

option:  .EQUATE 0           ;local variable #2d
choice:  CHARO '\n', i
start:   STRO msg, d
         CHARO '\n', i
         STRO msg2, d
         CHARO '\n', i
         STRO msg3, d
         CHARO '\n', i
         SUBSP 2, i          ;allocate #option
         DECI option, s
         LDA option, s
         CPA 1, i
         BRNE catch
         LDA myPoke, d
         STA -2, s 
         SUBSP 2, i          ;push #x       
         CALL fight          ;push retAddr
         ADDSP 2, i          ;pop #x 
         LDA myLife, d
         CPA 101, i
         BREQ finish
         CPA 0, i
         BRGT or
         CHARO '\n', i
         CHARO '\n', i 
         STRO loser, d
         CHARO '\n', i
         BR finish
or:      LDA oppLife, d
         CPA 0, i
         BRGT start
         CHARO '\n', i
         CHARO '\n', i
         STRO winner, d
         CHARO '\n', i     
         BR finish
catch:   CPA 2, i
         BRNE change
         LDA oppLife, d
         BREQ toSoon
         CALL pokeball
         BR finish
toSoon:  STRO gotaway, d
         BR finish
change:  CPA 3, i
         BRNE run
         STRO sad, d
         CHARO '\n', i
         CHARO '\n', i
         BR start
run:     CPA 4, i
         BRNE error
         STRO ran, d
         BR finish
error:   STRO errormsg, d
         CHARO '\n', i
         CHARO '\n', i
         BR start
finish:  RET2                ;deallocate #option                

x:       .EQUATE 4           ;formal parameter #2d
y:       .EQUATE 0           ;local variable #2d
fight:   SUBSP 2, i          ;allocate #y
         LDA 1, i
         STA y, s
type:    CPA x, s
         BREQ skip
         LDA y, s 
         ADDA 1, i
         STA y, s
         BR type
skip:    LDA myLife, d
         CPA 1, i
         BRGE attack
         LDA y, s
         CPA 1, i
         BRNE loop1
         LDA 101, i
         STA myLife, d
         LDA 50, i
         STA oppLife, d
         BR attack
loop1:   LDA y, s
         CPA 2, i
         BRNE loop2
         LDA 101, i
         STA myLife, d
         LDA 100, i
         STA oppLife, d
         BR attack
loop2:   LDA y, s
         CPA 3, i
         BRNE loop3
         LDA 101, i
         STA myLife, d
         LDA 200, i
         STA oppLife, d
         BR attack
loop3:   LDA 101, i
         STA myLife, d
         LDA 10, i
         STA oppLife, d
         STRO fled, d
         BR done
attack:  CALL moves
         LDA myLife, d
         BRLE done
         LDA oppLife, d
         BREQ done
         CALL oppMove
done:    RET2                ;deallocate #y, pop retAddr 

fake:    .EQUATE 0           ;local variable #2d  
moves:   SUBSP 2, i          ;allocate #fake
         CHARO '\n', i
         STRO myMoves1, d
         CHARO '\n', i
         STRO myMoves2, d
         DECI fake, s
         CHARO '\n', i
         STRO pikatak, d
         LDA fake, s
         CPA 1, i
         BRNE a2
         STRO atk1, d
         BR hit
a2:      CPA 2, i
         BRNE a3
         STRO atk2, d
         BR hit
a3:      CPA 3, i
         BRNE a4
         STRO atk3, d
         BR hit
a4:      STRO atk4, d
hit:     LDA oppLife, d
         SUBA 25, i
         STA oppLife, d
         CHARO '\n', i
         STRO life1, d
         DECO oppLife, d
         RET2                ;deallocate #fake

oppMove: CHARO '\n', i
         CHARO '\n', i
         STRO oppMoves, d
         LDA myLife, d
         SUBA 100, i
         STA myLife, d
         CHARO '\n', i
         STRO life2, d
         DECO myLife, d
         CHARO '\n', i
         CHARO '\n', i
         RET0 

pokeball: LDA oppLife, d
         CPA 30, i
         BRGT nope
         STRO caught, d
         CHARO '\n', i
         STRO pc, d
         BR nice
nope:    STRO gotaway, d
nice:    CHARO '\n', i
         RET0
         
pokemon: .EQUATE 0           ;local variable #2d
begin:   SUBSP 2, i          ;allocate local #pokemon 
         STRO opening, d 
         DECI pokemon, s
         LDX pokemon, s
         ASLX
         BR pkmnJT, x 
pkmnJT:       .ADDRSS case0
         .ADDRSS case1 
         .ADDRSS case2
         .ADDRSS case3
         .ADDRSS case4
         .ADDRSS case5
         .ADDRSS case6
         .ADDRSS case7
         .ADDRSS case8
         .ADDRSS case9
         .ADDRSS case10
case0:   STRO pidgey, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case1:   STRO drgnite, d 
         LDA 2, i
         STA myPoke, d
         BR endCase
case2:   STRO magikarp, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case3:   STRO jglypuff, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case4:   STRO diglet, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case5:   STRO alakazam, d
         LDA 2, i
         STA myPoke, d
         BR endCase
case6:   STRO meowth, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case7:   STRO abra, d
         LDA 4, i
         STA myPoke, d
         BR endCase
case8:   STRO togepi, d
         LDA 4, i
         STA myPoke, d
         BR endCase
case9:   STRO slowpoke, d
         LDA 1, i
         STA myPoke, d
         BR endCase
case10:  STRO mewtwo, d
         LDA 3, i
         STA myPoke, d
         BR endCase
endCase: CHARO '\n', i
         RET2         ;deallocate #pokemon 


main:    CALL begin        
         CALL choice
         STOP

opening: .ASCII "Welcome to Pokemon battle! Pick a number from 0-10: \x00"
msg: .ASCII "What do you want to do? \x00"
msg2: .ASCII "   1(Fight)  2(Catch) \x00"
msg3: .ASCII "  3(Pokemon)  4(Run) \x00"

pidgey: .ASCII "A wild Pidgey appeared! \x00"
drgnite: .ASCII "A wild Dragonite appeared! \x00"
magikarp: .ASCII "A wild Magikarp appeared! \x00"
jglypuff: .ASCII "A wild Jigglypuff appeared! \x00"
diglet: .ASCII "A wild Diglet appeared! \x00"
alakazam: .ASCII "A wild Alakazam appeared! \x00"
meowth: .ASCII "A wild Meowth appeared! \x00"
abra: .ASCII "A wild Abra appeared! \x00"
togepi: .ASCII "A wild Togepi appeared! \x00"
slowpoke: .ASCII "A wild Slowpoke appeared! \x00"
mewtwo: .ASCII "A wild Mewtwo appeared! \x00"

myMoves1: .ASCII "1(Quick Attack)   2(Thunderbolt)\x00"
myMoves2: .ASCII "  3(Thunder)        4(Agility)\x00"
pikatak: .ASCII "Pikachu, use \x00"
atk1: .ASCII "Quick Attack!\x00"
atk2: .ASCII "Thunderbolt!\x00"
atk3: .ASCII "Thunder!\x00"
atk4: .ASCII "Agility\x00"

oppMoves: .ASCII "The enemy strikes back!\x00"

life1: .ASCII "Your opponents life is: \x00"
life2: .ASCII "Your pokemon's life is: \x00"

winner: .ASCII "The pokemon has fainted... You win! \x00"
loser: .ASCII "Your pokemon has fainted... You lost.\x00"
fled: .ASCII "It looks like the Pokemon has ran away! \x00"
ran: .ASCII "You ran away! \x00"

caught: .ASCII "You throw a pokeball... You caught the pokemon! \x00"
gotaway: .ASCII "You throw a pokeball... shoot, it got away! \x00"
pc: .ASCII "You store away the pokemon at the Pokemon Center.\x00"
sad: .ASCII "You only have Pikachu! All your other pokemon are at the Pokemon Center.\x00"

errormsg: .ASCII "Invalid move~~~\x00" 



.END