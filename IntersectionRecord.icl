implementation module IntersectionRecord
import VectorOverloading
import StdEnv

:: IntersectionRecord = {t_ :: Real, position_ :: (Vector3 Real), normal_ :: (Vector3 Real), color_ :: (Vector3 Int)}

Start = {t_ = 2.5, position_ = {x0 = 0.0, x1 = 0.0, x2 = 0.0}, normal_ = {x0 = ~1.0, x1 = ~1.0, x2 = ~1.0}, color_ = {x0=255, x1=255, x2=255}}