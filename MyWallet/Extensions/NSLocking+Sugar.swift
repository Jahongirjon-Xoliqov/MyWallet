import Foundation

protocol NSTryLocking: NSLocking {
    func superTry() -> Bool
    func with<T>(_ closure: (() -> T)) -> T
    func tryWith<T>(_ closure: (() -> T)) -> T?
}

extension NSTryLocking {
    func with<T>(_ closure: (() -> T)) -> T {
        self.lock()
        let result = closure()
        self.unlock()
        return result
    }
    
    func tryWith<T>(_ closure: (() -> T)) -> T? {
        guard self.superTry() else {
            return nil
        }
        self.lock()
        let result = closure()
        self.unlock()
        return result
    }
}

extension NSLock: NSTryLocking {
    func superTry() -> Bool {
        return self.try()
    }
}

extension NSConditionLock: NSTryLocking {
    func superTry() -> Bool {
        return self.try()
    }
}

extension NSRecursiveLock: NSTryLocking {
    func superTry() -> Bool {
        return self.try()
    }
}

extension NSCondition: NSTryLocking {
    func superTry() -> Bool {
        return false
    }
}
