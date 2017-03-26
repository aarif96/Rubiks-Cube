//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//2x2 rubik's cube


enum RubikColor:  Int {
    
    case red = 0
    
    case blue
    
    case green
    
    case yellow

    case white
    
    case orange
    
    case unknown
    
}



enum FaceEnumT:Int {
    
    
    
    case front = 0
    
    
    
    case right
    
    
    
    case top
    
    
    
    case back
    
    
    
    case left
    
    
    
    case bottom
    
}
enum Direction {
    
    case left
    
    case right
}


struct Face {
    
    
    
    let rows: Int
    
    
    
    let columns: Int
    
    
    
    var grid: [RubikColor]
    
    init(rows: Int, columns: Int) {
        
        
        
        self.rows = rows
        
        
        
        self.columns = columns
        
        
        
        grid = Array(repeating: RubikColor.unknown, count: rows * columns)
        
        
        
    }
    
    
    
    
    
    
    
    init(rows: Int, columns: Int, rubikColor: RubikColor) {
        
        
        
        self.rows = rows
        
        
        
        self.columns = columns
        
        
        
        grid = Array(repeating: rubikColor, count: rows * columns)
        
        
        
    }
    
    
    
    
    
    
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        
        
        
        return row >= 0 && row < rows && column >= 0 && column < columns
        
        
        
    }
    
    
    
    
    
    
    
    subscript(row: Int, column: Int) -> RubikColor {
        
        
        
        get {
            
            
            
            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            
            
            return grid[(row * columns) + column]
            
            
            
        }
        
        
        
        set {
            
            
            
            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            
            
            grid[(row * columns) + column] = newValue
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    func facePrint() {
        
        
        
        for i in 0..<rows {
            
            
            
            for j in 0..<columns {
                
                
                
                print(self[i, j])
                
                
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
}



typealias RubiksCube = [Face]







func findRubikColor(i: Int) -> RubikColor {
    
    
    
    switch(i) {
        
        
        
    case 0: return RubikColor.red
        
        
        
    case 1: return RubikColor.blue
        
        
        
    case 2: return RubikColor.green
        
        
        
    case 3: return RubikColor.yellow
        
        
        
    case 4: return RubikColor.white
        
        
        
    case 5: return RubikColor.orange
        
        
        
    default:
        
        
        
        return RubikColor.unknown
        
        
        
    }
    
    
    
}



func setupRubiksCube(numFaces: Int, rows: Int, columns: Int) -> [Face] {
    
    
    
    var rubiksCube = [Face]()
    
    
    
    for i in 0..<numFaces {
        
        
        
        let rubikColor: RubikColor = findRubikColor(i: i)
        
        
        
        print(rubikColor, i)
        
        
        
        rubiksCube.append(Face(rows: rows, columns: columns, rubikColor: rubikColor))
        
        
        
    }
    
    
    
    return rubiksCube
    
    
    
}











func printRubiksCube(rCube: RubiksCube) -> Void {
    
    
    
    for i in 0..<rCube.count {
        
        
        
        print(i)
        
        
        
        rCube[i].facePrint()
        
        
        
    }
    
    
    
}



func recomposeRubiksCube(front2:Face, right2:Face, top2:Face, back2:Face, left2:Face, bottom2:Face) -> RubiksCube {
    
    
    
    
    
    
    
    var newCube = setupRubiksCube(numFaces: 6, rows: 2, columns:2)
    
    
    
    
    
    
    
    newCube[FaceEnumT.front.rawValue] = front2
    
    
    
    newCube[FaceEnumT.right.rawValue] = right2
    
    
    
    newCube[FaceEnumT.top.rawValue] = top2
    
    
    
    newCube[FaceEnumT.back.rawValue] = back2
    
    
    
    newCube[FaceEnumT.left.rawValue] = left2
    
    
    
    newCube[FaceEnumT.bottom.rawValue] = bottom2
    
    
    
    return newCube
    
    
    
}

func isometricRotate(Face2 : Face , direction : Direction, columns : Int ) -> Face {
    
    var faceRotated = Face(rows : columns, columns : columns)
    var faceRotate2 = Face2
    if (direction == Direction.right) {
        
        for i in 0..<columns {
            
            for j in 0..<columns {
                
              faceRotated[i,j] = faceRotate2[columns-j-1,i]
    
            }
        }
    }
    else if (direction == Direction.left) {
        
        for i in 0..<columns {
            
            for j in 0..<columns {
                
             faceRotated[i,j] = faceRotate2[j,columns-i-1]
                
                
            }
        }
        
        
    }
    return faceRotated
}



func resetFaces(rCube : RubiksCube , face : FaceEnumT) -> RubiksCube {
    
    var newFront : Face = rCube[FaceEnumT.front.rawValue]
    
    var newLeft : Face = rCube[FaceEnumT.left.rawValue]
    
    var newTop : Face = rCube[FaceEnumT.top.rawValue]
    
    var newBottom : Face = rCube[FaceEnumT.bottom.rawValue]
    
    var newBack : Face = rCube[FaceEnumT.back.rawValue]
    
    var newRight : Face = rCube[FaceEnumT.right.rawValue]
    
    switch(face) {
        
    case .right :  //Right face becomes the front face
        
        newFront = rCube[FaceEnumT.right.rawValue]
        
        newLeft = rCube[FaceEnumT.front.rawValue]
        
        newTop  = rCube[FaceEnumT.top.rawValue]
        
        newBottom  = rCube[FaceEnumT.bottom.rawValue]
        
        newBack  = rCube[FaceEnumT.left.rawValue]
        
        newRight = rCube[FaceEnumT.back.rawValue]
        
    case .left  :  //left face becomes the front face
        
        newFront = rCube[FaceEnumT.left.rawValue]
        
        newLeft  = rCube[FaceEnumT.back.rawValue]
        
        newTop = rCube[FaceEnumT.top.rawValue]
        
        newBottom  = rCube[FaceEnumT.bottom.rawValue]
        
        newBack = rCube[FaceEnumT.right.rawValue]
        
        newRight = rCube[FaceEnumT.front.rawValue]
        
    case .top :   //top face becomes the front face
        
        newFront = rCube[FaceEnumT.top.rawValue]
        
        newLeft = rCube[FaceEnumT.left.rawValue]
        
        newTop  = rCube[FaceEnumT.back.rawValue]
        
        newBottom  = rCube[FaceEnumT.front.rawValue]
        
        newBack  = rCube[FaceEnumT.bottom.rawValue]
        
        newRight = rCube[FaceEnumT.right.rawValue]
        
    case .bottom : //bottom face becomes the front face
        
        newFront = rCube[FaceEnumT.bottom.rawValue]
        
        newLeft = rCube[FaceEnumT.left.rawValue]
        
        newTop  = rCube[FaceEnumT.front.rawValue]
        
        newBottom  = rCube[FaceEnumT.back.rawValue]
        
        newBack  = rCube[FaceEnumT.top.rawValue]
        
        newRight = rCube[FaceEnumT.right.rawValue]
        
    case .back :  //back face becomes the front face
        
        newFront = rCube[FaceEnumT.back.rawValue]
        
        newLeft = rCube[FaceEnumT.right.rawValue]
        
        newTop  = rCube[FaceEnumT.top.rawValue]
        
        newBottom  = rCube[FaceEnumT.bottom.rawValue]
        
        newBack  = rCube[FaceEnumT.front.rawValue]
        
        newRight = rCube[FaceEnumT.left.rawValue]
        
    case .front : print("No need to reset faces")  //front face is front so no need to reset face
        
    }
    
    return recomposeRubiksCube(front2: newFront, right2: newRight, top2: newTop, back2: newBack, left2: newLeft, bottom2: newBottom) //returning the cube with reset faces
    
}



func moveUp(rCube : RubiksCube ,face : FaceEnumT , columns : Int , columnNumber : Int )->RubiksCube {
    
    

    
    
    var front2: Face = rCube[FaceEnumT.front.rawValue]
    
    
    
    var top2: Face = rCube[FaceEnumT.top.rawValue]
    
    
    
    var back2: Face = rCube[FaceEnumT.back.rawValue]
    
    
    
    var bottom2: Face = rCube[FaceEnumT.bottom.rawValue]
    
    
    
    var left2: Face = rCube[FaceEnumT.left.rawValue]
    
    
    
    var right2: Face = rCube[FaceEnumT.right.rawValue]
    

    
    for i in 0..<columns {
        
        
        
        front2[i, columnNumber] = rCube[FaceEnumT.bottom.rawValue][i, columnNumber]
        
        
        
        top2[i, columnNumber] = rCube[FaceEnumT.front.rawValue][i, columnNumber]
        
        
        
        back2[i, columnNumber] = rCube[FaceEnumT.top.rawValue][i, columnNumber]
        
        
        
        bottom2[i, columnNumber] = rCube[FaceEnumT.back.rawValue][i, columnNumber]
        
        
        
    }
    if columnNumber == 0 {
        left2 = isometricRotate(Face2 : left2 , direction : .left , columns : columns)
    }
    else if columnNumber == columns - 1 {
        right2 = isometricRotate(Face2 : right2 ,direction : .right , columns : columns)
        
    }
    
    
    return recomposeRubiksCube(front2: front2, right2: right2, top2: top2, back2: back2, left2: left2, bottom2: bottom2)
    
    
    
    
    
    
    
}

func moveDown(rCube : RubiksCube ,face : FaceEnumT , columns : Int , columnNumber : Int )->RubiksCube {
    
    
    
    var front2: Face = rCube[FaceEnumT.front.rawValue]
    
    
    
    var top2: Face = rCube[FaceEnumT.top.rawValue]
    
    
    
    var back2: Face = rCube[FaceEnumT.back.rawValue]
    
    
    
    var bottom2: Face = rCube[FaceEnumT.bottom.rawValue]
    
    
    
    var left2: Face = rCube[FaceEnumT.left.rawValue]
    
    
    
    var right2: Face = rCube[FaceEnumT.right.rawValue]
    
    
    
    
    
    
    
    
    
    for i in 0..<columns {
        
        
        
        bottom2[i, columnNumber] = rCube[FaceEnumT.front.rawValue][i,columnNumber]
        
        
        
        front2[i, columnNumber] = rCube[FaceEnumT.top.rawValue][i, columnNumber]
        
        
        
        top2[i, columnNumber] = rCube[FaceEnumT.back.rawValue][i, columnNumber]
        
        
        
        back2[i, columnNumber] = rCube[FaceEnumT.bottom.rawValue][i, columnNumber]
        
        
        
    }
    
    
    if columnNumber == 0 {
        left2 = isometricRotate(Face2 : left2 , direction : .right , columns : columns)
    }
    else if columnNumber==columns - 1 {
        right2 = isometricRotate(Face2 : right2 ,direction : .left , columns : columns)
        
    }
    
    
    return recomposeRubiksCube(front2: front2, right2: right2, top2: top2, back2: back2, left2: left2, bottom2: bottom2)
    
}

func moveRight(rCube : RubiksCube ,face : FaceEnumT , columns : Int , rowNumber : Int )->RubiksCube {
    
    
    
    
    
    var front2: Face = rCube[FaceEnumT.front.rawValue]
    
    
    
    var top2: Face = rCube[FaceEnumT.top.rawValue]
    
    
    
    var back2: Face = rCube[FaceEnumT.back.rawValue]
    
    
    
    var bottom2: Face = rCube[FaceEnumT.bottom.rawValue]
    
    
    
    var left2: Face = rCube[FaceEnumT.left.rawValue]
    
    
    
    var right2: Face = rCube[FaceEnumT.right.rawValue]
    
    
    
    
    
    
    
    
    
    
    
    for i in 0..<columns {
        
        
        
        right2[rowNumber,i] = rCube[FaceEnumT.front.rawValue][rowNumber,i]
        
        
        
        front2[rowNumber,i] = rCube[FaceEnumT.left.rawValue][rowNumber,i]
        
        
        
        left2[rowNumber,i] = rCube[FaceEnumT.back.rawValue][rowNumber,i]
        
        
        
        back2[rowNumber,i] = rCube[FaceEnumT.right.rawValue][rowNumber,i]
        
        
        
    }
    if rowNumber == 0  {
        top2 = isometricRotate(Face2 : top2 , direction : .left , columns : columns)
    }
    else if rowNumber == columns - 1 {
        bottom2 = isometricRotate(Face2 : bottom2 , direction : .left , columns : columns)
    }
    
    
    
    
    
    
    
    return recomposeRubiksCube(front2: front2, right2: right2, top2: top2, back2: back2, left2: left2, bottom2: bottom2)
    
    
    
}

func moveLeft(rCube : RubiksCube ,face : FaceEnumT , columns : Int , rowNumber : Int )->RubiksCube  {
    
    
    
    var front2: Face = rCube[FaceEnumT.front.rawValue]
    
    
    
    var top2: Face = rCube[FaceEnumT.top.rawValue]
    
    
    
    var back2: Face = rCube[FaceEnumT.back.rawValue]
    
    
    
    var bottom2: Face = rCube[FaceEnumT.bottom.rawValue]
    
    
    
    var left2: Face = rCube[FaceEnumT.left.rawValue]
    
    
    
    var right2: Face = rCube[FaceEnumT.right.rawValue]
    
    
    
    
    
    
    
    
    
    
    
    for i in 0..<columns {
        
        
        
        front2[rowNumber,i] = rCube[FaceEnumT.right.rawValue][rowNumber,i]
        
        
        
        left2[rowNumber,i] = rCube[FaceEnumT.front.rawValue][rowNumber,i]
        
        
        
        back2[rowNumber,i] = rCube[FaceEnumT.left.rawValue][rowNumber,i]
        
        
        
        right2[rowNumber,i] = rCube[FaceEnumT.back.rawValue][rowNumber,i]
        
        
        
    }
    
    if rowNumber==0  {
       top2 =  isometricRotate(Face2 : top2 , direction : .right , columns : columns)
    }
    else if rowNumber==columns - 1 {
       bottom2 = isometricRotate(Face2 : bottom2 , direction : .right , columns : columns)
    }
    
    return recomposeRubiksCube(front2: front2, right2: right2, top2: top2, back2: back2, left2: left2, bottom2: bottom2)
    
}











//Testing

let columnNo = 1

let rowNumber = 1

let columns = 2

let rows = 2

let numberFaces = 6



let rubiksCube = setupRubiksCube(numFaces: numberFaces, rows: rows, columns: columns)

printRubiksCube(rCube: rubiksCube)



var chooseFace = FaceEnumT.front



let firaaCube = resetFaces(rCube : rubiksCube,face : chooseFace)



let AarifsCube = moveUp(rCube : firaaCube , face : chooseFace , columns : columns, columnNumber : columnNo)



printRubiksCube(rCube: AarifsCube)



//let AarifsCube2 = moveDown(rCube : AarifsCube , face : chooseFace , columns : columns, columnNumber : columnNo )


//printRubiksCube(rCube: AarifsCube2)



let AarifsCube3 = moveRight(rCube : AarifsCube , face : chooseFace, columns : columns, rowNumber : rowNumber )

printRubiksCube(rCube: AarifsCube3)


//let AarifsCube4 = moveLeft(rCube : rubiksCube , face : chooseFace , columns : columns,rowNumber : rowNumber)
