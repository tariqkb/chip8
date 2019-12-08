func to8BitArray(_ memory: [UInt16]) -> [UInt8] {
    var array = [UInt8](repeating: 0, count: memory.count * 2)
    for (index, address) in memory.enumerated() {
        array[index * 2] = UInt8(address >> 8)
        array[index * 2 + 1] = UInt8(address & 0xFF)
    }
    return array
}
