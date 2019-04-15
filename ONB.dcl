definition module ONB
import VectorOverloading
import StdEnv

// The default ONB is the standard orthonormal basis.
u_ ::Vector3 Real

v_ ::Vector3 Real

w_ ::Vector3 Real

m_ ::Matrix3 Real


/**
 * Set up an ONB from the normalized input vectors 'u' and 'w', that will be assumed to be aligned to
 * the vectors 'u' (right) and 'w' vectors of the ONB to be created.
 *
 * Input:  vector 'u' and 'w'
 * Output: ONB basis matrix 
 * 
 * Example: setFromUW  {x0 = 0.0, x1 =  0.0,  x2 = 1.0}  {x0 = 0.0, x1 =  1.0,  x2 = 0.0}
 * Output: (Matrix3 0 -1 0 0 0 1 1 0 0)
*/
setFromUW:: (Vector3 Real) (Vector3 Real) -> (Matrix3 Real) 



/**
 * Set up an ONB from an normalized input vector 'v' that will be assumed to be aligned to
 * the 'v' (up) vector of the ONB to be created.
 * 
 * Input:  vector 'v'
 * Output: ONB basis matrix 
 * 
 * Example: setFromV  {x0 = ~5.5, x1 =  0.0,  x2 = 0.0}
 * Output: (Matrix3 0 -1 0 -1 0 0 0 0 1)
*/

setFromV::(Vector3 Real) -> (Matrix3 Real) 


//!!! note: u,v,w are column 0,1,2 of base matrix
//!!! when read matrix from Matrix3 array, it is read row by row.
