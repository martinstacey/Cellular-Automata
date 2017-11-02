class CelAut {                                                                               // CELULAR AUTOMATA 1D to 2D
  int cellSize, nCellsX, nGens, dRule, gen;                                                  //Cell size, # Cells X, # Cells Y, Rule in Decimal, Generations                              
  float xpos,ypos,zpos;                                                                      //Position
  int [] bRule = new int[8];                                                                 //Rule Binary (reversed rule number) 
  int preState [], newState [];                                                              //Contains all previous and current cell states

  CelAut(int _dRule, int _cellSize, int _nCellsX, int _nGens) {                  //Constructor: cellSize, Amount of Cells in X and Y
    cellSize= _cellSize;
    nCellsX=_nCellsX;
    nGens=_nGens;
    dRule=_dRule;
    preState = new int[nCellsX];
    newState = new int[nCellsX];
    for (int i=0; i<8; i++)bRule[i]=Integer.parseInt(binary(dRule, 8))/int(pow(10, i))%10;   //Transform Rule decimal to binary  
}
  void initialstate(float tempxpos, float tempypos, float tempzpos) {                               
    xpos = tempxpos-((cellSize*nCellsX)/2);                                                                          //position (Move middle array to beggining of the screen) 
    ypos = tempypos;
    zpos = tempzpos;
    preState[nCellsX/2]=1;      //set middle value of array to 1
   
}
  void operate() {   
    for (int j=0; j<nGens; j++) {                                                            //For row - gen on the set
      for (int i=0; i<nCellsX; i++) {                                                        //For every cell on the row - gen                                                                                                                                                                     
        int upminus1 =preState[(i+preState.length-1)%preState.length];                       //Get state + neighbors (in previous row)                                      
        int up=preState[i];                                                                  //Add [] length and % to get as -1 i last number of []
        int upplus1=preState[(i+preState.length+1)%preState.length];     
        int config=(upminus1*4)+(up*2)+upplus1;                                              //Adding digits in binary to get configuration number                  
        if (bRule[config] == 1) newState[i]=1;                                               //turn on all states in new states acording to rule
        else  newState[i]=0;                                                                 //turn off all states acording to rule
        fill (255);
        pushMatrix();
        translate(xpos+(i*cellSize), ypos+(cellSize*gen), zpos);
        if (preState[i]==1) box(cellSize);                                                   //Draw rectangle from Previous State
        popMatrix();
      }
      for (int i=0; i<preState.length; i++) preState[i]=newState[i] ;                        //Make Previous State New State
      gen++;                                                                                 //Jump to next row - gen
    }                                                                                        //Function Integer.parseInt = changes String to Integer (Researched in forum)
  }                                                                                          //Bibilography: https://forum.processing.org/one/topic/converting-string-to-int.html
}