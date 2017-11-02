class CelAut3d {                                                                                           // CELULAR AUTOMATA gen 
  int cellSize, nCellsX, nCellsZ, nGen, dRule, gen;                                                        //Cell size //Height of array //Rule Decimal                              
   float  xpos, ypos, zpos;
  int [] bRule = new int[32];                                                                              //Rule Binary (reversed rule number) 
  int preState [][], newState [][];                                                                        //Contains all previous and current cell states

  CelAut3d(int tempdRuleec, int tempcellSize, int tempnCellsX, int tempnCellsZ, int tempnGen) {            //Constructor: cellSize, Amount of Cells in X and Y
    cellSize=tempcellSize;
    nCellsX=tempnCellsX;
    nCellsZ=tempnCellsZ;
    nGen=tempnGen;
    dRule=tempdRuleec;
    preState = new int[nCellsX][nCellsZ];
    newState = new int[nCellsX][nCellsZ];
    for (int i=0; i<8; i++)bRule[i]=Integer.parseInt(binary(dRule, 8))/int(pow(10, i))%10;                  //Transform Rule decimal to binary
  }
  void initialstate(float tempxpos, float tempypos, float tempzpos) {                                             //Initial On State
    xpos = tempxpos-((cellSize*nCellsX)/2);                                                                 //position    (Move middle array to beggining of the screen) 
    zpos = tempzpos-((cellSize*nCellsZ)/2);
    ypos = tempypos;
    preState[nCellsX/2][nCellsZ/2]=1;                                                                       //set middle value in array to 1

}
  void operate() {
    for (int j=0; j<nGen; j++){                                                                             //For every gen on the set, every row on the gen,every cell on the row                                                                          
      for (int k=0; k<nCellsZ; k++){                                                                                                                                     
        for (int i=0; i<nCellsX; i++){                                                                      //VON NEUMANN NEIGHBOARS By adding array length and % it 0 gets the last number of the array                                                                                   
          int upminusz =preState[i][(k+nCellsZ-1)%nCellsZ];                                                 //x, z-1      00001     1
          int upminusx =preState[(i+nCellsX-1)%nCellsX][k];                                                 //x-1, z      00010     2                                
          int up=preState[i][k];                                                                            //x, z        00100     4
          int upplusx=preState[(i+nCellsX+1)%nCellsX][k];                                                   //x+1, z      01000     8
          int upplusz=preState[i][(k+nCellsZ+1)%nCellsZ];                                                   //x, z+1      10000     16       POSSIBLE CONFIGURATIONS=32  adding 00000   * Change rule array size
          int config=(upplusz*16)+(upplusx*8)+(up*4)+(upminusx*2)+upminusz;                                 //Add all neighboars to get configuration in binary                
          if (bRule[config] == 1) newState[i][k]=1;                                                         //turn on all states in new states acording to rule
          else  newState[i][k]=0;                                                                           //turn off all states acording to rule
          fill (255);
          pushMatrix();
          translate((i*cellSize)+xpos, (cellSize*gen)+ypos,(k*cellSize)+zpos);
          if (preState[i][k]==1) box(cellSize);                                                             //Draw rectangle from Previous State
          popMatrix();
        }
      }
     for (int i=0; i<nCellsX; i++)for (int k=0; k<nCellsZ; k++)preState[i][k]=newState[i][k] ;             //Change Previous gen to new gen              
     gen++;                                                                                                //Jump to next row - gen
    }
  }
}