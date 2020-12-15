package music;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class DAO {
	Connection con;
	Connection con1;
	Connection con2;
	Connection con3;
	DBConnectionMgr dbcp;

	public DAO() throws Exception {
		dbcp = DBConnectionMgr.getInstance();
	}
	
	static void swap(int[][] a, int idx1, int idx2) {
		int[] t = {a[idx1][0],a[idx1][1]}; 
		a[idx1][0] = a[idx2][0];
		a[idx1][1] = a[idx2][1];
		a[idx2][0] = t[0];
		a[idx2][1] = t[1];
	}
	
	static void QuickSort(int[][] a, int l, int r) {
		int pl = l;
		int pr = r;
		int x = a[(pl + pr) / 2][1];
		
		do {
			while(a[pl][1] < x) pl++;
			while(a[pr][1] > x) pr--;
			if(pl <= pr) swap(a, pl++, pr--);
		}while(pl <= pr);
		
		if(l < pr) QuickSort(a, l, pr);
		if(pl < r) QuickSort(a, pl, r);
	}

	public JSONObject music_all() throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setDate(rs.getDate("date"));
			vo.setArtist(rs.getString("artist"));
			vo.setLyric(rs.getString("lyric"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));
			vo.setGenre(rs.getString("genre"));
			vo.setNum_play(rs.getInt("num_play"));
			
			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("date", transFormat.format(list.get(i).getDate()));
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("lyric", list.get(i).getLyric());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			sObject.put("genre", list.get(i).getGenre());
			sObject.put("num_play", list.get(i).getNum_play());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음

		try {

			FileWriter file = new FileWriter(
					"C:\\Users\\kyjun\\Dropbox\\09\\WebProject\\workspace\\project021\\WebContent\\music.json");
			file.write(obj.toString());
			file.flush();
			file.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		dbcp.freeConnection(con, ps, rs);
		return obj;
	}
	public JSONObject music_foryou_date_num() throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setDate(rs.getDate("date"));
			vo.setArtist(rs.getString("artist"));
			vo.setLyric(rs.getString("lyric"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));
			vo.setGenre(rs.getString("genre"));
			vo.setNum_play(rs.getInt("num_play"));
			
			list.add(vo);
		}
		Diff_day df = new Diff_day();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Random r = new Random();
		float s_y;
		float s_x;
		double s_f;
		int[][] s_f_r= new int[41][2];
		String date;
		
		for (int i = 0; i < list.size(); i++) {
			s_f_r[i][0] = i;
			date=transFormat.format(list.get(i).getDate());
			s_y = df.Diff_day(date);
			s_x = list.get(i).getNum_play() /1000;
			s_f = Math.pow((s_x*s_x)+(s_y*s_y),0.5); 
			s_f_r[i][1] = Math.round((float)(s_f) + r.nextFloat()*45);
		}
		
		QuickSort(s_f_r,0,40);
		for (int i = 0; i < s_f_r.length; i++) {
			
		}
		int[] s_id = new int[10];
		for (int i = 0; i < 10; i++) {
			s_id[i] = s_f_r[35-i][0];
		}
		int idx1;
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		for (int i = 0; i < 10; i++)// 배열
		{	
			idx1 = s_id[i];
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(idx1).getId());
			sObject.put("title", list.get(idx1).getTitle());
			sObject.put("date", transFormat.format(list.get(idx1).getDate()));
			sObject.put("artist", list.get(idx1).getArtist());
			sObject.put("lyric", list.get(idx1).getLyric());
			sObject.put("file", list.get(idx1).getFile());
			sObject.put("img", list.get(idx1).getImg());
			sObject.put("genre", list.get(idx1).getGenre());
			sObject.put("num_play", list.get(idx1).getNum_play());
			jArray.add(sObject);
		}
		
		obj.put("music", jArray);// 배열을 넣음
		
		dbcp.freeConnection(con, ps, rs);
		return obj;
	}
	
	

	public JSONObject music_new() throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music order by date desc limit 20";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setDate(rs.getDate("date"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < 20; i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("date", transFormat.format(list.get(i).getDate()));
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음


		dbcp.freeConnection(con, ps, rs);
		return obj;
	}

	public JSONObject music_top() throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music order by num_play desc limit 100";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setDate(rs.getDate("date"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));
			vo.setGenre(rs.getString("genre"));
			vo.setNum_play(rs.getInt("num_play"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("date", transFormat.format(list.get(i).getDate()));
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			sObject.put("genre", list.get(i).getGenre());
			sObject.put("num_play", list.get(i).getNum_play());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음

		dbcp.freeConnection(con, ps, rs);
		return obj;
	}
	
	public JSONObject music_search_genre(String genre) throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music where genre = '"+genre+"'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음


		dbcp.freeConnection(con, ps, rs);
		return obj;
	}

	public JSONObject music_foryou_age(String id) throws Exception {
		int age = 0;
		con = dbcp.getConnection();
		String sql = "select age from music_user where user_id = '"+id+"'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			age = rs.getInt("age");
			System.out.println(age);
		}else {
			System.out.println("age 값이 없어");
		}
		int age_10= (int) Math.floor(age/10);
		dbcp.freeConnection(con, ps, rs);
		String sql1 = "select user_id from music_user where age like '"+age_10+"%'";
		PreparedStatement ps1 = con.prepareStatement(sql1);
		ResultSet rs1 = ps1.executeQuery();
		ArrayList<String> user_id = new ArrayList<>();
		
		while(rs1.next()) {
			user_id.add(rs1.getString("user_id"));
		}
		dbcp.freeConnection(con1, ps1, rs1);
		System.out.println(user_id.get(0)+user_id.get(1)+user_id.get(2)+user_id.get(3));
		String sql2 = "select music_id from music_record where user_id in (?) order by p_time desc";
		PreparedStatement ps2 = con.prepareStatement(sql2);
		String[] user_is = new String[user_id.size()];
		for (int i = 0; i < user_id.size(); i++) {
			if(i==0) {
				user_is[i] = "'"+user_id.get(i)+"'";
			}else {
				user_is[i] = ",'"+user_id.get(i)+"'";
			}
		}
		for (int i = 0; i < user_is.length; i++) {
			ps.setString(i+1, user_is[i]);
		}
		ArrayList<Integer> m_id = new ArrayList<>();
		int k =0;
		int[][] index = new int[100][2];
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next()) {
				m_id.add(rs.getInt("music_id"));
				System.out.println(m_id.get(k));
				k++;
			}
			dbcp.freeConnection(con,ps, rs);
			for (int j = 0; j < 100; j++) {
				index[j][0] = j;
			}
			for (int j = 0; j < m_id.size(); j++) {
				
	            index[m_id.get(j)][1]++;          
	        }
			
			QuickSort(index, 0, 99);
		
		dbcp.freeConnection(con2, ps2, rs2);
		String sql3 = "select id, title, artist, file, img from music where id in ("+ index[98][0]+", " + index[97][0]+", " + index[96][0]+", " + index[95][0]+", " + index[94][0] + ")";
		PreparedStatement ps3 = con.prepareStatement(sql3);
		ResultSet rs3 = ps3.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs3.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < 5; i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음

		dbcp.freeConnection(con3, ps3, rs3);
		return obj;
	}	
	public String[] music_foryou_genre(String id) throws Exception {
		int[] m_id = new int[500];
		int i =0;
		int[][] index = new int[100][2];
		
		String genre[] = new String[5];
		con = dbcp.getConnection();
		String sql = "select music_id from music_record where user_id ='"+id+"' order by p_time desc limit 500";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			
			m_id[i] = rs.getInt("music_id");
			i++;
			System.out.println(m_id[i]);
		}
		dbcp.freeConnection(con,ps, rs);
		for (int j = 0; j < 100; j++) {
			index[j][0] = j;
		}
		for (int j = 0; j < m_id.length; j++) {
			
            index[m_id[j]][1]++;          
        }
		
		QuickSort(index, 0, 99);
		int k =0;
		for (int j = 0; j < 100; j++) {
			if(index[j][1] != 0 ) {
				k += index[j][1];
			}
		}
		

		con1 = dbcp.getConnection();
		String sql1 = "select genre from music where id in ("+ index[98][0]+", " + index[97][0]+", " + index[96][0]+", " + index[95][0]+", " + index[94][0] + ")";
		PreparedStatement ps1 = con.prepareStatement(sql1);
		ResultSet rs1 = ps1.executeQuery();
		k = 0;
		while(rs1.next()) {
			genre[k] = rs1.getString("genre");
			k++;
		}
		
		dbcp.freeConnection(con1, ps1, rs1);
		return genre;
	}
	
	
	
	
	public JSONObject music_search_ajax1(String word) throws Exception {
		con = dbcp.getConnection();
		String sql = "select id, title, artist, file, img from music where title like '"+word+"%' order by num_play desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++)// 배열
		{
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("id", list.get(i).getId());
			sObject.put("title", list.get(i).getTitle());
			sObject.put("artist", list.get(i).getArtist());
			sObject.put("file", list.get(i).getFile());
			sObject.put("img", list.get(i).getImg());
			jArray.add(sObject);
		}

		obj.put("music", jArray);// 배열을 넣음

		dbcp.freeConnection(con, ps, rs);
		return obj;
	}
	
	public VO newmusic_1yearago(VO vo) throws Exception {
		con = dbcp.getConnection();
		String sql = "select * from music where date > date_add(now(),interval -365 day)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, vo.getId());
		ps.setString(2, vo.getTitle());
		ps.setDate(3, vo.getDate());
		ps.setString(4, vo.getArtist());
		ps.setString(5, vo.getFile());
		ps.setString(6, vo.getImg());
		ps.setString(7, vo.getGenre());
		ps.setInt(8, vo.getNum_play());

		return vo;
	}

	public JSONObject file_read(int id) throws Exception {
		con = dbcp.getConnection();
		String sql = "select file, img, title, artist from music where id = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		while (rs.next()) {
			VO vo = new VO();
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));
			vo.setTitle(rs.getString("title"));
			vo.setArtist(rs.getString("artist"));

			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
		sObject.put("file", list.get(0).getFile());
		sObject.put("img", list.get(0).getImg());
		sObject.put("title", list.get(0).getTitle());
		sObject.put("artist", list.get(0).getArtist());
		jArray.add(sObject);

		obj.put("music", jArray);// 배열을 넣음

		dbcp.freeConnection(con, ps, rs);
		return obj;
	}

	public void num_play_update(int id) throws Exception {
		con = dbcp.getConnection();
		String sql = "update music set num_play = num_play + 1 where id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id);
		ps.executeUpdate();
		dbcp.freeConnection(con, ps);
	}

	public void random_update(int b) throws Exception {
		con = dbcp.getConnection();
		String sql = "insert into music_record value('mandu055@naver.com', '"+ b +"','2020-09-16')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.executeUpdate();
		dbcp.freeConnection(con, ps);
		
	}
	
	public void set_age(String user_id,int age) throws Exception {
		con = dbcp.getConnection();
		String sql = "update music_user set age = ? where id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, age);
		ps.setString(2, user_id);
		ps.executeUpdate();
		dbcp.freeConnection(con, ps);
	}
	
	public JSONObject one_m_load(String id) throws Exception {
		con = dbcp.getConnection();
		String sql = "select id, title, artist, file, img from music where id = "+id;
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VO> list = new ArrayList<VO>();
		if (rs.next()) {
			VO vo = new VO();
			vo.setId(rs.getInt("id"));
			vo.setTitle(rs.getString("title"));
			vo.setArtist(rs.getString("artist"));
			vo.setFile(rs.getString("file"));
			vo.setImg(rs.getString("img"));
			list.add(vo);
		}
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();// 배열이 필요할때
		JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
		sObject.put("id", list.get(0).getId());
		sObject.put("file", list.get(0).getFile());
		sObject.put("img", list.get(0).getImg());
		sObject.put("title", list.get(0).getTitle());
		sObject.put("artist", list.get(0).getArtist());
		jArray.add(sObject);
		obj.put("music", jArray);// 배열을 넣음
		dbcp.freeConnection(con, ps, rs);
		
		
		return obj;
	}
	
	public String load_list(String id) throws Exception {
		
		con = dbcp.getConnection();
		String sql = "select music_id from music_user where user_id ='"+id+"'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		String music_id = null;
		if (rs.next()) {
			music_id = rs.getString("music_id");
		}else{
			System.out.println("결과가 없습니다.");
		}

		dbcp.freeConnection(con, ps, rs);
		
		return music_id ;
		
	}
	public void save_list(String id) throws Exception {
		con = dbcp.getConnection();
		String sql = "update music_user set list = ?, music_id = ? where user_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		dbcp.freeConnection(con, ps);

	}
	 
//	public static void main(String[] args) throws Exception {
//		DAO dao = new DAO();
//		Random r = new Random();
//		
//		for (int i = 0; i < 100; i++) {
//			float a = (float) (r.nextGaussian()*8);
//			int b = Math.round(a)+20;
//			dao.random_update(b);
//		
//			System.out.println(b);
//		}
//	}
}
