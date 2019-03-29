# CLEANRaytracer

Project conducted by the Functional Programming Research Team at Eotvos Lorand University, Hungary. Responsible Professor: Zsók Viktória.

## Task Division

### Available Modules

1. Buffer type definition which has the objective of storing the data as every pixel is processed; and has a method to write the rendering result to a ppm file. (pre-requisite: Vec3 type definition)
```c++
class Buffer
{
public:
    Buffer( unsigned int h_resolution,
            unsigned int v_resolution );
    ~Buffer( void );

    void save( const std::string &filename ) const;

    unsigned int h_resolution_ = 512;
    unsigned int v_resolution_ = 512;

    std::vector< std::vector< glm::vec3 > > buffer_data_;
};
```

2. ONB type definition (pre-requisites: Mat3x3, Vec3 type definitions, Vec3 cross product and normalize method)

```c++
class ONB{
public:

    ONB( void );

    void setFromV( const glm::vec3 &v );
    void setFromUW( const glm::vec3 &u,
                    const glm::vec3 &w );
    glm::mat3x3 getBasisMatrix( void ) const
    {return m_;}

    glm::vec3 u_ = { 1.0f, 0.0f, 0.0f };
    glm::vec3 v_ = { 0.0f, 1.0f, 0.0f };
    glm::vec3 w_ = { 0.0f, 0.0f, 1.0f };

private:

    void setBasisMatrix( void );

    glm::mat3x3 m_;
};
```

3. PinHoleCamera type definition (pre-requisites: ONB,Vec3, and Vec2 type definitions, Vec3 normalize method)
```c++
class PinHoleCamera{
public:

    PinHoleCamera( const float min_x,
                       const float max_x,
                       const float min_y,
                       const float max_y,
                       const float distance,
                       const glm::vec2 &resolution,
                       const glm::vec3 &position,
                       const glm::vec3 &up_vector,
                       const glm::vec3 &look_at );
    
    void setPosition( const glm::vec3 &position );
    void setUp( const glm::vec3 &up );
    void setLookAt( const glm::vec3 &look_at );
    Ray getWorldSpaceRay( const glm::vec2 &pixel_coord ) const;

private:

    glm::vec2 resolution_;
    glm::vec3 up_{ 0.0f, 1.0f, 0.0f };
    glm::vec3 look_at_{ 0.0f, 0.0f, -1.0f };
    glm::vec3 position_{ 0.0f, 0.0f, 0.0f };
    glm::vec3 direction_{ 0.0f, 0.0f, -1.0f };
    ONB onb_;
    float min_x_;
    float max_x_;  
    float min_y_;
    float max_y_;
    float distance_;
};
```

### Pedro
* Ray type definition;
* IntersectionRecord type definition;
* Whatever module which hasn't been picked by anybody else :)

### Evan
* Triangle type definition, including intersection Ray-Triangle.
```c++
class Triangle{
    Triangle( glm::vec3 color, const glm::vec3 &a, const glm::vec3 &b, const glm::vec3 &c);
    
    bool intersect( const Ray &ray,
                   IntersectionRecord &intersection_record ) const;
    
    
    glm::vec3 color_ = {0.0f, 0.0f, 0.0f};
    glm::vec3 a_ = { 0.0f, 0.0f, 0.0f };
    glm::vec3 b_ = { 0.0f, 0.0f, 0.0f };
    glm::vec3 c_ = { 0.0f, 0.0f, 0.0f };
};
```

### Yuri
* Vec2 type definition;
* Vec3 type definition;
    * Implementation of dot and cross products for Vec3;
    * Implementation of normalize() : Vec3 -> Vec3 method;
* Mat3x3 type definition;
    * Implementation of determinant of 3x3 matrices.

### All
* Raytracing module: responsible for calculating the rendering of the scene for every pixel (pre-requisite all other modules)
    1. Scene intersection Ray-Triangles;
    1. Modules Orchestration.