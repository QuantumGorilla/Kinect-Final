class ParticleSystem {
  ArrayList<Particle> particles;

  PShape particleShape;

    //n = número de particulas que tiene el sistema
  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();
    particleShape = createShape(PShape.GROUP); //Crea un PShape
    
    
    //Añade las n particulas que se mandaron 
    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p); //Añade particulas p
      particleShape.addChild(p.getShape()); //Añade PShapes
    }
  }


  //Actualiza la particula
  void update() {
    for (Particle p : particles) {
      p.update(); //Del array actualiza la particula p
    }
  }


  //Cuando la particula muere lo revive, esto se sabe por su posición X, Y
  void setEmitter(float x, float y) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }
  
  //Muestra la PShape
  void display() {
    shape(particleShape); //El PShape toma la forma de la ParticleShape 
  }
}
