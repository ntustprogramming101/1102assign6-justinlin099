class Cabbage extends Item{
  
  Cabbage(float x,float y){
    super(x,y);
  }
  
  void display(){
    if(isAlive) image(cabbage, x, y);
  }
  
  void checkCollision(Player player){
    if(player.health < player.PLAYER_MAX_HEALTH && isAlive && isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
      player.health ++;
      isAlive = false;
    }
  }
	// Requirement #1: Complete Cabbage Class

	/*
	Code for Reference:

		for(int i = 0; i < cabbageX.length; i++){

			// Display Cabbage
			image(cabbage, cabbageX[i], cabbageY[i]);

			// Check collision with player
			if(player.health < player.PLAYER_MAX_HEALTH
			&& isHit(cabbageX[i], cabbageY[i], SOIL_SIZE, SOIL_SIZE, player.x, player.y, player.w, player.h)){

				player.health ++;
				cabbageX[i] = cabbageY[i] = -1000; // Now that they're objects, toggle isAlive instead of throwing them away from screen

			}

		}

	*/
}
