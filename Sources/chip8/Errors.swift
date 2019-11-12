enum Chip8Error: Error {
    case pcOutOfBounds(pc: UInt16)
    case fatal(_ message: String)
}
