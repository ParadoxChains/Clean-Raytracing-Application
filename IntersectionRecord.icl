implementation module IntersectionRecord
import VectorOverloading
import StdEnv

:: IntersectionRecord = {t :: Real, position :: Vector3 Real, normal :: Vector3 Real}

instance ==   IntersectionRecord | == Real   where == ir0 ir1	= ir0.t == ir1.t && ir0.position == ir1.position && ir0.normal == ir1.normal

// Start = {t = 2.0, position = {x0 = 0.0, x1 = 0.0, x2 = 0.0}, normal = {x0 = ~1.0, x1 = ~1.0, x2 = ~1.0}}