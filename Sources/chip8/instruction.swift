import UInt4

enum Instruction {
    
    /**
     00E0 - CLS
     Clear the display.
     */
    case i00e0
    
    /**
     00EE - RET
     Return from a subroutine.

     The interpreter sets the program counter to the address at the top of the stack, then subtracts 1 from the stack pointer.
     */
    case i00ee
    
    /**
     1nnn - JP addr
     Jump to location nnn.

     The interpreter sets the program counter to nnn.
     */
    case i1nnn(UInt16)
    
    /**
     2nnn - CALL addr
     Call subroutine at nnn.

     The interpreter increments the stack pointer, then puts the current PC on the top of the stack. The PC is then set to nnn.
     */
    case i2nnn(addr: UInt16)
    
    /**
     3xkk - SE Vx, byte
     Skip next instruction if Vx = kk.

     The interpreter compares register Vx to kk, and if they are equal, increments the program counter by 2.
     */
    case i3xkk(UInt4, UInt8)
    
    /**
     4xkk - SNE Vx, byte
     Skip next instruction if Vx != kk.

     The interpreter compares register Vx to kk, and if they are not equal, increments the program counter by 2
     */
    case i4xkk(UInt4, UInt8)
    
}

