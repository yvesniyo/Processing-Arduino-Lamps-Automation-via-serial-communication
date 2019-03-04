import processing.serial.*;

Serial port;

PImage img,On,Off;


String state="";

int y=200;
int x=90;

boolean lamp1State=false;
boolean lamp2State=false;

void setup(){
  size(400,400);
  On=loadImage("bulbOn.png");
  Off=loadImage("bulbOf.png");
 
  frameRate(10);
  printArray(Serial.list());
  port=new Serial(this,Serial.list()[1],9600);
  
  
}

void draw(){
  background(0,100,255);
  smooth();
  img=loadImage("logo.jpg");
  
  //image(img,10,-120);
  noStroke();
  fill(0,100,255);
  rect(0,0,400,100);
  stroke(255);
  line(0,100,width,100);
  line(0,height-50,width,height-50);
  textSize(15);
  textAlign(CENTER);
  fill(255);
  text("We Are The DMA,Best Quality our concern",width/2,height-20);
  textAlign(LEFT);
  textSize(25);
  fill(255);
  text("Lamp Management System",30,40);
  textSize(12);
  text("Using Arduino And Processing USB",80,70);


  
  if(port.available()>0){    
    state=port.readString();
    println(state);
  }
  
  if(state.indexOf("lamp1=on")!=-1){
    lamp1State=true;
  }
  if(state.indexOf("lamp1=off")!=-1){
    lamp1State=false;
  }
  if(state.indexOf("lamp2=on")!=-1){
    lamp2State=true;
  }
  if(state.indexOf("lamp2=off")!=-1){
    lamp2State=false;
  }
  
  
  
  if(mousePressed){
    if(mouseX>=x && mouseX<=x+100 && mouseY>=y && mouseY<=y+40){
      lamp1State=!lamp1State;
      println("Lamp1:"+lamp1State);
      port.write("Lamp1:"+lamp1State);
    }else if(mouseX>=x+120 && mouseX<=x+220 && mouseY>=y && mouseY<=y+40){ 
      lamp2State=!lamp2State;
      println("Lamp2:"+lamp2State);
      port.write("Lamp2:"+lamp2State);
    }
    delay(50);
  }
  //fill(255,0,0);
  if(lamp1State){
    noFill();
    image(On,x+25,y+50);
    fill(255,127,0);
    
  }else{
    noFill();
    image(Off,x+25,y+50);
    fill(0,170,0);
    
  }
  rect(x,y,100,40);
  
  if(lamp2State){
    noFill();
    image(On,x+120+25,y+50);
    fill(255,127,0);
    
  }else{
    noFill();
    image(Off,x+120+25,y+50);
    fill(0,170,0);
    
  }
  rect(x+120,y,100,40);
  textSize(25);
  fill(255);
  text("Lamp 1",x+4,y+30);
  text("Lamp 2",x+124,y+30);
  
}

void mouseMoved(){
    if(mouseX>=x && mouseX<=x+100 && mouseY>=y && mouseY<=y+40){
       cursor(HAND);
    }else if(mouseX>=x+120 && mouseX<=x+220 && mouseY>=y && mouseY<=y+40){ 
       cursor(HAND);
    }else{
      cursor(ARROW);
    }
}