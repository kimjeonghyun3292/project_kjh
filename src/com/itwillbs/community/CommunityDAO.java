package com.itwillbs.community;

import java.sql.Connection;


import com.itwillbs.board.BoardBean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommunityDAO {
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
		public void insertBoard(CommunityBean cb){
			int num = 0;   //글번호 저장 
			System.out.println("test");
			try {
				getCon();
				
			sql = "select max(bno) from community_kjh"; 	
				
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
			num = rs.getInt(1)+1;
			}
			
			System.out.println("글번호 : " + num);
			
			sql = "insert into community_kjh(bno, name, passwd, subject, content,"  
				       + "readcount, re_ref, re_lev, re_seq, date, ip) values(?,?,?,?,?,?,?,?,?,now(),?)";
				
				
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);   //db에는 없지만 위에서 만든 num으로 넣어주면됨
			pstmt.setString(2, cb.getName());
			pstmt.setString(3, cb.getPasswd());
			pstmt.setString(4, cb.getSubject());
			pstmt.setString(5, cb.getContent());
			pstmt.setInt(6, 0);   // readcount 조회수 0 지정 (쓰는당시에는 조회수가 0이기때문)
			pstmt.setInt(7, num);  // re_ref 답변글 그룹번호(일반글 번호 동일)		
			pstmt.setInt(8, 0); // re_lev 답변글 들여쓰기(일반글 0)
			pstmt.setInt(9, 0); // re_seq 답변글 순서 (일반글 제일 위쪽)
			pstmt.setString(10, cb.getIp());
				
			pstmt.executeUpdate();	
				
			System.out.println("회원 글쓰기 완료!");	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
		
		}// insertBoard(게시글쓰기)
		
	
	
	
	// getBoardCount()  : 게시판에 글 개수를 리턴하는 메서드
	public int getBoardCount(){
		int count = 0;
	
		try {
		getCon();
	
		sql = "select count(*) from community_kjh";
	
	
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
			
			sql = "select * from community_kjh " + "order by re_ref desc";
			
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				CommunityBean cb = new CommunityBean();
				
				cb.setBno(rs.getInt("bno"));
				cb.setContent(rs.getString("content"));
				cb.setDate(rs.getDate("date"));
				cb.setIp(rs.getString("ip"));
				cb.setName(rs.getString("name"));
				cb.setPasswd(rs.getString("passwd"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setReadcount(rs.getInt("readcount"));
				cb.setSubject(rs.getString("subject"));
				
				boardList.add(cb);
				
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
		
		//최신글 가장위쪽으로 보이게
		sql = "select * from community_kjh " 
        		+ "order by re_ref desc,re_seq asc "
				+ "limit ?,?";
	
		pstmt = con.prepareStatement(sql);
		
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
	
		rs = pstmt.executeQuery();
	
		while(rs.next()){
			
	    CommunityBean cb = new CommunityBean();	
	    
	    cb.setBno(rs.getInt("bno"));
		cb.setContent(rs.getString("content"));
		cb.setDate(rs.getDate("date"));
		cb.setIp(rs.getString("ip"));
		cb.setName(rs.getString("name"));
		cb.setPasswd(rs.getString("passwd"));
		cb.setRe_lev(rs.getInt("re_lev"));
		cb.setRe_ref(rs.getInt("re_ref"));
		cb.setRe_seq(rs.getInt("re_seq"));
		cb.setReadcount(rs.getInt("readcount"));
		cb.setSubject(rs.getString("subject"));
		
			
		boardList.add(cb);	
			
		}	
		
		System.out.println("모든 글 정보 저장 완료");
	    System.out.println(boardList);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return boardList;	
			
			
		}//getBoardList(startRow, pageSize)
	
	
	//updateReadCount(bno)
	public void updateReadCount(int bno){
	    
		try {
		getCon();
		
		sql = "update community_kjh set readcount=readcount+1 "
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
	public CommunityBean getBoard(int bno) {
		CommunityBean cb = null;
		
		try {
			getCon();
			
			sql = "select * from community_kjh "
					+ "where bno=?";  
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				cb = new CommunityBean();
				
				cb.setBno(rs.getInt("bno"));
				cb.setContent(rs.getString("content"));
				cb.setDate(rs.getDate("date"));
				cb.setIp(rs.getString("ip"));
				cb.setName(rs.getString("name"));
				cb.setPasswd(rs.getString("passwd"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setReadcount(rs.getInt("readcount"));
				cb.setSubject(rs.getString("subject"));
		
			}
			
			System.out.println("해당 글 저장 완료!");
            System.out.println(cb.toString()); 
		
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cb;
		
	}//getBoard(bno)
		
		
	// updateBoard(cb)
	
	public int updateBoard(CommunityBean cb){
	
		int check = -1;
		
		try {
			getCon();
			
			sql = "select passwd from community_kjh where bno=?"; 
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getBno());
			System.out.println("pstmt? 추가 완료 " + cb.getBno());
			
			rs = pstmt.executeQuery();
			System.out.println("pstmt 실행 및 rs 저장");
			
			if(rs.next()){
				System.out.println("rs.next() 있음");
				if(cb.getPasswd().equals(rs.getString("passwd"))){  
					
					sql = "update community_kjh set name=?, subject=?, content=? "
							+ "where bno=?";  	
					
					pstmt = con.prepareStatement(sql);
					System.out.println("pstmt 객체 생성 완료");
					
					pstmt.setString(1, cb.getName());
					pstmt.setString(2, cb.getSubject());
					pstmt.setString(3, cb.getContent());
					pstmt.setInt(4, cb.getBno());
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
		
	}// updateBoard(cb)
	
	
	// deletePro
	
	public int deleteBoard(int bno,String passwd) {
		
		int result = -1;
		
		try {
			getCon();
			
			sql = "select passwd from community_kjh where bno=?";
					
			pstmt = con.prepareStatement(sql);	
			
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					// 글삭제
					sql = "delete from community_kjh where bno=?";  
					
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
	
	
	
	// reInsertBoard(bb)
	public void reInsertBoard(CommunityBean cb){
		
		int num = 0;
		
		try {
			getCon();
			
			// 답글 번호 계산
			sql = "select max(bno) from community_kjh";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;  
			}
			System.out.println("답글 번호 : " + num);
			
			
			// 답글 순서 재배치
			sql = "update community_kjh set re_seq=re_seq+1 where re_ref=? and re_seq>?"; 
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getRe_ref());
			pstmt.setInt(2, cb.getRe_seq());
			
			pstmt.executeUpdate();
			
			
			// 답글 추가 동작
			sql = "insert into community_kjh values(?,?,?,?,?,?,?,?,?,now(),?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);  
			pstmt.setString(2, cb.getName());
			pstmt.setString(3, cb.getPasswd());
			pstmt.setString(4, cb.getSubject());
			pstmt.setString(5, cb.getContent());
			pstmt.setInt(6, cb.getReadcount());
			pstmt.setInt(7, cb.getRe_ref());  //기존 원글의 그룹번호와 동일
			pstmt.setInt(8, cb.getRe_lev()+1); // 기존의 값 + 1   
			pstmt.setInt(9, cb.getRe_seq()+1); // 기존의 값 + 1  
			pstmt.setString(10, cb.getIp());
			
			pstmt.executeUpdate();
			System.out.println("답글 저장 완료!");
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
	}// reInsertBoard(bb)
	
	
	
	

}
