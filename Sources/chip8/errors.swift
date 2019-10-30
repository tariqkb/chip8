enum Chip8Error: Error {
    case pcOutOfBounds(pc: UInt16)
}
