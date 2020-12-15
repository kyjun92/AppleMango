package Product;

public class ConManager {

	static ConManager con;//null;
	
	public static ConManager getInstance() {
		if (con == null) {
			con = new ConManager();
		}
		return con;
	}
}
