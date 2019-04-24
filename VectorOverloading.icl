implementation module VectorOverloading

import StdEnv
import StdDebug


:: Vector2 a = {v0 :: a, v1 :: a}

instance ==   (Vector2 a) | == a   where == vector0 vector1	= vector0.v0 == vector1.v0 && vector0.v1 == vector1.v1

instance zero (Vector2 a) | zero a where zero	= {v0 = zero, v1 = zero}

instance one  (Vector2 a) | one a  where one 	= {v0 = one, v1 = one}

instance ~    (Vector2 a) | ~ a    where ~ vector0	= {v0 = ~vector0.v0, v1 = ~vector0.v1}

instance +    (Vector2 a) | + a    where + vector0 vector1	= {v0 = (vector0.v0 + vector1.v0), v1 = (vector0.v1 + vector1.v1)}

instance -    (Vector2 a) | - a    where - vector0 vector1	= {v0 = (vector0.v0 - vector1.v0), v1 = (vector0.v1 - vector1.v1)}

instance *    (Vector2 a) | * a    where * vector0 vector1	= {v0 = (vector0.v0 * vector1.v0), v1 = (vector0.v1 * vector1.v1)}

instance /    (Vector2 a) | / a    where / vector0 vector1	= {v0 = (vector0.v0 / vector1.v0), v1 = (vector0.v1 / vector1.v1)}

//Start	= {v0 = 5, v1 = 6} + one


:: Vector3 a = {x0 :: a, x1 :: a, x2 :: a}

instance ==   (Vector3 a) | == a   where == vector0 vector1	= vector0.x0 == vector1.x0 && vector0.x1 == vector1.x1 && vector0.x2 == vector1.x2

instance zero (Vector3 a) | zero a where zero	= {x0 = zero, x1 = zero, x2 = zero}

instance one  (Vector3 a) | one a  where one 	= {x0 = one, x1 = one, x2 = one}

instance ~    (Vector3 a) | ~ a    where ~ vector0	= {x0 = ~vector0.x0, x1 = ~vector0.x1, x2 = ~vector0.x2}

instance +    (Vector3 a) | + a    where + vector0 vector1	= {x0 = (vector0.x0 + vector1.x0), x1 = (vector0.x1 + vector1.x1), x2 = (vector0.x2 + vector1.x2)}

instance -    (Vector3 a) | - a    where - vector0 vector1	= {x0 = (vector0.x0 - vector1.x0), x1 = (vector0.x1 - vector1.x1), x2 = (vector0.x2 - vector1.x2)}

instance *    (Vector3 a) | * a    where * vector0 vector1	= {x0 = (vector0.x0 * vector1.x0), x1 = (vector0.x1 * vector1.x1), x2 = (vector0.x2 * vector1.x2)}

instance /    (Vector3 a) | / a    where / vector0 vector1	= {x0 = (vector0.x0 / vector1.x0), x1 = (vector0.x1 / vector1.x1), x2 = (vector0.x2 / vector1.x2)}


Vec3dotProduct :: (Vector3 a) (Vector3 a) -> a  | *,+ a
Vec3dotProduct x y = z.x0 + z.x1 + z.x2
where z = x * y

Vec3crossProduct ::  (Vector3 a) (Vector3 a) ->  (Vector3 a) | *,-a
Vec3crossProduct x y = {x0 = x.x1 * y.x2 - x.x2*y.x1, x1 = x.x2*y.x0 - x.x0*y.x2, x2 = x.x0*y.x1 - x.x1*y.x0}

Vec3normalize :: (Vector3 a) ->  (Vector3 a) | sqrt,*,+,/ a
Vec3normalize x = {x0 = x.x0/sqrt (Vec3dotProduct x x), x1 = x.x1/sqrt (Vec3dotProduct x x), x2 = x.x2/sqrt (Vec3dotProduct x x)}
//Start = Vec3normalize  {x0 = 3.0, x1 = 3.0, x2 = 3.0} 

//Start = Vec3crossProduct {x0 = 1.5, x1 = 2.6, x2 = 3.0} {x0 = 5.0, x1 = 2.6, x2 = 4.5} 
//Start = Vec3dotProduct {x0 = 1.5, x1 = 2.6, x2 = 3.0} {x0 = 5.0, x1 = 2.6, x2 = 4.5} 


:: Matrix3 a = {a0 :: a, a1 :: a, a2 :: a, b0 :: a, b1 :: a, b2 :: a, c0 :: a, c1 :: a, c2 :: a}

Mat3determinant :: (Matrix3 a) -> a | *,-,+ a
Mat3determinant x = x.a0*(x.b1*x.c2 - x.b2*x.c1) - x.a1*(x.b0*x.c2 - x.b2*x.c0) + x.a2*(x.b0*x.c1 - x.b1*x.c0)

// Start = Mat3determinant {a0=6, a1=1, a2=1, b0 =4, b1=(-2), b2=5, c0=2, c1=8, c2=7}

Mat3Vec3Product :: (Matrix3 a) (Vector3 a) -> (Vector3 a) | *,+a
Mat3Vec3Product m v = {x0 = m.a0*v.x0 + m.a1*v.x1 + m.a2*v.x2, x1 = m.b0*v.x0 + m.b1*v.x1 + m.b2*v.x2, x2 = m.c0*v.x0 + m.c1*v.x1 + m.c2*v.x2}

//Start = Mat3Vec3Product {a0=1, a1=1, a2=2, b0 =2, b1=1, b2=3, c0=1, c1=4, c2=2}  {x0 = 3, x1 = 1, x2 = 2} 
