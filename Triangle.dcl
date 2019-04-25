definition module Triangle

import StdEnv
import VectorOverloading
import Ray
import IntersectionRecord

:: Triangle = {color_ :: (Vector3 Real), a_ :: (Vector3 Real), b_ :: (Vector3 Real), c_ :: (Vector3 Real)}

(intersect) :: Ray Triangle -> (Bool, IntersectionRecord)