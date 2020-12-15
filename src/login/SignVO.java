package login;

import java.util.Date;

public class SignVO {
	//private라고 쓰면, 이클래스내에서만 변수에 접근해서 쓸수 있음.
	private String name;
	private String country;
	private String birth;
	private String id;
	private String pw;
	private String country1;
	private String tel;
	private String postcode;
	private String address;
	private String address1;
	private String address2;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getCountry1() {
		return country1;
	}
	public void setCountry1(String country1) {
		this.country1 = country1;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//각 변수에 값을 넣는 /뺴는 메서드를 정의 하면됨.!
	//가방에 넣을떄는 set메서드로 정의: setters //값을 넣을떄는 set을 넣는다
	//가방에서 꺼낼때는 get메서드로 정의: getters //값을 꺼낼떄는 set을 넣는다
	//헷갈려서 this.id = id; this.는 클래스를 의미 
	
}
