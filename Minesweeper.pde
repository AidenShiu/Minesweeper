import de.bezier.guido.*;
private static final int NUM_ROWS = 16;
private static final int NUM_COLS = 16;
public final static int NUM_MINES = 40;
int numFlags = 40;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
 size(600, 650);
 textAlign(CENTER,CENTER);
 
 // make the manager
 Interactive.make( this );
 
 buttons = new MSButton[NUM_ROWS][NUM_COLS];
   for (int r = 0; r < NUM_ROWS; r++){
     for (int c = 0; c < NUM_COLS; c++){
       buttons[r][c] = new MSButton(r, c);
   }
 }
   setMines();
}

public void setMines(){
    //your code
    while(mines.size() < NUM_MINES){
        MSButton temp = buttons[(int)(Math.random() * NUM_ROWS)][(int)(Math.random() * NUM_COLS)];
        if(!mines.contains(temp)){
            mines.add(temp);
        }
    }
}

public void draw (){
 background(0);
 if(isWon() == true){
   displayWinningMessage();
 }
 fill(#E0F00F);
 textAlign(CENTER, CENTER);
 text("16x16 board, 40 mines, " + numFlags + " flags.", 300, 625);
}

public boolean isWon(){
 for (int i = 0; i < mines.size(); i++){
   if (mines.get(i).isFlagged() == false){
      return false;
   }
 }
   return true;
 }

public void displayLosingMessage(){
 buttons[8][4].setLabel("Y");
 buttons[8][5].setLabel("O");
 buttons[8][6].setLabel("U");
 buttons[8][7].setLabel("");
 buttons[8][8].setLabel("L");
 buttons[8][9].setLabel("O");
 buttons[8][10].setLabel("S");
 buttons[8][11].setLabel("E");
 //Show all mines
 for (int i = 0; i < mines.size(); i++){
   mines.get(i).clicked = true;
   mines.get(i).draw();
 }
}

public void displayWinningMessage(){
 buttons[8][5].setLabel("Y");
 buttons[8][6].setLabel("O");
 buttons[8][7].setLabel("U");
 buttons[8][8].setLabel("");
 buttons[8][9].setLabel("W");
 buttons[8][10].setLabel("I");
 buttons[8][11].setLabel("N");
}

public boolean isValid(int r, int c)
{
  if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0){
    return true;
  }
    return false;
}

public int countMines(int row, int col)
{
 int numMines = 0;
 //your code here
 if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1])){numMines++;}
 if(isValid(row-1,col) && mines.contains(buttons[row-1][col])){numMines++;}
 if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1])){numMines++;}
 if(isValid(row,col-1) && mines.contains(buttons[row][col-1])){numMines++;}
 if(isValid(row,col+1) && mines.contains(buttons[row][col+1])){numMines++;}
 if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1])){numMines++;}
 if(isValid(row+1,col) && mines.contains(buttons[row+1][col])){numMines++;}
 if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1])){numMines++;}
 return numMines;
}

public class MSButton
{
 private int myRow, myCol;
 private float x,y, width, height;
 private boolean clicked, flagged, click;
 private String myLabel;
 public int myColor, size;
 
 public MSButton ( int row, int col ){
 width = 600/NUM_COLS;
 height = 600/NUM_ROWS;
 myRow = row;
 myCol = col;
 x = myCol*width;
 y = myRow*height;
 myLabel = "";
 flagged = clicked = false;
 Interactive.add( this ); // register it with the manager
 myColor = color(0);
 size = 15;
 }
 
 // called by manager
 public void mousePressed (){
   clicked = true;
   if (mouseButton == RIGHT && click == false){
     flagged = !flagged;
   if (flagged == false){
     clicked = false;
     numFlags = numFlags + 1;}
   }
   else if (flagged == true && numFlags !=0){
     numFlags = numFlags - 1;}
   else if (numFlags == 0){
     flagged = !flagged;
     clicked = false;
   }
   else if (!flagged && mines.contains(buttons[myRow][myCol])){
     displayLosingMessage();
   }
   else if (!flagged && countMines(myRow, myCol) > 0){
     setLabel(countMines(myRow, myCol));
   }
   else if (!flagged){
     for (int r = myRow - 1; r <= myRow + 1; r++){
       for (int c = myCol - 1; c <= myCol + 1; c++){
         if (isValid(r, c) && buttons[r][c].clicked == false){
           buttons[r][c].mousePressed();}
         }
        }
       }
    }
 
public void draw (){
 if (flagged){
   fill(0);}
 else if (clicked && mines.contains(this)){
   fill(255,0,0);}
 else if (clicked){
   fill(200);
   click = true;}
 else{
 fill(100);}
}
 rect(x, y, width, height);
 fill(myColor);
 textSize(size);
 text(myLabel,x+width/2,y+height/2);
}

 public void setLabel(String newLabel){
   myLabel = newLabel;
 }
 public void setLabel(int newLabel){
   myLabel = ""+ newLabel;
 }
 public boolean isFlagged(){
   return flagged;
  }
 }
