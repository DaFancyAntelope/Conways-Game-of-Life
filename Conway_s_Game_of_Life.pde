Cell[][] cells;
boolean simRunning = false;

void setup() {
  frameRate(60);
  size(1920, 1080);
  
  cells = new Cell[500][500];
  
  // Declares a new Cell for each place in the array.
  for (int x = 0; x < cells.length; x++) {
    for (int y = 0; y < cells[x].length; y++) {
      cells[x][y] = new Cell(x, y);
    }
  }
  
  // Initialises the cells, calling init() on each.
  for (int x = 0; x < cells.length; x++) {
    for (int y = 0; y < cells[x].length; y++) {
      cells[x][y].init();
    }
  }
}

void draw() {
  fill(255, 255, 255);
  if (!simRunning) {
    // Start the program off in draw mode.
    if (mousePressed) {
      // Activates cells over the mouse's position.
      cells[floor(mouseX) / 5][floor(mouseY) / 5].isAlive = true;
    }
    if (keyPressed) {
      if (key == ENTER) {
        simRunning = true;
      }
    }
    else {
      keyJustPressed = false;
    }
    drawSquares();
  }
  else {
    // Recalculates neighbours' status on each cell, calling recalculateAround() on each.
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[x].length; y++) {
        cells[x][y].recalculateAround();
      }
    }

    // Recalculates whether each cell is alive or not, calling recalculateLiving() on each.
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[x].length; y++) {
        cells[x][y].recalculateLiving();
      }
    }
    
    if (keyPressed) {
      if (key == BACKSPACE) {
        simRunning = false;
      }
    }
    drawSquares();
    delay(500);
  }
}

void drawSquares() {
  // Draws a square for each living cell.
  clear();
  fill(255, 255, 255);
  for (int x = 0; x < cells.length; x++) {
    for (int y = 0; y < cells[x].length; y++) {
      if (cells[x][y].isAlive) {
        rect(x * 5, y * 5, 5, 5);
      }
    }
  }
}

class Cell {
  private int x, y, cellsAlive = 0;
  private Cell[] cellsAround = new Cell[8];
  public boolean isAlive = false;
  
  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void init() {
    // Tells the cell what cells are its neighbours.
    try {
      cellsAround[0] = cells[x - 1][y - 1];
      cellsAround[1] = cells[x][y - 1];
      cellsAround[2] = cells[x + 1][y - 1];
    }
    catch (ArrayIndexOutOfBoundsException ex) {
      cellsAround[0] = new EmptyCell(0, 0);
      cellsAround[1] = new EmptyCell(0, 0);
      cellsAround[2] = new EmptyCell(0, 0);
    }
    
    try {
      cellsAround[3] = cells[x - 1][y];
      cellsAround[4] = cells[x + 1][y];
    }
    catch (ArrayIndexOutOfBoundsException ex) {
      cellsAround[3] = new EmptyCell(0, 0);
      cellsAround[4] = new EmptyCell(0, 0);
    }
    
    try {
      cellsAround[5] = cells[x - 1][y + 1];
      cellsAround[6] = cells[x][y + 1];
      cellsAround[7] = cells[x + 1][y + 1];
    }
    catch (ArrayIndexOutOfBoundsException ex) {
      cellsAround[5] = new EmptyCell(0, 0);
      cellsAround[6] = new EmptyCell(0, 0);
      cellsAround[7] = new EmptyCell(0, 0);
    }
  }
  
  public void recalculateAround () {
    // Updates information about how many living cells are around the cell.
    cellsAlive = 0;
    for (Cell cell : cellsAround) {
      if (cell.isAlive) {
        cellsAlive++;
      }
    }
  }
  
  public void recalculateLiving() {
    // Recalculates whether the cell will be alive at the end of the generation or not.
    if (isAlive) {
      if (cellsAlive < 2) {
        // Cell dies by underpopulation;
        isAlive = false;
      }
      else if (cellsAlive < 4) {
        // Do nothing; live on to the next generation.
      }
      else if (cellsAlive > 3) {
        // Cell dies by overpopulation.
        isAlive = false;
      }
    }
    else if (cellsAlive == 3) {
      // Cell is born.
      isAlive = true;
    }
  }
}

class EmptyCell extends Cell {
  public EmptyCell(int x, int y) {
    super(x, y);
  }
  public boolean isAlive = false;
}
