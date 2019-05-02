definition module RayTriangleIntersector

import StdEnv
import VectorOverloading
import Ray
import IntersectionRecord
import Triangle

IntersectRayTriangles :: Ray [Triangle] -> (Bool, IntersectionRecord)