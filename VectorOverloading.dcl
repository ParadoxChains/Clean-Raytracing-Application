definition module VectorOverloading

import StdEnv

:: Vector3 a = {x0 :: a, x1 :: a, x2 :: a}

instance ==   (Vector3 a) | == a
instance zero (Vector3 a) | zero a
instance one  (Vector3 a) | one a
instance ~    (Vector3 a) | ~ a
instance +    (Vector3 a) | + a
instance -    (Vector3 a) | - a
instance *    (Vector3 a) | * a
instance /    (Vector3 a) | / a

Vec3dotProduct :: (Vector3 a) (Vector3 a) -> a  | *,+ a
Vec3crossProduct ::  (Vector3 a) (Vector3 a) ->  (Vector3 a) | *,-a
Vec3normalize :: (Vector3 a) ->  (Vector3 a) | sqrt,*,+,/ a

:: Vector2 a = {v0 :: a, v1 :: a}

instance ==   (Vector2 a) | == a
instance zero (Vector2 a) | zero a
instance one  (Vector2 a) | one a
instance ~    (Vector2 a) | ~ a
instance +    (Vector2 a) | + a
instance -    (Vector2 a) | - a
instance *    (Vector2 a) | * a
instance /    (Vector2 a) | / a

:: Matrix3 a = {a0 :: a, a1 :: a, a2 :: a, b0 :: a, b1 :: a, b2 :: a, c0 :: a, c1 :: a, c2 :: a}

Mat3determinant :: (Matrix3 a) -> a | *,-,+ a

Mat3Vec3Product :: (Matrix3 a) (Vector3 a) -> (Vector3 a) | *,+a
