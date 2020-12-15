package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import dbcp.DBConnectionMgr;

//CRUD 중김으로 기능을 정의
//데이터와 관련된 작업(Data Access object: DAO)
public class SignDAO {
	Connection con;
	DBConnectionMgr dbcp;
	
		
	

	//DB프로그램 절차에 맞춰 코딩
	public SignDAO() throws Exception {
		dbcp = DBConnectionMgr.getInstance();
		System.out.println("1. connector 연결 성공.!!");
		System.out.println("2. db연결 성공.!!");
	}
		
	public boolean create(SignVO vo) throws Exception {
		con = dbcp.getConnection();
		//3. sql문을 만들다.
		String sql = "insert into sign values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";//값이 없으면 null을 넣어주면됨
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vo.getName());
		ps.setString(2, vo.getCountry());
		ps.setString(3, vo.getBirth());
		ps.setString(4, vo.getId());
		ps.setString(5, vo.getPw());
		ps.setString(6, vo.getCountry1());
		ps.setString(7, vo.getTel());
		ps.setString(8, vo.getPostcode());
		ps.setString(9, vo.getAddress());
		ps.setString(10, vo.getAddress1());
		ps.setString(11, vo.getAddress2());
		System.out.println("3. SQL문 생성 성공.!!");
		//4. sql문은 전송
		int row = ps.executeUpdate();
		System.out.println("4. SQL문 정송 성공.!!");
		
		boolean result = false;
		if (row == 1) {
			result = true;
		}
		ps.close();
		con.close();
		dbcp.freeConnection(con,ps);
		return result;
	}
	
	//아이디와 전번으로 비밀번호 찾기
			public List<SignVO> all(String id, String tel) throws Exception {
			con = dbcp.getConnection();
			  // 3. sql문을 만든다.
		     String sql = "select * from sign where id = ? and tel = ?";
		   
		     PreparedStatement ps = con.prepareStatement(sql);
		     ps.setString(1, id);
		     ps.setString(2, tel);
		     // 4. sql문은 전송
		     ResultSet rs = ps.executeQuery();
		     System.out.println("4. SQL문 전송 성공.!!");
		     List<SignVO> list = new ArrayList<SignVO>();
		     while (rs.next()) { // 결과가 있는지 없는지 체크해주는 메서드
	    	 SignVO bag = new SignVO();//가방만들어서,
		        //가방에 넣기
		        bag.setId(rs.getString("id")); //커서(위치 알려주는친구)
		        bag.setPw(rs.getString("pw"));
		        bag.setName(rs.getString("name"));
		        bag.setTel(rs.getString("tel"));
		        //컨테이너에 넣는다.
		        list.add(bag);
		     } 
		     	rs.close();
				ps.close();
				con.close();
				dbcp.freeConnection(con,ps,rs);
		     return list;
			}
			
			
	//이름과 패쓰워드로 아이디 찾기
			public List<SignVO> all1(String name, String pw) throws Exception {
				con = dbcp.getConnection();
		     // 3. sql문을 만든다.
		     String sql = "select * from sign where name = ? and pw = ?";
		     PreparedStatement ps = con.prepareStatement(sql);
		     ps.setString(1, name);
		     ps.setString(2, pw);
		     // 4. sql문은 전송
		     ResultSet rs = ps.executeQuery();
		     System.out.println("4. SQL문 전송 성공.!!");
		     List<SignVO> list = new ArrayList<SignVO>();
		     while (rs.next()) { // 결과가 있는지 없는지 체크해주는 메서드
		    	 SignVO bag = new SignVO();//가방만들어서,
		        //가방에 넣기
		    	bag.setName(rs.getString("name"));
		    	bag.setPw(rs.getString("pw"));
		        bag.setId(rs.getString("id")); //커서(위치 알려주는친구)
		        bag.setTel(rs.getString("tel"));
		        //컨테이너에 넣는다.
		        list.add(bag);
		     } 
		     	rs.close();
				ps.close();
				con.close();
				dbcp.freeConnection(con,ps,rs);
		     return list;
			}		
		
		//전체검색
		public List<SignVO> all() throws Exception {
			con = dbcp.getConnection();
	     // 3. sql문을 만든다.
	     String sql = "select * from Sign";
	     PreparedStatement ps = con.prepareStatement(sql);
	     // 4. sql문은 전송
	     ResultSet rs = ps.executeQuery();
	     System.out.println("4. SQL문 전송 성공.!!");
	     
	     List<SignVO> list = new ArrayList<SignVO>();
	     while (rs.next()) { // 결과가 있는지 없는지 체크해주는 메서드
	    	 //object(vo) Relational DB(row) Mapping(ORM)
	    	 SignVO bag = new SignVO();//가방만들어서,
	        //가방에 넣기
	        bag.setId(rs.getString("id")); //커서(위치 알려주는친구)
	        bag.setPw(rs.getString("pw"));
	        bag.setName(rs.getString("name"));
	        bag.setTel(rs.getString("tel"));
	        //컨테이너에 넣는다.
	        list.add(bag);
	     } 
	     	rs.close();
			ps.close();
			con.close();
			dbcp.freeConnection(con,ps,rs);
	     return list;
		}
	
	
	//id 중복체크
	public int read(String id) throws Exception {
		con = dbcp.getConnection();
		//3. sql문을 만들다.
		String sql = "select * from sign where id = ?";//값이 없으면 null을 넣어주면됨
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		System.out.println("3. SQL문 생성 성공.!!");
		//4. sql문은 전송
		//select의 결과는 검색결과가 담긴 테이블(항목+내용)
		//내용에는 없을수도 있고, 많을수고 있음.
		ResultSet rs = ps.executeQuery();
		System.out.println("4. SQL문 정송 성공.!!");
		int result2 = 0;//없음
		if (rs.next() == true) {//결과가 있는지 없는지 체크 해주는 메서드
			//if (rs.next())와 동일함
			//if문은 rs.next()가 true일떄만 실행되므로!!
			System.out.println("검색결과가 있어요.");
			result2 = 1;//있음
			String id2 = rs.getString("id");
			String pw2 = rs.getString("pw");
			String name2 = rs.getString("name");
			String tel2 = rs.getString("tel");
			System.out.println("검색결과 id : " + id2);
			System.out.println("검색결과 pw : " + pw2);
			System.out.println("검색결과 name : " + name2);
			System.out.println("검색결과 tel : " + tel2);
		
		}else {
			System.out.println("검색결과가 없어요111111111111.");
		}
		ps.close();
		con.close();
		dbcp.freeConnection(con,ps);
		return result2;
		//0이 넘어가면, 검색결과 없음.
		//1이 넘어가면, 검색결과 있음.

	}
	
		public int read2(String id) throws Exception {
		con = dbcp.getConnection();
		//3. sql문을 만들다.
		String sql = "select * from sign where id = ?";//값이 없으면 null을 넣어주면됨
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		System.out.println("3. SQL문 생성 성공.!!");
		//4. sql문은 전송
		ResultSet rs = ps.executeQuery();
		System.out.println("4. SQL문 정송 성공.!!");
		int result2 = 0;//없음
		if (rs.next() == true) {//결과가 있는지 없는지 체크 해주는 메서드
			System.out.println("검색결과가 있어요.");
			result2 = 1;//있음
			String id2 = rs.getString("id");
			String pw2 = rs.getString("pw");
			String name2 = rs.getString("name");
			String tel2 = rs.getString("tel");
			System.out.println("검색결과 id : " + id2);
			System.out.println("검색결과 pw : " + pw2);
			System.out.println("검색결과 name : " + name2);
			System.out.println("검색결과 tel : " + tel2);
		
		}else {
			System.out.println("검색결과가 없어요111111111111.");
		}
		ps.close();
		con.close();
		dbcp.freeConnection(con,ps);
		return result2;
		//0이 넘어가면, 검색결과 없음.
		//1이 넘어가면, 검색결과 있음.

	}
	
	
	//id 중복체크
		public SignVO one(String id) throws Exception {
			con = dbcp.getConnection();
			//3. sql문을 만들다.
			String sql = "select * from sign where id = ?";//값이 없으면 null을 넣어주면됨
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			
			System.out.println("3. SQL문 생성 성공.!!");
			//4. sql문은 전송
			//select의 결과는 검색결과가 담긴 테이블(항목+내용)
			//내용에는 없을수도 있고, 많을수고 있음.
			ResultSet rs = ps.executeQuery();
			System.out.println("4. SQL문 정송 성공.!!");
			SignVO bag = new SignVO();//가방을 만들어서,
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

			출처: https://nota.tistory.com/50 [nota's story]
			if (rs.next() == true) {//결과가 있는지 없는지 체크 해주는 메서드
				//if (rs.next())와 동일함
				//if문은 rs.next()가 true일떄만 실행되므로!!
				System.out.println("검색결과가 있어요.");
				String id2 = rs.getString("id");
				String pw2 = rs.getString("pw");
				String name2 = rs.getString("name");
				String tel2 = rs.getString("tel");
				String Birth2 =transFormat.format(rs.getDate("birth"));
				String Postcode2 = rs.getString("postcode");
				String Address2 =rs.getString("address");
				String Address12 =rs.getString("address1");
				String Address22 =rs.getString("address2");
				//가방에 넣기
				bag.setId(id2);
				bag.setPw(pw2);
				bag.setName(name2);
				bag.setTel(tel2);
				bag.setBirth(Birth2);
				bag.setPostcode(Postcode2);
				bag.setAddress(Address2);
				bag.setAddress1(Address12);
				bag.setAddress2(Address22);
				System.out.println("검색결과 id : " + id2);
				System.out.println("검색결과 pw : " + pw2);
				System.out.println("검색결과 name : " + name2);
				System.out.println("검색결과 tel : " + tel2);	
			}else {
				System.out.println("검색결과가 없어요.");
			}
			rs.close();
			ps.close();
			con.close();
			dbcp.freeConnection(con,ps,rs);
			return bag;
			//bag은 참조형 변수, 주소를 전달!

		}
	//id,pw맞는지 로그인처리 
		public boolean read(SignVO vo) throws Exception {
			con = dbcp.getConnection();
			//3. sql문을 만들다.
			String sql = "select * from sign where id = ? and pw = ?";//값이 없으면 null을 넣어주면됨
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPw());
			System.out.println("3. SQL문 생성 성공.!!");
			//4. sql문은 전송
			ResultSet rs = ps.executeQuery();
			System.out.println("4. SQL문 정송 성공.!!");
			SignVO bag = new SignVO();
			boolean result1 = false;//로그인 not인 상태!
			if (rs.next() == true) {//결과가 있는지 없는지 체크 해주는 메서드
				System.out.println("로그인 ok.");
				System.out.println("검색결과가 있어요.");
				String id2 = rs.getString("id");
				String pw2 = rs.getString("pw");
				String name2 = rs.getString("name");
				String tel2 = rs.getString("tel");
				//가방에 넣기
				bag.setId(id2);
				bag.setPw(pw2);
				bag.setName(name2);
				bag.setTel(tel2);
				System.out.println("검색결과 id : " + id2);
				System.out.println("검색결과 pw : " + pw2);
				System.out.println("검색결과 name : " + name2);
				System.out.println("검색결과 tel : " + tel2);
				result1 = true;//있음					
			}else {
				System.out.println("로그인 not.");
			}
			rs.close();
			ps.close();
			con.close();
			dbcp.freeConnection(con,ps,rs);
			return result1;
			//false면 로그인not.
			//true면 로그인 ok.

		}

	public boolean update(SignVO vo) throws Exception{
		con = dbcp.getConnection();
		//3. sql문을 만들다.
		String sql = "update sign set name = ?, birth = ?, tel = ?, pw = ?, postcode = ?, address = ?, address1 = ?, address2 = ? where id = ?";//값이 없으면 null을 넣어주면됨
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vo.getName());
		ps.setString(2, vo.getBirth());
		ps.setString(3, vo.getTel());
		ps.setString(4, vo.getPw());
		ps.setString(5, vo.getPostcode());
		ps.setString(6, vo.getAddress());
		ps.setString(7, vo.getAddress1());
		ps.setString(8, vo.getAddress2());
		ps.setString(9, vo.getId());
		
		System.out.println("3. SQL문 생성 성공.!!");
		//4. sql문은 전송
		int row = ps.executeUpdate();
		System.out.println("4. SQL문 정송 성공.!!");
		
		ps.close();
		con.close();
		dbcp.freeConnection(con,ps);
		boolean result = false;
		if (row == 1) {
			result = true;
		}
		return result;
	}
	
	public boolean delete(String id) throws Exception{
		con = dbcp.getConnection();
		//3. sql문을 만들다.
		String sql = "delete from sign where id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		
		System.out.println("3. SQL문 생성 성공.!!");
		
		int row = ps.executeUpdate();
		System.out.println("4. SQL문 정송 성공.!!");
		
		
		ps.close();
		con.close();
		dbcp.freeConnection(con,ps);
		boolean result =false;
		if (row == 1 ) {
			result = true;
		}
		return result;
		
	}

}
