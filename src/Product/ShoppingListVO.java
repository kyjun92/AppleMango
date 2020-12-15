package Product;

public class ShoppingListVO {

	private int l_id;
	private String p_id;
	private String p_name;
	private String ps_content;
	private int ps_price;
	private String p_pic;
	private String User_id;

	public int getL_id() {
		return l_id;
	}

	public void setL_id(int l_id) {
		this.l_id = l_id;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getPs_content() {
		return ps_content;
	}

	public void setPs_content(String p_content) {
		this.ps_content = p_content;
	}

	public int getPs_price() {
		return ps_price;
	}

	public void setPs_price(int p_price) {
		this.ps_price = p_price;
	}

	public String getP_pic() {
		return p_pic;
	}

	public void setP_pic(String p_pic) {
		this.p_pic = p_pic;
	}

	public String getUser_id() {
		return User_id;
	}

	public void setUser_id(String user_id) {
		User_id = user_id;
	}

}
