package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbcp.DBConnectionMgr;


public class BbsDAO {
	DBConnectionMgr dbcp;
	Connection con;
	ResultSet rs;
	PreparedStatement ps;
	public BbsDAO() throws Exception {
		dbcp = DBConnectionMgr.getInstance();
		System.out.println("1. connector 연결 성공.!!");
		System.out.println("2. db연결 성공.!!");
	}
	
	//현재의 시간을 가져오는 함수

			public String getDate() throws Exception{ 
				con = dbcp.getConnection();
				String SQL = "SELECT NOW()";

				try {
					PreparedStatement ps =  con.prepareStatement(SQL);
					rs = ps.executeQuery();
					if(rs.next()) {
						return rs.getString(1);
					}
				} catch (Exception e) {
				e.printStackTrace();
				}
				dbcp.freeConnection(con,ps,rs);
				return ""; //데이터베이스 오류
			}

			//bbsID 게시글 번호 가져오는 함수
			public int getNext() throws Exception { 
				con = dbcp.getConnection();
				String SQL = "SELECT bbsID FROM bbstest ORDER BY bbsID DESC";
				System.out.println("4. SQL문 전송 성공.!!");
				try {
					PreparedStatement ps = con.prepareStatement(SQL);
					rs = ps.executeQuery();
				if(rs.next()) {
						return rs.getInt(1) + 1;
					}
					return 1;//첫 번째 게시물인 경우
				}catch (Exception e) {
					e.printStackTrace();
				}
				dbcp.freeConnection(con,ps,rs);
				return -1; //데이터베이스 오류
			}
			
			//실제로 글을 작성하는 함수
			public int write(String bbsTitle, String id, String bbsContent) throws Exception { 
				con = dbcp.getConnection();
				String SQL = "INSERT INTO bbstest VALUES(?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement ps = con.prepareStatement(SQL);
					ps.setInt(1, getNext());
					ps.setString(2, bbsTitle);
					ps.setString(3, id);
					ps.setString(4, getDate());
					ps.setString(5, bbsContent);
					ps.setInt(6,1);
					ps.setInt(7,0);
					
				
					return ps.executeUpdate();
				}catch (Exception e) {
					e.printStackTrace();
				}
				dbcp.freeConnection(con,ps);
				return -1; //데이터베이스 오류
			}



			
			//게시글 전체목록을 가져오기 위한 함수
			public ArrayList<BbsVO> getList(int pageNumber) throws Exception { 
				con = dbcp.getConnection();
				String sql = "select * from bbstest where bbsID < ? and bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 20";
				
				System.out.println("4. SQL문 전송 성공.!!");
				ArrayList<BbsVO> list = new ArrayList<BbsVO>();
					try {
						PreparedStatement ps = con.prepareStatement(sql);
						ps.setInt(1, getNext() - (pageNumber -1) * 20);
						rs = ps.executeQuery();
					while (rs.next()) {
						BbsVO bbs = new BbsVO();
						bbs.setBbsID(rs.getInt(1));
						bbs.setBbsTitle(rs.getString(2));
						bbs.setId(rs.getString(3));
						bbs.setBbsDate(rs.getString(4));
						bbs.setBbsContent(rs.getString(5));
						bbs.setBbsAvailable(rs.getInt(6));
						bbs.setBbsCount(rs.getInt(7));
						list.add(bbs);
					}
					} catch (Exception e) {
						
						e.printStackTrace();
					}
					dbcp.freeConnection(con,ps,rs);
				return list; 
			}


			//10 단위 페이징 처리를 위한 함수
			public boolean nextPage (int pageNumber) throws Exception{
				con = dbcp.getConnection();
				String sql = "select * from bbstest where bbsID < ? and bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 20";
				
				try {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, getNext() - (pageNumber-1) * 20);
					rs = ps.executeQuery();
					if (rs.next()) {
						return true;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				dbcp.freeConnection(con,ps,rs);
				return false; 		
			}


			public BbsVO getBbsVO(int bbsID) throws Exception {
				con = dbcp.getConnection();
				String SQL = "SELECT * FROM bbstest WHERE bbsID = ?";
				try {
				PreparedStatement ps = con.prepareStatement(SQL);
					ps.setInt(1, bbsID);
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						BbsVO bbs = new BbsVO();
						bbs.setBbsID(rs.getInt(1));
						bbs.setBbsTitle(rs.getString(2));
						bbs.setId(rs.getString(3));
						bbs.setBbsDate(rs.getString(4));
						bbs.setBbsContent(rs.getString(5));
						bbs.setBbsAvailable(rs.getInt(6));
						bbs.setBbsCount(rs.getInt(7));
						return bbs;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				dbcp.freeConnection(con,ps,rs);
				return null;
			}


			//수정 함수

			public int update(int bbsID, String bbsTitle, String bbsContent) throws Exception {
				con = dbcp.getConnection();
					String SQL = "UPDATE bbstest SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
					try {
						PreparedStatement ps = con.prepareStatement(SQL);
						ps.setString(1, bbsTitle);
						ps.setString(2, bbsContent);
						ps.setInt(3, bbsID);
						return ps.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
					dbcp.freeConnection(con,ps,rs);
					return -1; // 데이터베이스 오류
				}
			


			//삭제 함수

			public int delete(int bbsID) throws Exception {
				con = dbcp.getConnection();
				String SQL = "UPDATE bbstest SET bbsAvailable = 0 WHERE bbsID = ?";
				try {
					PreparedStatement ps = con.prepareStatement(SQL);   
					ps.setInt(1, bbsID);
					return ps.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				dbcp.freeConnection(con,ps);
				return -1; // 데이터베이스 오류
			}

			//search
			public List<BbsVO> search(String bbstitle) throws Exception {
				con = dbcp.getConnection();
				String sql = "select * from bbstest where bbstitle like'%"+bbstitle+"%' and bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 20";
				System.out.println("4. SQL문 전송 성공.!!!!!!!");
				List<BbsVO> list = new ArrayList<BbsVO>();
				try {
					PreparedStatement ps = con.prepareStatement(sql);
					
					rs = ps.executeQuery();
				while (rs.next()){
					BbsVO bbs = new BbsVO();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setId(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbsCount(rs.getInt(7));
					System.out.println("검색결과  : " + list + bbs);
					list.add(bbs);	
				}
				} catch (SQLException e) {
					
					e.printStackTrace();
				}	
				dbcp.freeConnection(con,ps,rs);
				return list;
			}
		
			
			// 조회수 업데이트
			   public boolean count_up(BbsVO vo) throws Exception {
				   con = dbcp.getConnection();
			      // 3. sql문을 만든다.(create)
			      String sql = "update bbstest set bbscount=bbscount+1 where bbsid = ?";
			      PreparedStatement ps = con.prepareStatement(sql);

			      ps.setInt(1, vo.getBbsID());
			      System.out.println("3. SQL생성 성공.!!");

			      // 4. sql문은 전송
			      int row = ps.executeUpdate();
			      System.out.println("4. SQL문 전송 성공.!!");

			      boolean result = false;
			      if (row == 1) {
			         result = true;
			      }

			      ps.close();
			      con.close();
			      dbcp.freeConnection(con,ps,rs);
			      return result;
			   }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

