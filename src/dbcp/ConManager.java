package dbcp;

public class ConManager {
	static ConManager con;
	
	//객체가 만들어 졌는지 체크
	//객체가 안만들어 졌으면 만들어줌.
	//객체가 이미 하나 만들어져 있으면 만들어줌.
	//객체를 리턴
	public static ConManager getInstance() {
		if (con == null) {
			con = new ConManager();
		}
		return con;
	}

	public void dbconnet() {
		System.out.println("db연결함.");
		
	}

	
	

	
}
