implementation module Ray

import VectorOverloading
import StdEnv

:: Ray = {origin :: (Vector3 Real), direction :: (Vector3 Real)}

Start = {origin = {x0 = 0.0, x1 = 0.0, x2 = 0.0}, direction = {x0 = 1.0, x1 = 1.0, x2 = 1.0}}