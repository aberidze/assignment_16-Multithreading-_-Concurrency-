import UIKit

func factorialOf(_ number: Int) -> NSDecimalNumber {
    if number < 0 {
        return NSDecimalNumber(value: 0)
    } else if number <= 1 {
        return NSDecimalNumber(value: 1)
    } else {
        var result = NSDecimalNumber(value: 1)
        for i in 2...number {
            result = result.multiplying(by: NSDecimalNumber(value: i))
        }
        return result
    }
}

func calculateRandomFactorial() {
    let number = Int.random(in: 20...50)
    print("\(number)! = \(factorialOf(number))")
}


let queue = DispatchQueue(label: "com.example.factorial", attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    calculateRandomFactorial()
}

queue.async(group: group) {
    calculateRandomFactorial()
}

group.notify(queue: .main) {
    if group.wait(timeout: .now()) == .success {
        print("Thread 1 is the winner!")
    } else {
        print("Thread 2 is the winner!")
    }
}
