# Cellular-Automata

//                 CELULAR AUTOMATA- MARTIN STACEY                            //VARIABLES
int []in= {0, 20,40, 40, 30, 0};                                             //INITIAL CONDITIONS: Rules[0],Cell Size[1],No. CellsX[2],No. CellsZ[3],No. CellsY[4],Type[5]
PVector iPos=new PVector (0, 0, 0);                                             //Initial Position of array
int nButX, nButY, sButX, sButY;                                             //No. ButtonsX, Number ButtonsY  //Size ButtonsX //Size ButtonsY                                                                            
int camX,camY,camZ;
//CLASSES:TYPES OF CAs
GaLi gl = new GaLi(iPos.x-400, iPos.y, iPos.z);                                   //Game of Life         

void setup() {                                                                
  size(1000, 1000, P3D);                 
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  frameRate(15);
}
void draw() {                                 
  display();                                                                  //2D button display
  pushMatrix();                                                               //Matrix
  camera(mouseX-500+camX, mouseY-500, height-camZ, camX, 200, -camY, 0, 1, 0);
  if (in[5]==0) {                                                             //TYPE 1 = CELLULAR ATOMATA 2D
    CelAut ca = new CelAut(in[0], in[1], in[2], in[3]);                       //Rules[0],Cell Size[1],Number of CellsX[2],Number of CellsZ[3]
    ca.initialstate(iPos.x, iPos.y, iPos.z);                                  //initialstate = input X Y Position
    ca.operate();                                                             //Operate
  } else if (in[5]==1) {                                                        //TYPE 2 = CELULLAR ATOMATA 3D
    CelAut3d ca3d = new CelAut3d(in[0], in[1], in[2], in[3], in[4]);          //Rules[0],Cell Size[1],Number of CellsX[2],Number of CellsZ[3],Number of CellsY[4]
    ca3d.initialstate(iPos.x, iPos.y, iPos.z);                                //in X Y Position
    ca3d.operate();                                                           //Operate
  } else if (in[5]==2) gl.operate();
  popMatrix();
  
  
   saveFrame("movie/####.png");
}
void mousePressed() {
  click();
}
void keyPressed(){
    if(keyCode==LEFT) camX-=25;
    if(keyCode==RIGHT) camX+=25;
    if(keyCode==UP) camZ+=25;
    if(keyCode==DOWN) camZ-=25;
}
