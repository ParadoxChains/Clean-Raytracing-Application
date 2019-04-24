implementation module PinHoleCamera

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
    onb_ :: ONB}


initCamera :: Real Real Real Real Real (Vector2 Int) (Vector3 Real) (Vector3 Real) (Vector3 Real) -> PinHoleCamera
initCamera minX maxX minY maxY distance resolution position up lookAt = { minX_ = minX, 
    maxX_ = maxX, minY_ = minY, maxY_ = maxY, distance_ = distance, resolution_ = resolution,
    position_ = position, up_ = up, lookAt_ = lookAt,
    direction_ = direction,
    onb_ = setFromUW (Vec3normalize (Vec3crossProduct up revDirection)) revDirection }

    where
        revDirection = ~direction
        direction = Vec3normalize (lookAt - position)

// TODO: Implement MultMatVec method
getWorldSpaceRay :: PinHoleCamera (Vector2 Int) -> Ray
getWorldSpaceRay camera coords = {origin_ = camera.position_, direction_ = Vec3normalize (MultMatVec camera.onb_.m_ s)}

where
    s = {x0 = u * a + camera.minX_, x1 = v * b - camera.minY_, x2 = c}
    
    // TODO: Convert Int division into float division
    u = coords.v0 / camera.resolution_.v0
    v = coords.v1 / camera.resolution_.v1
    
    a = camera.maxX_ - camera.minX_
    b = ~( camera.maxY_ - camera.minY_ )
    c = ~camera.distance_

// Start = initCamera (~1.25) (1.25) (~1.25) (1.25) (3.0) ({v0 = 512, v1 = 512}) ({x0 = 0.0, x1 = 0.0, x2 = 350.0}) ({x0 = 0.0, x1 = 1.0, x2 = 0.0}) ({x0 = 0.0, x1 = 0.0, x2 = ~1.0})