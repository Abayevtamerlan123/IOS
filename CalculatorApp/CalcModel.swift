
import Foundation

enum  Operation {
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case zero
    case equals
}

func addition(op1:Double,op2:Double)->Double {
    return op1+op2
}
struct CalculatorModel {
     
    
    
    var my_operation : Dictionary<String,Operation> =
        [
            "π": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "√": Operation.unaryOperation(sqrt),
            "+": Operation.binaryOperation(addition),
            "-": Operation.binaryOperation({
                (op1:Double,op2:Double) in
                return op1-op2
            }),
            "*": Operation.binaryOperation({
                (op1:Double,op2:Double) in
                return op1*op2
            }),
            "÷": Operation.binaryOperation({
                (op1:Double,op2:Double) in
                return op1/op2
            }),
            "%": Operation.unaryOperation({
                (op1:Double) in
                return op1/100
            }),
            "±": Operation.unaryOperation({
                (op1:Double) in
                return op1*(-1)
            }),
            ".": Operation.unaryOperation({
                (op1:Double) in
                return op1
            }),
            "ln": Operation.unaryOperation({
                (op1:Double) in
                return log(op1)
            }),
            "AC": Operation.zero,
            "=": Operation.equals
            
        ]
    
    private var global_value:Double?
    mutating func setOperend(_ operend:Double) {
        global_value = operend
    }
    
    mutating func performOperend(_ operation:String) {
        
        let symbol = my_operation[operation]!
        switch symbol  {
        case .constant(let value):
            global_value = value
        case .unaryOperation(let function):
            global_value = function(global_value!)
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOpearation(firstOperand: global_value!, operation: function)
        case .zero:
            global_value = 0
        case .equals:
            global_value = saving?.performOperationWith(secondOperand: global_value!)
        }
        
        
    }
    
    func getResult()->Double?{
        return global_value!
    }
    
    private var saving:SaveFirstOperandAndOpearation?
    struct SaveFirstOperandAndOpearation  {
        var firstOperand:Double
        var operation:(Double,Double)->Double
        
        func performOperationWith(secondOperand op2:Double)->Double {
            return operation(firstOperand,op2)
        }
    }
    
}
