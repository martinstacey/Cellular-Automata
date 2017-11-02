class GaLi {                                                              // GAME OF LIFE 3D
  int cellSize, nCellsX, nCellsZ, nCellsY, tCreat;                        //Cell size,# Cells X,# Cells Z, # Cells Y, Initial Creature                                                                                              
  float xpos, ypos, zpos;                                                 //Position of Array
  int  preState [][][], newState[][][];                                   //Contaits State and Next State for X Y Z 
  int life []=new int [3];                                                //Contains conditions for life Ex: Life 4556

  GaLi(float tempxpos, float tempypos, float tempzpos) {                        //Initial Position of Array
    xpos = tempxpos;                                                  
    zpos = tempzpos;
    ypos = tempypos;
  }
  void input(int tempCreat, int tempcellSize, int tempnCellsX, int tempnCellsZ, int tempnCellsY) {    //Imput Initial Conditions
    cellSize=tempcellSize;
    nCellsX=tempnCellsX;
    nCellsZ=tempnCellsZ;
    nCellsY=tempnCellsY;
    preState = new int[nCellsX][nCellsZ][nCellsY];                        //Set size of Arrays in relation to number of cells
    newState = new int[nCellsX][nCellsZ][nCellsY];
     
    tCreat=tempCreat%3;                                                   //Creature Imported (Either 0,1,2)

    for (int y=0; y<nCellsY; y++) {                                       //For every cell in the array turn on the following boxes
      for (int z=0; z<nCellsZ; z++) {
        for (int x=0; x<nCellsX; x++) {         
          if (tCreat==0) {                                               //CREATURE 0= 3D GLIDER 
            if ((x>0)&&(x<4&&z<2&&y==2)||(x==3&&z<2&&y==1)||(x==2&&z<2&&y==0)) preState [x][z][y]=1;       //Turn on the following cells.
            else if ((x>nCellsX-4&&z<2&&y==2)||(x==nCellsX-3&&z<2&&y==1)||(x==nCellsX-2&&z<2&&y==0)) preState [x][z][y]=1;       //Turn on the following cells.
            else if (x==nCellsX/2&&z==0&&y==0) preState [x][z][y]=1;
            else preState [x][z][y]=0;                                    // Turn Off the rest of the cells. 
            for (int i=0; i<life.length; i++) life[i]  = 5+i;             // Type of life 4556- 456
          }
          if (tCreat==1) {                                                //CREATURE 1 = 3d  STABLES Rule 4556
            if (x<nCellsX/2&&x>nCellsX/2-4&&z<2&&y==2) preState [x][z][y]=1;                     //Stable Creature 1                                       
            else if (x<nCellsX/2&&x>nCellsX/2-4&&z<2&&y==(nCellsY-2)) preState [x][z][y]=1; //Stable Creature 2
            else if (x<nCellsX/2&&x>nCellsX/2-4&&x>0&&z<3&& y<nCellsY/2&&y>(nCellsY/2-3)) preState [x][z][y]=1; 
            else preState [x][z][y]=0;                                   // Turn Off the rest of the cells.
            for (int i=0; i<life.length; i++) life[i]  = 5+i;            // Type of life 4556- 456
          }    
          if (tCreat==2) {                                                // CREATURE 2 = Bomb
            if (x<(nCellsX/2)&&x>(nCellsX/2-3)&&z<(3)&&z>(0)&&y==4) preState [x][z][y]=1; 
            else preState [x][z][y]=0;                                   // Turn Off the rest of the cells
           
            life[0]  = 4;
            life[1]  = 4;
            life[2]  = 5;
          }
        }
      }
    }
  }
  void operate() {                                                       //Operate: For Every Cell
    for (int y=0; y<nCellsY; y++) {
      for (int z=0; z<nCellsZ; z++) {
        for (int x=0; x<nCellsX; x++) { 
          int lCells=0;                                                 //Start over alive Cell Count for every Cell
          for (int p=-1; p<=1; p++) {                                   //For Every Cell from -1 to +1 excluding itself
            for (int n=-1; n<=1; n++) {                                 //Count Live Cells
              for (int m=-1; m<=1; m++) {
                if (!(m==0 &&n==0&&p==0)) {
                  if (preState[(x+m+nCellsX)%nCellsX][(z+n+nCellsZ)%nCellsZ][(y+p+nCellsY)%nCellsY]==1) lCells++;
                }
              }
            }
          }
          if (lCells <life[0] ||  lCells>life[2]) newState[x][z][y] = 0;  // set new State According to rule 
          else if (lCells == life[1]) newState[x][z][y] = 1;              
          else newState[x][z][y] = preState[x][z][y];
          pushMatrix();                                                                                                               
          translate((x*cellSize)+xpos, (y*cellSize)+ypos, (z*cellSize)+zpos); //Translate to x y z position         
          fill(255);
          if (preState[x][z][y]==1)box(cellSize);                             //Draw all Turned on Boxes
          popMatrix();
        }
      }
    }
    for (int x=0; x<nCellsX; ++x)for (int z=0; z<nCellsZ; ++z)for (int y=0; y<nCellsY; y++) preState[x][z][y] = newState[x][z][y]; //Make all previous cells new cells
  }
}