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

:: Vector2 a = {v0 :: a, v1 :: a}

instance ==   (Vector2 a) | == a
instance zero (Vector2 a) | zero a
instance one  (Vector2 a) | one a
instance ~    (Vector2 a) | ~ a
instance +    (Vector2 a) | + a
instance -    (Vector2 a) | - a
instance *    (Vector2 a) | * a
instance /    (Vector2 a) | / a