class Memory {
    let map: [UInt8]
    
    init(bytes: Int) {
        map = [UInt8](repeating: 0, count: bytes)
    }
}
