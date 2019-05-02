implementation module Triangle

import StdEnv
import VectorOverloading
import Ray
import IntersectionRecord

EPSILON = 0.0000001
EMPTYINTERSECTRECORD = {t_ = 0.0, position_ = {x0=0.0, x1=0.0, x2=0.0}, normal_ = {x0=0.0, x1=0.0, x2=0.0}, color_ = {x0=255, x1=255, x2=255}}

//Start = EMPTYINTERSECTRECORD

:: Triangle = {colorT_ :: (Vector3 Int), a_ :: (Vector3 Real), b_ :: (Vector3 Real), c_ :: (Vector3 Real)}

(intersect) :: Ray Triangle -> (Bool, IntersectionRecord)
(intersect) ray triangle
| a > ~1.0 * EPSILON && a < EPSILON = (False, EMPTYINTERSECTRECORD)
= ray intersect2 triangle
	where
		edge1 = triangle.b_ - triangle.a_
		edge2 = triangle.c_ - triangle.a_
		h = Vec3crossProduct ray.direction_ edge2
		a = Vec3dotProduct edge1 h
		
(intersect2) :: Ray Triangle -> (Bool, IntersectionRecord)
(intersect2) ray triangle
| u < 0.0 || u > 1.0 = (False, EMPTYINTERSECTRECORD)
= ray intersect3 triangle
	where
		edge1 = triangle.b_ - triangle.a_
		edge2 = triangle.c_ - triangle.a_
		h = Vec3crossProduct ray.direction_ edge2
		a = Vec3dotProduct edge1 h
		f = 1.0/a
		s = ray.origin_ - triangle.a_
		u = f * (Vec3dotProduct s h)

(intersect3) :: Ray Triangle -> (Bool, IntersectionRecord)
(intersect3) ray triangle
| v < 0.0 || u + v > 1.0 = (False, EMPTYINTERSECTRECORD)
= ray intersect4 triangle
	where
		edge1 = triangle.b_ - triangle.a_
		edge2 = triangle.c_ - triangle.a_
		h = Vec3crossProduct ray.direction_ edge2
		a = Vec3dotProduct edge1 h
		f = 1.0/a
		s = ray.origin_ - triangle.a_
		u = f * (Vec3dotProduct s h)
		q = Vec3crossProduct s edge1
		v = f * (Vec3dotProduct ray.direction_ q)
		

(intersect4) :: Ray Triangle -> (Bool, IntersectionRecord)
(intersect4) ray triangle
| t > EPSILON = (True, {t_ = t, position_ = ray.origin_, normal_ = ray.direction_, color_ = triangle.colorT_ })
= (False, EMPTYINTERSECTRECORD)
	where
		edge1 = triangle.b_ - triangle.a_
		edge2 = triangle.c_ - triangle.a_
		h = Vec3crossProduct ray.direction_ edge2
		a = Vec3dotProduct edge1 h
		f = 1.0/a
		s = ray.origin_ - triangle.a_
		u = f * (Vec3dotProduct s h)
		q = Vec3crossProduct s edge1
		v = f * (Vec3dotProduct ray.direction_ q)
		t = f * (Vec3dotProduct edge2 q)
		
testTriangle = {colorT_ = {x0=255,x1=255,x2=255}, a_ = {x0=1.0,x1=2.0,x2=2.0}, b_ = {x0=3.0,x1=3.0,x2=3.0}, c_ = {x0=4.0,x1=5.0,x2=4.0}}
testRay = {origin_ = {x0=0.0,x1=0.0,x2=0.0}, direction_ = {x0=1.0,x1=1.0,x2=1.0}}

//Start:: (Vector3 Int)
//Start = testTriangle.colorT_
//Start = testTriangle.b_
Start = testRay intersect testTriangle