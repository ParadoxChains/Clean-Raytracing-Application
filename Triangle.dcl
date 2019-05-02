definition module Triangle

import StdEnv
import VectorOverloading
import Ray
import IntersectionRecord

:: Triangle = {colorT_ :: (Vector3 Int), a_ :: (Vector3 Real), b_ :: (Vector3 Real), c_ :: (Vector3 Real)}

/**
  * Implementation of Ray Triangle intersection
  * makes use of the Moller-Trumbore algorithm
  */
(intersect) :: Ray Triangle -> (Bool, IntersectionRecord)