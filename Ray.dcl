definition module Ray
import VectorOverloading
import StdEnv

:: Ray = {origin :: Vector3 Real, direction :: Vector3 Real}

instance ==   Ray | == Real