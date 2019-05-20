implementation module Buffer

import StdEnv
import VectorOverloading
import Triangle

// Note that the matrix will be in the form a[y][x] not a[x][y]
// since the output file is column to column
InitBuff :: Int Int -> [[Vector3 Real]]
//InitBuff x y = [[{x0 = toReal i, x1 = toReal j, x2 = 0.0} \\ j <- [1..x]] \\ i <- [1..y]]
InitBuff x y = [[{x0 = 0.0, x1 = 0.0, x2 = 0.0} \\ i <- [1..x]] \\ j <- [1..y]]

// TODO: Range check
GetBuffElem :: [[Vector3 Real]] Int Int -> Vector3 Real
GetBuffElem a i j = (a!!j)!!i

// TODO: Range check
SetBuffElem :: [[Vector3 Real]] Int Int (Vector3 Real) -> [[Vector3 Real]]
SetBuffElem a i j v = (take j a) ++ [SetRow (a!!j) i v] ++ (drop (j + 1) a)
	where
		SetRow :: [Vector3 Real] Int (Vector3 Real) -> [Vector3 Real] 
		SetRow row i v = (take i row) ++ [v] ++ (drop (i + 1) row)

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
# file = file <<< length (img!!0) <<< ' ' <<< length img <<< '\n'
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
		
ReadFile :: *File -> ([(Char, String)], *File)
ReadFile file
# (isEnd, file) = fend file
| isEnd = ([], file)
# (ok, typ, file) = freadc file
| not ok = abort "Reading error, please check the input"
# (cur, file) = freadline file
# (res, file) = ReadFile file
= ([(typ, cur)] ++ res, file)


splitBy :: Char [Char] -> [[Char]]
splitBy c [] = []
splitBy c s = [a] ++ (splitBy c b)
	where
		(a, [bi : b]) = span ((<>)c) s

preprocess :: [(Char, String)] -> [(Char, [[Char]])]
preprocess [] = []
preprocess [(t, s) : xs]
| t == 'v' = [(t, resv) : preprocess xs] // vertices
| t == 'f' = [(t, resf) : preprocess xs] // faces
= preprocess xs
where
	cs = fromString s
	tmp = [t] ++ (init cs)
	resv = splitBy ' ' (tmp ++ [' '])
	
	tmpf = map (\x = splitBy '/' (x ++ ['/'])) resv
	resf = map (\x = x !! 0) tmpf

// TODO: Read color/texture
default_color = {x0 = 1.0, x1 = 1.0, x2 = 1.0}

ListToVec3 :: [a] -> (Vector3 a)
ListToVec3 [a, b, c] = {x0 = a, x1 = b, x2 = c}

CreateTriangle :: [(String, [Real])] -> [Triangle]
CreateTriangle [] = []
CreateTriangle a = [{colorT_ = default_color, a_ = vs !! id0, b_ = vs !! id1, c_ = vs !! id2}
					\\ [id0: xs] <- fs, i <- [0..length xs - 2], id1 <- [xs !! i], id2 <- [xs !! (i + 1)]] // general case
	where
		tmpv :: [(String, [Real])]
		tmpv = filter (\x = (fst x) == "v") a
		vs :: [Vector3 Real]
 		vs = map (\x = (ListToVec3 o (take 3)) (snd x)) tmpv
 		tmpf :: [[Real]]
 		tmpf = map (\x = snd x) (filter (\x = (fst x) == "f") a)
 		tmpf2 :: [[Int]]
 		tmpf2 = (map o map) ((\x = x - 1) o toInt) tmpf
		fs :: [[Int]]
 		fs = tmpf2

//LoadObj :: String *World -> ([(String, [Real])], *World) // for debug
LoadObj :: String *World -> ([Triangle], *World)
LoadObj fname w
# (ok, file, w) = fopen fname mode w
| not ok = abort "Cant open"
# (content, file) = ReadFile file
# (content, file) = (preprocess content, file)
# (content, file) = (map (preprocess1) content, file)
# (content, file) = ((CreateTriangle o splitVF) content, file)
//# (content, file) = (CreateTriangle content, file)
# (ok, w) = fclose file w // Always remember to close
| not ok = abort "Cant close"
= (content, w)
where
	mode = FReadText
	splitVF a = (vs) ++ (fs)
	where
		vs = (filter (\x = fst x == "v") a)
		fs = (filter (\x = fst x == "f") a)
	preprocess1 (a, b) =  (hd c, map (toReal) (tl c))
	where
			c = map (toString) (filter ((<>)[]) b)
