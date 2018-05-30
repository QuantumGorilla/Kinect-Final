//Imports necesarios para el manejo del Kinect
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

//Creación de variables
ParticleSystem ps;
PImage sprite; 


Kinect kinect;
ArrayList <SkeletonData> bodies;


void setup(){
  size(1024, 768, P2D); //Tamaño de la pantalla
  background(0); //Color de fondo 
  kinect = new Kinect(this); 
  smooth(); //Renderiza la imagen 
  bodies = new ArrayList<SkeletonData>();
  orientation(LANDSCAPE); 
  sprite = loadImage("sprite.png"); //Carga la imagen del sprite
  ps = new ParticleSystem(1000); //Manda el número de particulas que tendrá el sistema
  
  //Para dejar rastro
  stroke(255);
  strokeWeight(5);
}

void draw()
{

  background (0);

  //Dibuja las el esqueleto y la posición
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
  }

  //Worm
}

//Dibuja la posición
void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 0, 0);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}

void drawSkeleton(SkeletonData _s) 
{
  // Dibuja el cuerpo, torso
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HEAD, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER); //Dibuja el "hueso" de la cabeza y el "hueso" del pecho
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT); //Dibuja el "hueso" del pecho y el "hueso" del hombro izquierdo
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT); //Dibuja el "hueso" del pecho y "hueso" del hombro derecho
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, Kinect.NUI_SKELETON_POSITION_SPINE); //Dibuja el "hueso" del pecho y el "hueso" de la "espina dorsal"
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, Kinect.NUI_SKELETON_POSITION_SPINE);//Dibuja el "hueso" del hombro izquierdo y el "hueso" de la "espina dorsal"
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, Kinect.NUI_SKELETON_POSITION_SPINE); //Dibuja el "hueso" del hombro derecho y el "hueso" de "la espina dorsal"
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SPINE, Kinect.NUI_SKELETON_POSITION_HIP_CENTER); //Dibuja el "hueso" del "espina dorsal" y el "hueso" de la cadera
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_CENTER, Kinect.NUI_SKELETON_POSITION_HIP_LEFT); //Dibuja el "hueso" del centro de la cadera y el "hueso" de la parte de la cadera izquierda
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_CENTER, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT); //Dibuja el "hueso" del dentro de la cadera y el "hueso" de la parte de la cadera derecha
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_LEFT, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT); //Dibuja el "hueso" de la parte de la cadera izquierda y el "hueso" de la parte de la cadera derecha 


  // Dibuja el brazo izquierdo
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT); //Dibuja el "hueso" del hombro izquierdo y el "hueso" del codo izquierdo
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT); //Dibuja el "hueso" del codo izquierdo y el "hueso" de la muñeca izquierda 
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, Kinect.NUI_SKELETON_POSITION_HAND_LEFT);  //Dibuja el "hueso" muñeca izquierda y el "hueso" de la mano izquierda
// println("cabeza:"+Kinect.NUI_SKELETON_POSITION_HEAD);
// println("mano:"+Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

//Si La posicion de la mano es menor que la de la cabeza llama al metodo que invoca chispas
  if(Kinect.NUI_SKELETON_POSITION_HEAD<Kinect.NUI_SKELETON_POSITION_HAND_LEFT
  ){
    
    
  german(_s, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, Kinect.NUI_SKELETON_POSITION_HAND_LEFT); //Manda el "hueso" de la muñeca izquierda y la mano izquierda

  }
  
  // Dibuja el brazo derecho
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT); //Dibuja el "hueso" del hombro derecho y el "hueso" del codo derecho
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT); //Dibuja el "hueso" del hombro derecho y el "hueso" de la muñeca derecha
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, Kinect.NUI_SKELETON_POSITION_HAND_RIGHT); //Dibuja el "hueso" del muñeca derecha y el "hueso" de la mano derecha
  

  // Dibuja la pierna izquierda
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_LEFT, Kinect.NUI_SKELETON_POSITION_KNEE_LEFT); //Dibuja el "hueso" de la cadera izquierda y el "hueso" de la rodilla izquierda
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT); //Dibuja el "hueso" de la rodilla izquierda y el "hueso" del tobillo izquierdo
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, Kinect.NUI_SKELETON_POSITION_FOOT_LEFT); //Dibuja el "hueso" del tobillo izquierdo y el "hueso" del pie izquierdo

  // Dibuja la pierna derecha
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT); //Dibuja el "hueso" de la cadera derecha y el "hueso" de la rodilla derecha
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT); //Dibuja el "hueso" de la rodilla derecha y el "hueso" del tobillo derecho
  DrawBone(_s, Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT); //Dibuja el "hueso" del tobillo derecho y el "hueso" del pie derecho
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  //stroke(#336699);
  stroke(255);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width/2, 
      _s.skeletonPositions[_j1].y*height/2, 
      _s.skeletonPositions[_j2].x*width/2, 
      _s.skeletonPositions[_j2].y*height/2);
    rect(_s.skeletonPositions[_j1].x*width/2, _s.skeletonPositions[_j1].y*height/2, 10, 10);
    println("j2: "+_s.skeletonPositions[_j1].y*height/2);
  }
}

//Metodo que se encargara de lanzar el gesto de las chispas cuando se alce el brazo izquierdo más alto de la cabeza
void german(SkeletonData _s, int _j1, int _j2) {

  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    stroke(0);
    ellipse(_s.skeletonPositions[_j1].x*width/2, _s.skeletonPositions[_j1].y*height/2, 55, 55);
    ps.update();
    ps.display();
    ps.setEmitter(_s.skeletonPositions[_j1].x*width/2, _s.skeletonPositions[_j1].y*height/2);
  }
}

//Evento de aparición, si no ha detectado nada, sale del evento sino sincroniza el esqueleto
void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

//Evento de desaparación, cuando deje de detectar cuerpos, desaparece todo
void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}


//Evento de movimiento, si no detecta nada el sensor no muestra nada, sin embargo, si encuentra esqueletos los sincroniza 
void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
