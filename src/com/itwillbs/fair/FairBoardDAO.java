package com.itwillbs.fair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.itwillbs.fair.FairBoardBean;

public class FairBoardDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	
	private void getCon() throws Exception{ 	
	
		Context init = new InitialContext();
	
	
		DataSource ds =
				(DataSource) init.lookup("java:comp/env/jdbc/project_kjh");
	
		con = ds.getConnection();
		System.out.println("con : "+con);
	
	
	}
	
	
	public void closeDB(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	// insertBoard(게시글쓰기)	
		public void insertBoard(FairBoardBean ab){
			int num = 0;
			System.out.println("test");
			
			try {
				getCon();
				
				sql = "select max(bno) from fairboard_kjh"; 
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					
					num = rs.getInt(1)+1;
					}
					
				System.out.println("글번호 : " + num);
					
				sql = "insert into fairboard_kjh(bno, name, passwd, subject, content,"  
					    + "readcount, re_ref, re_lev, re_seq, date, file) values(?,?,?,?,?,?,?,?,?,now(),?)";
				
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);   //db에는 없지만 위에서 만든 num으로 넣어주면됨
				pstmt.setString(2, ab.getName());
				pstmt.setString(3, ab.getPasswd());
				pstmt.setString(4, ab.getSubject());
				pstmt.setString(5, ab.getContent());
				pstmt.setInt(6, 0);   // readcount 조회수 0 지정 (쓰는당시에는 조회수가 0이기때문)
				pstmt.setInt(7, num);  		
				pstmt.setInt(8, 0); 
				pstmt.setInt(9, 0); 
				pstmt.setString(10, ab.getFile());
			
					
				pstmt.executeUpdate();	
					
				System.out.println("회원 글쓰기 완료!");	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
		}// insertBoard(게시글쓰기)	
		
		
		// getBoardCount()  : 게시판에 글 개수를 리턴하는 메서드
		
		public int getBoardCount(){
			int count = 0;
			
			try {
				getCon();
				
				sql = "select count(*) from fairboard_kjh";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
			
				if(rs.next()){
				     count = rs.getInt(1);  
				}
				System.out.println("게시판 글 개수 확인 : " + count);     
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return count;
			
		}// getBoardCount()  : 게시판에 글 개수를 리턴하는 메서드
		
		
		
		// getBoardList() : 게시판 목록
		
		public ArrayList getBoardList() {
			
			ArrayList boardList = new ArrayList();
			
			try {
				getCon();
				
				sql = "select * from fairboard_kjh " + "order by re_ref desc";
				
	            pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
	            while (rs.next()) {
					
					FairBoardBean ab = new FairBoardBean();
					
					ab.setBno(rs.getInt("bno"));
					ab.setContent(rs.getString("content"));
					ab.setDate(rs.getDate("date"));
					ab.setFile(rs.getString("file"));
					ab.setName(rs.getString("name"));
					ab.setPasswd(rs.getString("passwd"));
					ab.setRe_lev(rs.getInt("re_lev"));
					ab.setRe_ref(rs.getInt("re_ref"));
					ab.setRe_seq(rs.getInt("re_seq"));
					ab.setReadcount(rs.getInt("readcount"));
					ab.setSubject(rs.getString("subject"));
					
					boardList.add(ab);
					
				}
	            System.out.println(" 모든 글 정보 저장 완료!");
				System.out.println(boardList);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return boardList;
		
		}// getBoardList() : 게시판 목록
		
		
		//getBoardList(startRow, pageSize)  => 오버로딩
		
		public ArrayList getBoardList(int startRow, int pageSize){
			
			ArrayList boardList = new ArrayList();
			
			try {
				getCon();
				
				sql = "select * from fairboard_kjh " 
		        		+ "order by re_ref desc,re_seq asc "
						+ "limit ?,?";	
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
			
				rs = pstmt.executeQuery();
			
				while(rs.next()){
					
			    FairBoardBean ab = new FairBoardBean();	
			    
			    ab.setBno(rs.getInt("bno"));
				ab.setContent(rs.getString("content"));
				ab.setDate(rs.getDate("date"));
				ab.setFile(rs.getString("file"));
				ab.setName(rs.getString("name"));
				ab.setPasswd(rs.getString("passwd"));
				ab.setRe_lev(rs.getInt("re_lev"));
				ab.setRe_ref(rs.getInt("re_ref"));
				ab.setRe_seq(rs.getInt("re_seq"));
				ab.setReadcount(rs.getInt("readcount"));
				ab.setSubject(rs.getString("subject"));
				
					
				boardList.add(ab);	
					
				}	
				
				System.out.println("모든 글 정보 저장 완료");
			    System.out.println(boardList);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return boardList;	
			
		}//getBoardList(startRow, pageSize)
		
		
		//updateReadCount(bno)
		public void updateReadCount(int bno){
			
			try {
				getCon();
				
			sql = "update fairboard_kjh set readcount=readcount+1 "
					+ "where bno=?";	
				
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			pstmt.executeUpdate();
			
			System.out.println("조회수 1 증가 완료!");
			
			} catch (Exception e) {
				System.out.println("조회수 1 증가 실패!");
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			
		}//updateReadCount(bno)
		
		
		
			
		//getBoard(bno)
		public FairBoardBean getBoard(int bno) {
			FairBoardBean ab = null;
			
			try {
				getCon();
				
				sql = "select * from fairboard_kjh "
						+ "where bno=?";  
				
	            pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){ 
					ab = new FairBoardBean();
					
					ab.setBno(rs.getInt("bno"));
					ab.setContent(rs.getString("content"));
					ab.setDate(rs.getDate("date"));
					ab.setName(rs.getString("name"));
					ab.setPasswd(rs.getString("passwd"));
					ab.setRe_lev(rs.getInt("re_lev"));
					ab.setRe_ref(rs.getInt("re_ref"));
					ab.setRe_seq(rs.getInt("re_seq"));
					ab.setReadcount(rs.getInt("readcount"));
					ab.setSubject(rs.getString("subject"));
					ab.setFile(rs.getString("file"));
			
				}
				
				System.out.println("해당 글 저장 완료!");
	            System.out.println(ab.toString()); 
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return ab;
			
			
		}//getBoard(bno)
			
			
		// updateBoard(ab)
		
		public int updateBoard(FairBoardBean ab){
			
			int check = -1;
			
			try {
				getCon();
				
				sql = "select passwd from fairboard_kjh where bno=?"; 
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, ab.getBno());
				System.out.println("pstmt? 추가 완료 " + ab.getBno());
				
				rs = pstmt.executeQuery();
				System.out.println("pstmt 실행 및 rs 저장");
				
				if(rs.next()){
					System.out.println("rs.next() 있음");
					if(ab.getPasswd().equals(rs.getString("passwd"))){  
						
			      sql = "update fairboard_kjh set name=?, subject=?, content=?, file=? "
						+ "where bno=?";  		
						
						
			      pstmt = con.prepareStatement(sql);
				  System.out.println("pstmt 객체 생성 완료");
				  
				  pstmt.setString(1, ab.getName());
				  pstmt.setString(2, ab.getSubject());
				  pstmt.setString(3, ab.getContent());
				  pstmt.setString(4, ab.getFile());
				  pstmt.setInt(5, ab.getBno());
				  
				  System.out.println("pstmt 추가 완료");
					
					pstmt.executeUpdate();
				
					System.out.println("게시판 글 수정 완료!");
				
					check = 1;
					
					}else {
						check = 0;
					}
					
				}else{
					check =-1;
				}
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return check;
			
			
		}// updateBoard(ab)
		
		
		// deletePro
		
		public int deleteBoard(int bno,String passwd) {
			
			int result = -1;
			
			try {
				getCon();
				
				sql = "select passwd from fairboard_kjh where bno=?";	
				
	            pstmt = con.prepareStatement(sql);	
				
				pstmt.setInt(1, bno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(passwd.equals(rs.getString("passwd"))){
						// 글삭제
						sql = "delete from fairboard_kjh where bno=?";  
						
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, bno);
							
						//실행
						pstmt.executeUpdate();
						System.out.println("글삭제 완료!");
						result = 1;
				
					}else{
						result = 0;
						System.out.println("글 삭제 에러!" + result);
					}
					
					}else{
						result = -1;
						System.out.println("글 삭제 에러!" + result);
					}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return result;
			
			
			
		}// deletePro(bno, passwd)
		
		
	
	
}
