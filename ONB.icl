implementation module ONB

import StdEnv
import VectorOverloading

:: ONB = {u_ :: (Vector3 Real), v_ :: (Vector3 Real), w_ :: (Vector3 Real), m_ :: (Matrix3 Real)}

// u_ ::Vector3 Real
// u_ = {x0 = 1.0, x1 = 0.0, x2 = 0.0}

// v_ ::Vector3 Real
// v_ = {x0 = 0.0, x1 = 1.0, x2 = 0.0}

// w_ ::Vector3 Real
// w_ = {x0 = 0.0, x1 = 0.0, x2 = 1.0}



// m_ ::Matrix3 Real
// m_ = { a0 = 1.0, a1 = 0.0, a2 = 0.0
//      , b0 = 0.0, b1 = 1.0, b2 = 0.0
//      , c0 = 0.0, c1 = 0.0, c2 = 1.0 }
    



setFromUW1:: (Vector3 Real) (Vector3 Real) -> ONB 
setFromUW1 u w =  {	u_ = u, v_ = v, w_ = w,
					m_ = { 	a0 = u.x0 , a1 = v.x0 , a2 = w.x0, 
			       			b0 = u.x1 , b1 = v.x1 , b2 = w.x1,
				   			c0 = u.x2 , c1 = v.x2 , c2 = w.x2 }}
		
		where v = Vec3crossProduct u w

setFromUW:: (Vector3 Real) (Vector3 Real) -> ONB
setFromUW u w = setFromUW1 (Vec3normalize u) (Vec3normalize w)

//Start = setFromUW  u_  w_	
//Start = setFromUW  {x0 = 2.0, x1 =  0.0,  x2 = 1.0}  {x0 = 0.0, x1 =  0.0,  x2 = 2.0}


setFromV1::(Vector3 Real) -> ONB 
setFromV1 v  
| abs(v.x0)> abs(v.x1)  = {	u_ = u1, v_ = v, w_ = w1,
							m_ = { 	a0 = u1.x0 , a1 = v.x0 , a2 = w1.x0, 
			       					b0 = u1.x1 , b1 = v.x1 , b2 = w1.x1,
				   					c0 = u1.x2 , c1 = v.x2 , c2 = w1.x2 }}

= {	u_ = u2, v_ = v, w_ = w2,
	m_ = { 	a0 = u2.x0 , a1 = v.x0 , a2 = w2.x0, 
 			b0 = u2.x1 , b1 = v.x1 , b2 = w2.x1,
			c0 = u2.x2 , c1 = v.x2 , c2 = w2.x2 }}
	   
	   where w1 = Vec3normalize {x0 = v.x2, x1 =  0.0,  x2 = ~v.x0}
	   		 w2 = Vec3normalize {x0 = 0.0,  x1 = ~v.x2, x2 = v.x1}
	   		 u1 = Vec3crossProduct w1 v
	   		 u2 = Vec3crossProduct w2 v

setFromV::(Vector3 Real) -> ONB 
setFromV v  = setFromV1 (Vec3normalize v)


//Start = setFromV v_
// Start = setFromV  {x0 = 2.5, x1 =  5.0,  x2 = 1.0} 
	
	

