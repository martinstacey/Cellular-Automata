//DISPLAY
void display() {
  nButX = 4;                                                                    //Number of buttons in X 
  nButY = 6;                                                                    //Number of buttons in Y 
  sButX = 1000/nButX;                                                           //Size of buttons in X 
  sButY = 25;                                                                   //Size of buttons in Y
  background(255); 
  String[][] t = {                                                              //Array of String with Texts
    {"TYPE OF CA", "2D-CA", "3D-CA Von Neumann", "Game of Life"},               //Titles
    {"RULE (DEC) OR CREATURE", "Previous", str(in[0]), "Next"},                  //Number of rule
    {"INDIVIDUAL CELL SIZE", "Previous", str(in[1]), "Next"}, 
    {"NUMBER OF CELLS X-X", "Previous", str(in[2]), "Next"}, 
    {"NUMBER OF CELLS Z-Z", "Previous", str(in[3]), "Next"}, 
    {"NUMBER OF CELLS Y-Y", "Previous", str(in[4]), "Next"}, 
  };
  
  if (in[5]==2&&in[0]%3==0) t [1][2] = "GLIDER";                                   //ONLY CHANGE NAMES IN GAME OF LIFE
  if (in[5]==2&&in[0]%3==1) t [1][2] = "STABLE";
  if (in[5]==2&&in[0]%3==2) t [1][2] = "BOMB";
  
  for (int i=0; i<nButX; i++) {                                                  //Button Display
    for (int j=0; j<nButY; j++) {
      if (in[5]==i-1&&j==0) fill (220, 220, 220);                               //Highlight Type of CA Applied (Keep it Highlighted)
      else if ((i==1||i==3)&&!(j==0)&&mouseX>sButX*i && mouseX<sButX*(i+1)&& mouseY>sButY*j && mouseY<sButY*(j+1))  fill(220, 220, 220);  //Highlight Previous and Next if mouse is over the button
      else fill (255);                                                          //Paint White if previous statements are false
      rect(sButX*.5+(i*sButX), sButY*.5+(j*sButY), sButX, sButY);               //Draw Rectangle
      fill(0);
      text (t[j][i], sButX*(i+.5), sButY*(j+.5), 0);                            //Write Text
    }
  }
}
void click() {
  for (int i=0; i<3; i++) if (mouseX>sButX*(i+1) && mouseX<sButX*(i+2) && mouseY>0 && mouseY<sButY) in[5] = i;          //Selects Type of CA
  for (int i=0; i<nButY; i++) if (mouseX>sButX*1 && mouseX<sButX*2 && mouseY>sButY*(i+1) && mouseY<sButY*(i+2))in[i]--; //If Previous is Clicked substract Condition
  for (int i=0; i<nButY; i++) if (mouseX>sButX*3 && mouseX<sButX*4 && mouseY>sButY*(i+1) && mouseY<sButY*(i+2))in[i]++; //If Next is Clicked add Condition
  gl.input(in[0], in[1], in[2], in[3], in[4]);

}