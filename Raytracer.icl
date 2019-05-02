
import ELTE_Buffer
import IntersectionRecord
import Ray
import PinHoleCamera
import VectorOverloading
import StdEnv

MAX_REAL =: 999999999999.9

buffer :: [[Vector3 Real]]
buffer = InitBuffer resolution.v0 resolution.v1

resolution :: Vector2 Int
resolution = {v0 = 512, v1 = 512}

camera_position :: Vector3 Real
camera_position = {x0 = 0.0, x1 = 0.0, x2 = 350.0}

camera_up :: Vector3 Real
camera_up = {x0 = 0.0, x1 = 1.0, x2 = 0.0}

camera_lookAt :: Vector3 Real
camera_lookAt = {x0 = 0.0, x1 = 0.0, x2 = ~1.0}

camera :: PinHoleCamera
camera = initCamera ~1.25 1.25 ~1.25 1.25 3.0 resolution camera_position camera_up camera_lookAt


// TODO: Load triangles from file

(integrate)


// integrate :: height width 
(integrate2) :: Int Int -> Vector3 Real
(integrate2) y x
| result = {x0 = toReal record.color_.x0 , x1 = toReal record.color_.x1, x2 = toReal record.color_.x2}
= {v0= 0.0, v1= 0.0, v2= 0.0}
where
    initialIR = {t_ = MAX_REAL, position_ = {x0 = 0.0, x1 = 0.0, x2 = 0.0}, normal_ = {x0 = ~1.0, x1 = ~1.0, x2 = ~1.0}}
    initialRay = getWorldSpaceRay camera {v0 = 0.5 + x, v1 = 0.5 + y}
    (result, record) = EVAN_FUNCTION initialRay initialIR

