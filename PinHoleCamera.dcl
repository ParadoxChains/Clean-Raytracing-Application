definition module PinHoleCamera

import StdEnv
import VectorOverloading
import ONB
import Ray

:: PinHoleCamera = { minX_ :: Real,
    maxX_ :: Real,
    minY_ :: Real,
    maxY_ :: Real,
    distance_ :: Real,
    resolution_ :: Vector2 Int,
    position_ :: Vector3 Real,
    up_ :: Vector3 Real,
    lookAt_ :: Vector3 Real,
    direction_ :: Vector3 Real,
    onb_ :: ONB }


// Initializes the camera, given the initial parameters
initCamera :: Real Real Real Real Real (Vector2 Int) (Vector3 Real) (Vector3 Real) (Vector3 Real) -> PinHoleCamera

// Get world space ray, given a pixel coordinate
getWorldSpaceRay :: (Vector2 Int) -> Ray