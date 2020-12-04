package ejercicio3;

public class Data extends Item{
	private int data;
	
	public Data(int data) {
		this.data=data;
	}
	
	@Override
	public boolean isData() {
		return true;
	}
	
	@Override
	public int getValue() {
		return data;
	}
}

