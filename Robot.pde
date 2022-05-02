class Robot extends Enemy {
  // Requirement #5: Complete Dinosaur Class

  final int PLAYER_DETECT_RANGE_ROW = 2;
  final int LASER_COOLDOWN = 180;
  final int HAND_OFFSET_Y = 37;
  final int HAND_OFFSET_X_FORWARD = 64;
  final int HAND_OFFSET_X_BACKWARD = 16;
  float speed = 2f;
  int cooldownTimer=0;
  Laser laser=new Laser();

  Robot(float x, float y) {
    super(x, y);
  }

  void display() {
    
    pushMatrix();
    translate(x, y);
    if (speed>0) {
      scale(1, 1);
      image(robot, 0, 0, w, h);
    } else {
      scale(-1, 1);
      image(robot, -w, 0, w, h);
    }
    popMatrix();
    laser.display();
  }

  void update() {
    if (abs(player.row-y/SOIL_SIZE)<=2 && ((speed>0 && (player.x+SOIL_SIZE/2)-(x+HAND_OFFSET_X_FORWARD)>0)||(speed<0 && (player.x+SOIL_SIZE/2)-(x+HAND_OFFSET_X_BACKWARD)<0))) {
      if (cooldownTimer==0) {
        if (speed>0) {
          laser.fire(x+HAND_OFFSET_X_FORWARD, y+HAND_OFFSET_Y, player.x+SOIL_SIZE/2, player.y+SOIL_SIZE/2);
        } else {
          laser.fire(x+HAND_OFFSET_X_BACKWARD, y+HAND_OFFSET_Y, player.x+SOIL_SIZE/2, player.y+SOIL_SIZE/2);
        }
        cooldownTimer=LASER_COOLDOWN;
      } else {
        cooldownTimer--;
      }
    } else {
      if (cooldownTimer>0) {
        cooldownTimer--;
      }
      
      x += speed;
      if (x >= width-SOIL_SIZE||x<=0) speed*=-1;
    }
    
    laser.update();
  }
  
  void checkCollision(Player player){
    super.checkCollision(player);
    laser.checkCollision(player);
  }
  // HINT: Player Detection in update()
  /*

   	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
   					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )
   
   	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me
   
   	if(checkX AND checkY){
   		Is laser's cooldown ready?
   			True  > Fire laser from my hand!
   			False > Don't do anything
   	}else{
   		Keep moving!
   	}
   
   	*/
}
