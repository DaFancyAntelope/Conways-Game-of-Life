# Conways-Game-of-Life
Simple Processing 3 version of Conway's game of life.

## Controls
The program will boot in 'draw mode'. In this mode, use the mouse to draw cells on the board, without the simulation running.
To exit draw mode and run the simulation, press ENTER. The sim will now run.
To go back to draw mode, press BACKSPACE.

## Rules
Conway's game of life is a zero-player game, meaning that there is minimal input from the player. Instead, the cells will play the game.
At the start, each cell is either alive or dead. When the simulation is running, a new generation will occur every half a second. When these generational changes occur, the state of the cells could change, according to four simple rules:
1. Any cell with less than 2 living neighbours at the end of the generation dies, as if by underpopulation.
2. Any cell with two or three live neighbours will live onto the next generation.
3. Likewise from rule 1, any cell with more than three living neighbours at the end of the generation will die, as if by overpopulation.
4. If a dead cell has exactly three living neighbours, it will be alive in the next generation, as if by reproduction.

All code by Harley Nador, 2018-2019.
