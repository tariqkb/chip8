public func to8BitArray(_ memory: [UInt16]) -> [UInt8] {
    var array = [UInt8](repeating: 0, count: memory.count * 2)
    for (index, address) in memory.enumerated() {
        let splitAddress = split(address)
        array[index * 2] = splitAddress[0]
        array[index * 2 + 1] = splitAddress[1]
    }
    return array
}

public func split(_ int: UInt16) -> [UInt8] {
    [UInt8(int >> 8), UInt8(int & 0xFF)]
}
