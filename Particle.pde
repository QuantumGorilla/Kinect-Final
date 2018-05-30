class Particle {

  PVector velocity;
  float lifespan = 255;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,0.1);


  Particle() {
    partSize = random(10,60);
    part = createShape();
    part.beginShape(QUAD);//Comienza la construcción de la forma
    part.noStroke();
    part.texture(sprite); //Toma la textura del sprite en el cual se inicializo en la clase Skeleton_Particles
    part.normal(0, 0, 1); //Un vecor de la fuerza normal perpendicular a la superficie de apoyo, en este caso, la superficie de apoyo es el eje x
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();//Finaliza la construcción de la forma
    
    rebirth(width/2,height/2);
    lifespan = random(255); //A la longitud de vida se le asigna un valor aleatorio entre 0 y 255
  }

  PShape getShape() {
    return part;
  }
  
  /*A la aceleración se le da un valor aleteario entre 0 y 2 PI, a este valor se le asigna a la velocidad sacandole en X el coseno y en Y
  el seno, luego se multiplica con la rapidez. El lifespan determina la longitud de vida de la particula
  */
  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y); 
  }
  
   //Comprueba si una particula aun es necesaria que se muestra, en caso de serlo retorna true en caso de que no lo sea retorna false 
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
  
   //Actualiza la particula, reduciendo la longitud de vida, añadiendole a la velocidad la aceleración de la gravedad, trasladando la posición en base a la velocidad
   //El color de la particula se tintura en base a la longitud de vida de la particula 
  public void update() {
    lifespan = lifespan - 1;
    velocity.add(gravity);
    
    part.setTint(color(255,lifespan));
    part.translate(velocity.x, velocity.y);
  }
}
