implementation module ELTE_Buffer

import StdEnv
import VectorOverloading

// Const
// If I forget to delete this, remind me
a :: Int
a = 10

// Note that the matrix will be in the form a[y][x] not a[x][y]
// since the output file is column to column
InitBuff :: Int Int -> [[Vector3 Real]]
//InitBuff x y = [[{x0 = toReal i, x1 = toReal j, x2 = 0.0} \\ j <- [1..x]] \\ i <- [1..y]]
InitBuff x y = [[{x0 = 0.0, x1 = 0.0, x2 = 0.0} \\ i <- [1..x]] \\ j <- [1..y]]

GetBuffElem :: [[Vector3 Real]] Int Int -> Vector3 Real
GetBuffElem a i j = (a!!j)!!i

//P3 // magic number
//# feep.ppm
//4 4 // rows cols
//15 // color range [0..15]
// 0  0  0    0  0  0    0  0  0   15  0 15
// 0  0  0    0 15  7    0  0  0    0  0  0
// 0  0  0    0  0  0    0 15  7    0  0  0
//15  0 15    0  0  0    0  0  0    0  0  0

WriteFile :: *File [[Vector3 Real]] -> *File
WriteFile file img
# file = file <<< "P3\n"
# file = file <<< length img <<< ' ' <<< length (img!!0) <<< '\n'
# file = file <<< 255 <<< '\n'
// Write a [Int] to a file
# file = foldl (\x y = x <<< y <<< ' ') file img255
= file
	where 
		// After applied to255, the result has form [[[Int]]]. Then apply 2 flatten to obtain [Int]
		img255 = (flatten o flatten) (map (\row = map (\elem = to255 elem) row) img)
		// Convert (Vector3 Real) -> [x, y, z]
		to255 v = [cvt v.x0, cvt v.x1, cvt v.x2]
		// DONE: Check if element < 0 => assign to 0
		// Linear map from [0.0, 1.0] -> [0, 255]
		// Wait, 1.0 * 255.0 + 0.5 = 256 :| (discuss later)
		cvt x
		| x < 0.0 = 0
		| x > 1.0 = 255
		= toInt (x * 255.0 /*+ 0.5*/) // entier (x * 255.0 + 0.5)

SaveToPPM :: [[Vector3 Real]] String *World -> *World
SaveToPPM img fname w
# (ok, file, w) = fopen fname mode w
| not ok = abort "Can't open file"
# file = WriteFile file img
# (fail, file) = ferror file
| fail = abort "Couldn't write"
# (ok, w) = fclose file w
= w
	where
		mode = FWriteText
