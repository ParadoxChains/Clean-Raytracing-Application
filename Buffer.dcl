definition module Buffer

import StdEnv
import VectorOverloading

// Note that we have to use
// Start w =
// instead of
// Start =
// for communicating with file (w is of type *World)

InitBuff :: Int Int -> [[Vector3 Real]] // Initialize buffer matrix with the given size
GetBuffElem :: [[Vector3 Real]] Int Int -> Vector3 Real // Access to the element
SetBuffElem :: [[Vector3 Real]] Int Int (Vector3 Real) -> [[Vector3 Real]]
SaveToPPM :: [[Vector3 Real]] String *World -> *World // Write to file
//LoadObj :: String *World -> ([(Char, [Char])], *World)