module Raytracer

import StdEnv
import Buffer
import IntersectionRecord
import Ray
import PinHoleCamera
import RayTriangleIntersector
import VectorOverloading

MAX_REAL =: 999999999999.9

// buffer :: [[Vector3 Real]]
// buffer = InitBuffer resolution.v0 resolution.v1

resolution :: Vector2 Int
resolution = {v0 = 128, v1 = 128}

camera_position :: Vector3 Real
camera_position = {x0 = 20.0, x1 = 20.0, x2 = 20.0}
//camera_position = {x0 = 0.0, x1 = 0.0, x2 = 6.0}

camera_up :: Vector3 Real
camera_up = {x0 = 0.0, x1 = 1.0, x2 = 0.0}

camera_lookAt :: Vector3 Real
camera_lookAt = {x0 = 0.0, x1 = 0.0, x2 = ~1.0}

camera :: PinHoleCamera
camera = initCamera (~1.25) 1.25 (~1.25) 1.25 3.0 (resolution) (camera_position) (camera_up) (camera_lookAt)


// DONE: Load triangles from file
//SetBuffElem :: [[Vector3 Real]] Int Int (Vector3 Real) -> [[Vector3 Real]]

// Y LOOP IS FLIPPED -> TEMPORARY SOLUTION
integrate resolution triangles = [[integrate2 j i triangles \\i<-[1..x]]\\j<-[y,y-1..1]]
    where
        x = resolution.v0
        y = resolution.v1

// integrate :: height width 
integrate2 :: Int Int [Triangle] -> Vector3 Real
integrate2 y x triangles
| result = {x0 = toReal record.color_.x0 , x1 = toReal record.color_.x1, x2 = toReal record.color_.x2}
= {x0= 0.0, x1= 0.0, x2= 0.0}
where
    initialIR = {t_ = MAX_REAL, position_ = {x0 = 0.0, x1 = 0.0, x2 = 0.0}, normal_ = {x0 = ~1.0, x1 = ~1.0, x2 = ~1.0}, color_ = {x0=0.0, x1=0.0, x2=0.0}}
    //initialRay = getWorldSpaceRay camera {v0 = 0.5 + (toReal x) , v1 = 0.5 + (toReal y) }
    initialRay = getWorldSpaceRay camera {v0 = x , v1 = y }
    //triangle = {colorT_ = {x0 = 1.0, x1 = 0.0, x2 = 0.0}, a_ = {x0 = 2.0, x1 = 0.0, x2 = 0.0}, b_ = {x0 = 0.0, x1 = 2.0, x2 = 0.0}, c_ = {x0 = ~2.0, x1 = 0.0, x2 = 0.0}}
    // triangle = {colorT_ = {x0 = 1.0, x1 = 0.0, x2 = 0.0}, a_ = {x0 = 2.0, x1 = 0.0, x2 = 0.0}, b_ = {x0 = 0.0, x1 = ~2.0, x2 = 0.0}, c_ = {x0 = ~2.0, x1 = 0.0, x2 = 0.0}}
    //triangles = [ triangle ]
    (result, record) = IntersectRayTriangles initialRay triangles initialIR

// Should increase the heap size of the project (Project -> Project options)
// Initially, it is 2MB
Start w
# (triangles, w) = LoadObj ("Mesh/" +++ inp +++ ".obj") w
= SaveToPPM (integrate resolution triangles) (inp +++ ".ppm") w
//= SaveToPPM (integrate resolution) "test.ppm" w
where
	inp = "airboat"
