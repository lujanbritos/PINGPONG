import processing.serial.*;
import cc.arduino.*;

Arduino placa;

float x, y, speedX, speedY;
float diam = 40;
float rectSize = 200;
int puntos = 0;
void setup() {
    placa = new Arduino(this, Arduino.list()[0], 57600);
  //fullScreen();
  placa.pinMode(2, Arduino.INPUT_PULLUP);
  size(800,600);
  fill(0,155 , 155);
  reset();
}

void reset() {
  x = width/2;
  y = height/2;
  speedX = random(6, 5);
  speedY = random(6, 5);
  puntos = 0;
}

void draw() { 
  
 // println(placa.digitalRead(2));
  
  var sensor = map(placa.analogRead(0),0,1023,0,600);
  background(150,0,255);
  
  ellipse(x, y, diam, diam);

  rect(0, 0, 20, height);
  rect(width-30, sensor-rectSize/2, 10, rectSize);

  x += speedX;
  y += speedY;

  if ( x > width-50 && x < width -20 && y > sensor-rectSize/2 && y < sensor+rectSize/2 ) {
    speedX = speedX * -1;
    if(speedX > 0){
      speedX = speedX +1;
    }else{
      speedX = speedX -1;
    }
    puntos++;
  } 

  if (x < 25) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
  }


  if ( y > height || y < 0 ) {
    speedY *= -1;
    if(speedY > 0){
      speedY = speedY +1;
    }else{
      speedY = speedY -1;
    }
  }
  
  if ( x > width && placa.digitalRead(2) == 0){
  println("perdiste :(");
  reset();
  }
  textSize(50);
  fill(0, 408, 612);
  text("Puntaje "+puntos, 40, 80);
  
}

void mousePressed() {
  reset();
}
