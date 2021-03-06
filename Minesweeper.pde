import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int j = 0; j < NUM_ROWS; j++)
        for (int i = 0; i < NUM_COLS; i++)
            buttons[j][i] = new MSButton(j,i);
    
    setBombs();
}
public void setBombs()
{
    for (int n = 0; n < 40; n++){
        int j = (int)(Math.random()*NUM_ROWS);
        int i = (int)(Math.random()*NUM_COLS);
        if (!bombs.contains(buttons[j][i]))
        bombs.add(buttons[j][i]); 
    }                   
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
            marked = !marked;
            if (!marked)
                clicked = false;
        }
        else if (bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(row, col) > 0)
            setLabel("" + countBombs());
        else{
        for (int i = -1; i <=1; i++)
            if (isValid(row-1, col+i))
                bombs[row-1][col+i].mousePressed();
        for (int i = -1; i <=1; i++)
            if (isValid(row+1, col+i))
                bombs[row+1][col+i].mousePressed();
        if (isValid(row, col+1))
            bombs[row][col+1].mousePressed();
        if (isValid(row, col-1))
            bombs[row][col-1].mousePressed();
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r<0 || r>=NUM_ROWS)
            return false;
        else if (c<0 || c>=NUM_COLS)
            return false;
        return true;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for (int i = -1; i <=1; i++)
            if (isValid(row-1, col+i))
                if (bombs.contains(buttons[row-1][col+i]))
                    numBombs++;
        for (int i = -1; i <=1; i++)
            if (isValid(row+1, col+i))
                if (bombs.contains(buttons[row+1][col+i]))
                    numBombs++;
        if (isValid(row, col+1))
            if (bombs.contains(buttons[row][col+1]))
                numBombs++;
        if (isValid(row, col-1))
            if (bombs.contains(buttons[row][col-1]))
                numBombs++;
        return numBombs;
    }
}



