//
//  main.swift
//  domain-modeling
//
//  Created by Xiangyu Ju on 15/10/20.
//  Copyright © 2015年 Xiangyu Ju. All rights reserved.
//

import Foundation

import Foundation

enum Currency {
    
    case USD
    
    case GBP
    
    case EUR
    
    case CAN
    
}

// CustomStringConvertible Protocol
protocol CustomStringConvertible {
    
    var description: String { get }
    
}

// Mathematics Protocol
protocol Mathematics  {
    
    func add(moneys: [Money]) -> Money
    
    func sub(moneys: [Money]) -> Money
}

// Use an extension to extend Double
extension Double{
    
    var USD: Money {return Money(amount: self, currency: .USD)}
    
    var GBP: Money {return Money(amount: self, currency: .GBP)}
    
    var EUR: Money {return Money(amount: self, currency: .EUR)}
    
    var CAN: Money {return Money(amount: self, currency: .CAN)}
    
}


// Money
struct Money: CustomStringConvertible, Mathematics {
    
    var amount: Double
    
    var currency: Currency
    
    var description: String
    
    init (amount: Double, currency: Currency) {
        
        self.amount = amount
        
        self.currency = currency
        
        self.description = String(currency) + String(amount)
        
    }
    
    //Convert
    func convert(convertCurrency: Currency) -> Money {
        
        if(currency == convertCurrency) {
            
            return self
            
        } else {
            
            switch(currency, convertCurrency) {
                
            case(.USD, .GBP):
                
                return Money(amount: amount * 0.5, currency: convertCurrency)
                
            case(.USD, .EUR):
                
                return Money(amount: amount * 1.5, currency: convertCurrency)
                
            case(.USD, .CAN):
                
                return Money(amount: amount * 1.25, currency: convertCurrency)
                
            case(.GBP, .USD):
                
                return Money(amount: amount * 2, currency: convertCurrency)
                
            case(.GBP, .EUR):
                
                return Money(amount: amount * 3, currency: convertCurrency)
                
            case(.GBP, .CAN):
                
                return Money(amount: amount * 2.5, currency: convertCurrency)
                
            case(.EUR, .USD):
                
                return Money(amount: amount * 2 / 3, currency: convertCurrency)
                
            case(.EUR, .GBP):
                
                return Money(amount: amount / 3, currency: convertCurrency)
                
            case(.EUR, .CAN):
                
                return Money(amount: amount * 5 / 6, currency: convertCurrency)
                
            case(.CAN, .USD):
                
                return Money(amount: amount * 0.8, currency: convertCurrency)
                
            case(.CAN, .GBP):
                
                return Money(amount: amount * 0.4, currency: convertCurrency)
                
            case(.CAN, .EUR):
                
                return Money(amount: amount * 1.2, currency: convertCurrency)
                
            default:
                
                print("Input Error")
                
                return self
                
            }
            
        }
        
    }
    
    // Array Add
    func add(moneys: [Money]) -> Money {
        
        var amount = 0.0
        
        for index in 0...moneys.count - 1{
            
            amount = amount + moneys[index].convert(moneys[0].currency).amount
            
        }
        
        return Money(amount: amount, currency: moneys[0].currency)
        
    }
    
    //Array Subtract
    func sub(moneys: [Money]) -> Money {
        
        var amount = moneys[0].amount
        
        for index in 1...moneys.count - 1{
            
            amount = amount - moneys[index].convert(moneys[0].currency).amount
            
        }
        
        return Money(amount: amount, currency: moneys[0].currency)
        
    }
    
}

// Unit Test: Test CustomStringConvertible Protocol for Money
var currentMoney1 = Money(amount: 60, currency: .EUR)

var convertMoney1 = currentMoney1.convert(.USD)

print("Test CustomStringConvertible Protocol for Money1: " + convertMoney1.description)

var currentMoney2 = Money(amount: 30, currency: .CAN)

var convertMoney2 = currentMoney2.convert(.EUR)

print("Test CustomStringConvertible Protocol for Money2: " + convertMoney2.description)

// Unit Test: Test Mathematics Protocol for Money Add
var money = Money(amount:3, currency:.EUR)

var totleMoney1 = money.add([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print("Test Mathematics Protocol for Money Add1: " + totleMoney1.description)

var totleMoney2 = money.add([Money(amount: 32, currency: .USD), Money(amount: 99, currency: .EUR), Money(amount: 52, currency: .CAN)])

print("Test Mathematics Protocol for Money Add2: " + totleMoney2.description)

// Unit Test: Test Mathematics Protocol for Money Subtract
var totleMoney3 = money.sub([Money(amount: 3, currency: .USD), Money(amount: 9, currency: .EUR), Money(amount: 5, currency: .CAN)])

print("Test Mathematics Protocol for Money Subtract1: " + totleMoney3.description)

var totleMoney4 = money.sub([Money(amount: 33, currency: .EUR), Money(amount: 99, currency: .GBP), Money(amount: 52, currency: .CAN)])

print("Test Mathematics Protocol for Money Subtract2: " + totleMoney4.description)

// Unit Test: Test Extension Double
print("Test Extension Double1: " + 45.98.CAN.description)

print("Test Extension Double2: " + currentMoney1.amount.USD.description)


// Job
enum Per{
    
    case hour
    
    case year
}

struct Salary: CustomStringConvertible{
    
    var money: Money
    
    var per: Per
    
    var description: String
    
    init (money: Money, per: Per) {
        
        self.money = money
        
        self.per = per
        
        self.description = money.description + "/" + String(per)
    }
}

// Unit Test: Test CustomStringConvertible Protocol for Salary
var currentMoney3 = Money(amount: 60, currency: .GBP)

var salary3 = Salary(money: currentMoney3, per: .hour)

print("Test CustomStringConvertible Protocol for Salary3: " + salary3.description)

var currentMoney4 = Money(amount: 500000, currency: .USD)

var salary4 = Salary(money: currentMoney4, per: .year)

print("Test CustomStringConvertible Protocol for Salary4: " + salary4.description)


class Job: CustomStringConvertible {
    
    var title: String
    
    var salary: Salary
    
    var description: String
    
    init(currentTitle: String, currentSalary: Salary) {
        
        title = currentTitle
        
        salary = currentSalary
        
        description = "Title: " + currentTitle + "; Salary: " + currentSalary.description
        
    }
    
    func calculateIncome(hours: Double) -> Money {
        
        if salary.per == .hour {
            
            return Money(amount: salary.money.amount * hours, currency: salary.money.currency)
            
        }
        
        return salary.money
        
    }
    
    func raise(percentage: Double) -> Salary {
        
        return Salary(money: Money(amount: salary.money.amount * (1 + percentage),currency: salary.money.currency), per: salary.per)
        
    }
    
}

//Unit Test: Test CustomStringConvertible Protocol for Job
var job1 = Job(currentTitle: "Engineer", currentSalary: Salary(money: Money(amount: 30, currency: .USD), per: .hour))

print("Test CustomStringConvertible Protocol for Job1: " + job1.description)

var job2 = Job(currentTitle: "Doctor", currentSalary: Salary(money: Money(amount: 150000, currency: .CAN), per: .year))

print("Test CustomStringConvertible Protocol for Job2: " + job2.description)


//Person
class Person: CustomStringConvertible {
    
    var firstName: String
    
    var lastName: String
    
    var age: Int
    
    var job: Job?
    
    var spouse: Person?
    
    var description: String
    
    init(first: String, last: String, age: Int, job: Job?, spouse: Person?) {
        
        firstName = first
        
        lastName = last
        
        self.age = age
        
        self.job = job
        
        self.spouse = spouse
        
        if self.age < 16{
            
            if self.job != nil{
                
                self.job = nil
                
                print("The person cannot have a job!")
                
            }
            
        }
        
        if self.age < 18{
            
            if self.spouse != nil{
                
                self.spouse = nil
                
                print("The person cannot have a spouse!")
                
            }
        }
        
        self.description = "FirstName: " + first + "; " + "LastName: " + last + "; " + "Age: " + String(age)
        
        if self.job != nil{
            
            self.description = self.description + "; " + self.job!.description
            
        }
        
        if self.spouse != nil{
            
            self.description = self.description + "; " + "Spouse: " + self.spouse!.description
        }

    }
    
    func toString() {
        
        print(self.description)
    }
    
}

// Unit Test: Test CustomStringConvertible Protocol for Person
var person0 = Person(first: "Lucy", last: "Lovely", age: 11, job: nil, spouse: nil)

print("Test CustomStringConvertible Protocol for Person0: " + person0.description)

var person1 = Person(first: "Xiangyu", last: "Ju", age: 25, job: job1, spouse: nil)

print("Test CustomStringConvertible Protocol for Person1: " + person1.description)

var person2 = Person(first: "Lily", last: "Joe", age: 23, job: job1, spouse: nil)

print("Test CustomStringConvertible Protocol for Person2: " + person2.description)

var person3 = Person(first: "Zixuan", last: "Wang", age: 23, job: job2, spouse: person2)

print("Test CustomStringConvertible Protocol for Person3: " + person3.description)

//Unit Test: If the Person is under age 16, they cannot have a job
var person4 = Person(first: "Zixuan", last: "Wang", age: 12, job: job2, spouse: nil)

//Unit Test: If the Person is under age 18, they cannot have a spouse
var person5 = Person(first: "Zixuan", last: "Wang", age: 17, job: job2, spouse: person1)


//Family
class Family: CustomStringConvertible {
    
    var members:[Person]
    
    var description: String
    
    init(members: [Person]) {
        
        self.members = members
        
        self.description = "FAMILY: "
        
        var isFamily = false
        
        for index in 0...self.members.count - 1 {
            
            if self.members[index].age > 21{
                
                isFamily = true
                
            }
            
            self.description =  self.description + "Person" + String(index + 1) + ": " + self.members[index].description + " "
        }
        
        if !isFamily{
            
            print("The family is not legal!")
            
        }
        
    }
    
    func householdIncome() -> Money{
        
        var moneys = [Money]()
        
        for index in 0...members.count - 1{
            
            if members[index].job != nil{
                
                moneys.append(members[index].job!.salary.money)
            }
        }
        
        return (members[0].job?.salary.money.add(moneys))!
        
    }
    
    func haveChild() -> Family{
        
        self.members.append(Person(first:"N/A", last: "N/A", age:0, job: nil, spouse: nil))
        
        return self
        
    }
}

// Unit Test

// var job1 = Job(currentTitle: "Engineer", currentSalary: Salary(money: Money(amount: 30, currency: .USD), per: .hour))

// var job2 = Job(currentTitle: "Doctor", currentSalary: Salary(money: Money(amount: 150000, currency: .CAN), per: .year))

// var person1 = Person(first: "Xiangyu", last: "Ju", age: 25, job: job1, spouse: nil)

// var person2 = Person(first: "Lily", last: "Joe", age: 23, job: job1, spouse: nil)

// var person3 = Person(first: "Zixuan", last: "Wang", age: 23, job: job2, spouse: person2)

// Unit Test: Test CustomStringConvertible Protocol for Family
var family1 = Family(members: [person1, person2, person3])

print("Test CustomStringConvertible Protocol for Family1: " + family1.description)

var family2 = Family(members: [person3, person2])

print("Test CustomStringConvertible Protocol for Family2: " + family2.description)


