class Item {
	boolean isAlive;
	float x, y;
	float w = SOIL_SIZE;
	float h = SOIL_SIZE;

	void display(){}
	void checkCollision(Player player){}

	Item(float x, float y){
		isAlive = true;
		this.x = x;
		this.y = y;
	}
}