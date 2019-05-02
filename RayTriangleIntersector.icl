implementation module RayTriangleIntersector

import StdEnv
import VectorOverloading
import Ray
import IntersectionRecord
import Triangle


// EMPTYINTERSECTRECORD = {t_ = 0.0, position_ = {x0=0.0, x1=0.0, x2=0.0}, normal_ = {x0=0.0, x1=0.0, x2=0.0}, color_ = {x0=255, x1=255, x2=255}}

IntersectRayTriangles :: Ray [Triangle] IntersectionRecord -> (Bool, IntersectionRecord)
IntersectRayTriangles ray_ triList initRec = IntersectRayTriangles2 ray_ triList (False, initRec)

IntersectRayTriangles2 :: Ray [Triangle] (Bool, IntersectionRecord) -> (Bool, IntersectionRecord)
IntersectRayTriangles2 _ [] rec_ = rec_
IntersectRayTriangles2 ray_ [hTri:tTri] (bool_, irec_)
| newIRec.t_ > 0.0 && newIRec.t_ < irec_.t_ && newBool == True = IntersectRayTriangles2 ray_ tTri (newBool, newIRec)
= IntersectRayTriangles2 ray_ tTri (bool_, irec_)
	where
		newIntersect = ray_ intersect hTri
		newIRec = snd newIntersect
		newBool = fst newIntersect

//Start = 1
