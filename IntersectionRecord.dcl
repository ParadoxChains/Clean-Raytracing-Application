definition module IntersectionRecord
import VectorOverloading
import StdEnv

:: IntersectionRecord = {t :: Real, position :: Vector3 Real, normal :: Vector3 Real}

instance ==   IntersectionRecord | == Real