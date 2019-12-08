import UInt4

enum Instruction: Equatable {
    
    /**
     0000 - NOOP
     Do nothing
     */
    case noop
    
    /**
     00E0 - CLS
     Clear the display.
     */
    case clearScreen
    
    /**
     00EE - RET
     Return from a subroutine.

     The interpreter sets the program counter to the address at the top of the stack, then subtracts 1 from the stack pointer.
     */
    case returnFromSubroutine
    
    /**
     1nnn - JP addr
     Jump to location nnn.

     The interpreter sets the program counter to nnn.
     */
    case jump(addr: UInt16)
    
    /**
     2nnn - CALL addr
     Call subroutine at nnn.

     The interpreter increments the stack pointer, then puts the current PC on the top of the stack. The PC is then set to nnn.
     */
    case call(addr: UInt16)
    
    /**
     3xkk - SE Vx, byte
     Skip next instruction if Vx = kk.

     The interpreter compares register Vx to kk, and if they are equal, increments the program counter by 2.
     */
    case skipIfEqualsInt(_ vx: Register, _ byte: UInt8)
    
    /**
     4xkk - SNE Vx, byte
     Skip next instruction if Vx != kk.

     The interpreter compares register Vx to kk, and if they are not equal, increments the program counter by 2
     */
    case skipIfNotEqualsInt(_ vx: Register, _ byte: UInt8)
    
    /**
     5xy0 - SE Vx, Vy
     Skip next instruction if Vx = Vy.

     The interpreter compares register Vx to register Vy, and if they are equal, increments the program counter by 2.
     */
    case skipIfEquals(_ vx: Register, _ vy: Register)
    
    /**
     6xkk - LD Vx, byte
     Set Vx = kk.

     The interpreter puts the value kk into register Vx.
     */
    case loadWithInt(_ vx: Register, _ byte: UInt8)
   
    /**
     7xkk - ADD Vx, byte
     Set Vx = Vx + kk.

     Adds the value kk to the value of register Vx, then stores the result in Vx.
     */
    case addWithInt(_ vx: Register, _ byte: UInt8)
    
    /**
     8xy0 - LD Vx, Vy
     Set Vx = Vy.

     Stores the value of register Vy in register Vx.
     */
    case load(_ vx: Register, _ vy: Register)
    
    /**
     8xy1 - OR Vx, Vy
     Set Vx = Vx OR Vy.

     Performs a bitwise OR on the values of Vx and Vy, then stores the result in Vx. A bitwise OR compares the corrseponding bits from two values, and if either bit is 1, then the same bit in the result is also 1. Otherwise, it is 0.
     */
    case or(_ vx: Register, _ vy: Register)
    
    /**
     8xy2 - AND Vx, Vy
     Set Vx = Vx AND Vy.

     Performs a bitwise AND on the values of Vx and Vy, then stores the result in Vx. A bitwise AND compares the corrseponding bits from two values, and if both bits are 1, then the same bit in the result is also 1. Otherwise, it is 0.
     */
    case and(_ vx: Register, _ vy: Register)
    
    /**
     8xy3 - XOR Vx, Vy
     Set Vx = Vx XOR Vy.

     Performs a bitwise exclusive OR on the values of Vx and Vy, then stores the result in Vx. An exclusive OR compares the corrseponding bits from two values, and if the bits are not both the same, then the corresponding bit in the result is set to 1. Otherwise, it is 0.
     */
    case xor(_ vx: Register, _ vy: Register)
    
    /**
     8xy4 - ADD Vx, Vy
     Set Vx = Vx + Vy, set VF = carry.

     The values of Vx and Vy are added together. If the result is greater than 8 bits (i.e., > 255,) VF is set to 1, otherwise 0. Only the lowest 8 bits of the result are kept, and stored in Vx.
     */
    case add(_ vx: Register, _ vy: Register)
    
    /**
     8xy5 - SUB Vx, Vy
     Set Vx = Vx - Vy, set VF = NOT borrow.

     If Vx > Vy, then VF is set to 1, otherwise 0. Then Vy is subtracted from Vx, and the results stored in Vx.
     */
    case subtract(_ vx: Register, _ vy: Register)
    
    /**
     8xy6 - SHR Vx {, Vy}
     Set Vx = Vx SHR 1.

     If the least-significant bit of Vx is 1, then VF is set to 1, otherwise 0. Then Vx is divided by 2.
     
     Cowgod's spec ignored Vy
     */
    case shiftRight(_ vx: Register)
    
    /**
     8xy7 - SUBN Vx, Vy
     Set Vx = Vy - Vx, set VF = NOT borrow.

     If Vy > Vx, then VF is set to 1, otherwise 0. Then Vx is subtracted from Vy, and the results stored in Vx.
     */
    case subtractFrom(_ vx: Register, _ vy: Register)
    
    /**
     8xyE - SHL Vx {, Vy}
     Set Vx = Vx SHL 1.

     If the most-significant bit of Vx is 1, then VF is set to 1, otherwise to 0. Then Vx is multiplied by 2.
     */
    case shiftLeft(_ vx: Register)
    
    /**
     9xy0 - SNE Vx, Vy
     Skip next instruction if Vx != Vy.

     The values of Vx and Vy are compared, and if they are not equal, the program counter is increased by 2.
     */
    case skipIfNotEquals(_ vx: Register, _ vy: Register)
    
    /**
     Annn - LD I, addr
     Set I = nnn.

     The value of register I is set to nnn.
     */
    case loadIWithInt(_ addr: UInt16)
    
    /**
     Bnnn - JP V0, addr
     Jump to location nnn + V0.

     The program counter is set to nnn plus the value of V0.
     */
    case jumpToV0(plus: UInt16)
    
    /**
     Cxkk - RND Vx, byte
     Set Vx = random byte AND kk.

     The interpreter generates a random number from 0 to 255, which is then ANDed with the value kk. The results are stored in Vx. See instruction 8xy2 for more information on AND.
     */
    case loadWithRandom(_ vx: Register, bitmask: UInt8)
    
    /**
     Dxyn - DRW Vx, Vy, nibble
     Display n-byte sprite starting at memory location I at (Vx, Vy), set VF = collision.

     The interpreter reads n bytes from memory, starting at the address stored in I. These bytes are then displayed as sprites on screen at coordinates (Vx, Vy). Sprites are XORed onto the existing screen. If this causes any pixels to be erased, VF is set to 1, otherwise it is set to 0. If the sprite is positioned so part of it is outside the coordinates of the display, it wraps around to the opposite side of the screen. See instruction 8xy3 for more information on XOR, and section 2.4, Display, for more information on the Chip-8 screen and sprites.
    */
    case draw(_ vx: Register, _ vy: Register, nib: UInt4)

    /**
     Ex9E - SKP Vx
     Skip next instruction if key with the value of Vx is pressed.

     Checks the keyboard, and if the key corresponding to the value of Vx is currently in the down position, PC is increased by 2.
    */
    case skipIfKeypress(_ vx: Register)
    
    /**
     ExA1 - SKNP Vx
     Skip next instruction if key with the value of Vx is not pressed.

     Checks the keyboard, and if the key corresponding to the value of Vx is currently in the up position, PC is increased by 2.
    */
    case skipIfNotKeypress(_ vx: Register)
    
    /**
     Fx07 - LD Vx, DT
     Set Vx = delay timer value.

     The value of DT is placed into Vx.
    */
    case loadWithDelay(_ vx: Register)
    
    /**
     Fx0A - LD Vx, K
     Wait for a key press, store the value of the key in Vx.

     All execution stops until a key is pressed, then the value of that key is stored in Vx.
    */
    case waitForKeypress(_ vx: Register)
    
    /**
     Fx15 - LD DT, Vx
     Set delay timer = Vx.

     DT is set equal to the value of Vx.
    */
    case loadDelayWith(_ vx: Register)
    
    /**
     Fx18 - LD ST, Vx
     Set sound timer = Vx.

     ST is set equal to the value of Vx.
    */
    case loadSoundWith(_ vx: Register)
    
    /**
     Fx1E - ADD I, Vx
     Set I = I + Vx.

     The values of I and Vx are added, and the results are stored in I.
    */
    case addIWith(_ vx: Register)
    
    /**
     Fx29 - LD F, Vx
     Set I = location of sprite for digit Vx.

     The value of I is set to the location for the hexadecimal sprite corresponding to the value of Vx. See section 2.4, Display, for more information on the Chip-8 hexadecimal font.
    */
    case loadIWithLocationOfSpriteIn(_ vx: Register)
    
    /**
     Fx33 - LD B, Vx
     Store BCD representation of Vx in memory locations I, I+1, and I+2.

     The interpreter takes the decimal value of Vx, and places the hundreds digit in memory at location in I, the tens digit at location I+1, and the ones digit at location I+2.
     */
    case loadDecimalOf(_ vx: Register)
    
    /**
     Fx55 - LD [I], Vx
     Store registers V0 through Vx in memory starting at location I.

     The interpreter copies the values of registers V0 through Vx into memory, starting at the address in I.
    */
    case loadIntoMemoryV0To(_ vx: Register)
    
    /**
     Fx65 - LD Vx, [I]
     Read registers V0 through Vx from memory starting at location I.

     The interpreter reads values from memory starting at location I into registers V0 through Vx.
    */
    case loadFromMemoryV0To(_ vx: Register)

}
