class Player {
	
	float x, y;
	float w = SOIL_SIZE, h = SOIL_SIZE;
	int col, row;
	final float PLAYER_INIT_X = 4 * SOIL_SIZE;
	final float PLAYER_INIT_Y = - SOIL_SIZE;

	int health = 2;
	final int PLAYER_MAX_HEALTH = 5;

	int moveDirection = 0;
	int moveTimer = 0;
	int moveDuration = 15;

	void update(){
		PImage groundhogDisplay = groundhogIdle;

		// If player is not moving, we have to decide what player has to do next
		if(moveTimer == 0){

			if((row + 1 < SOIL_ROW_COUNT && soils[col][row + 1].health == 0) || row + 1 >= SOIL_ROW_COUNT){

				groundhogDisplay = groundhogDown;
				moveDirection = DOWN;
				moveTimer = moveDuration;

			}else{

				if(leftState){

					groundhogDisplay = groundhogLeft;

					// Check left boundary
					if(col > 0){

						if(row >= 0 && soils[col - 1][row].health > 0){
							soils[col - 1][row].health --;
						}else{
							moveDirection = LEFT;
							moveTimer = moveDuration;
						}

					}

				}else if(rightState){

					groundhogDisplay = groundhogRight;

					// Check right boundary
					if(col < SOIL_COL_COUNT - 1){

						if(row >= 0 && soils[col + 1][row].health > 0){
							soils[col + 1][row].health --;
						}else{
							moveDirection = RIGHT;
							moveTimer = moveDuration;
						}

					}

				}else if(downState){

					groundhogDisplay = groundhogDown;

					// Check bottom boundary
					if(row < SOIL_ROW_COUNT - 1){

						soils[col][row + 1].health --;

					}
				}
			}

		}else{
			// Draw image before moving to prevent offset
			switch(moveDirection){
				case LEFT:	groundhogDisplay = groundhogLeft;	break;
				case RIGHT:	groundhogDisplay = groundhogRight;	break;
				case DOWN:	groundhogDisplay = groundhogDown;	break;
			}
		}

		image(groundhogDisplay, x, y);

		// If player is now moving?

		if(moveTimer > 0){

			moveTimer --;
			switch(moveDirection){

				case LEFT:
				groundhogDisplay = groundhogLeft;
				if(moveTimer == 0){
					col--;
					x = SOIL_SIZE * col;
				}else{
					x = (float(moveTimer) / moveDuration + col - 1) * SOIL_SIZE;
				}
				break;

				case RIGHT:
				groundhogDisplay = groundhogRight;
				if(moveTimer == 0){
					col++;
					x = SOIL_SIZE * col;
				}else{
					x = (1f - float(moveTimer) / moveDuration + col) * SOIL_SIZE;
				}
				break;

				case DOWN:
				groundhogDisplay = groundhogDown;
				if(moveTimer == 0){
					row++;
					y = SOIL_SIZE * row;
					if(row >= SOIL_ROW_COUNT + 3) gameState = GAME_WIN;
				}else{
					y = (1f - float(moveTimer) / moveDuration + row) * SOIL_SIZE;
				}
				break;
			}

		}
	}

	void hurt(){
		health --;

		if(health == 0){

			gameState = GAME_OVER;

		}else{

			x = PLAYER_INIT_X;
			y = PLAYER_INIT_Y;
			col = (int) x / SOIL_SIZE;
			row = (int) y / SOIL_SIZE;
			soils[col][row + 1].health = 15;
			moveTimer = 0;

		}
	}

	Player(){
		health = 2;
		x = PLAYER_INIT_X;
		y = PLAYER_INIT_Y;
		col = (int) x / SOIL_SIZE;
		row = (int) y / SOIL_SIZE;
		moveTimer = 0;
	}
}