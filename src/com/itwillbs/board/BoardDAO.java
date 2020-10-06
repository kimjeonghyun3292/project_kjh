package com.itwillbs.board;

import java.sql.Connection;


import com.itwillbs.board.BoardBean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
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
		public void insertBoard(BoardBean bb){
			int num = 0;   //글번호 저장 
			System.out.println("test");
			try {
				getCon();
				
			sql = "select max(bno) from board_kjh"; 	
				
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
			num = rs.getInt(1)+1;
			}
			
			System.out.println("글번호 : " + num);
			
			sql = "insert into board_kjh(bno, name, passwd, subject, content,"  
				       + "readcount, re_ref, re_lev, re_seq, date, ip) values(?,?,?,?,?,?,?,?,?,now(),?)";
				
				
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);   //db에는 없지만 위에서 만든 num으로 넣어주면됨
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPasswd());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);   // readcount 조회수 0 지정 (쓰는당시에는 조회수가 0이기때문)
			pstmt.setInt(7, num);  // re_ref 답변글 그룹번호(일반글 번호 동일)		
			pstmt.setInt(8, 0); // re_lev 답변글 들여쓰기(일반글 0)
			pstmt.setInt(9, 0); // re_seq 답변글 순서 (일반글 제일 위쪽)
			pstmt.setString(10, bb.getIp());
				
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
	
		sql = "select count(*) from board_kjh";
	
	
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
			
			sql = "select * from board_kjh " + "order by re_ref desc";
			
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				BoardBean bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				boardList.add(bb);
				
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
		sql = "select * from board_kjh " 
        		+ "order by re_ref desc,re_seq asc "
				+ "limit ?,?";
	
		pstmt = con.prepareStatement(sql);
		
		pstmt.setInt(1, startRow-1);
		pstmt.setInt(2, pageSize);
	
		rs = pstmt.executeQuery();
	
		while(rs.next()){
			
	    BoardBean bb = new BoardBean();	
	    
	    bb.setBno(rs.getInt("bno"));
		bb.setContent(rs.getString("content"));
		bb.setDate(rs.getDate("date"));
		bb.setIp(rs.getString("ip"));
		bb.setName(rs.getString("name"));
		bb.setPasswd(rs.getString("passwd"));
		bb.setRe_lev(rs.getInt("re_lev"));
		bb.setRe_ref(rs.getInt("re_ref"));
		bb.setRe_seq(rs.getInt("re_seq"));
		bb.setReadcount(rs.getInt("readcount"));
		bb.setSubject(rs.getString("subject"));
		
			
		boardList.add(bb);	
			
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
		
		sql = "update board_kjh set readcount=readcount+1 "
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
	public BoardBean getBoard(int bno) {
		BoardBean bb = null;
		
		try {
			getCon();
			
			sql = "select * from board_kjh "
					+ "where bno=?";  
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
		
			}
			
			System.out.println("해당 글 저장 완료!");
            System.out.println(bb.toString()); 
		
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return bb;
		
	}//getBoard(bno)
		
		
	// updateBoard(bb)
	
	public int updateBoard(BoardBean bb){
	
		int check = -1;
		
		try {
			getCon();
			
			sql = "select passwd from board_kjh where bno=?"; 
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getBno());
			System.out.println("pstmt? 추가 완료 " + bb.getBno());
			
			rs = pstmt.executeQuery();
			System.out.println("pstmt 실행 및 rs 저장");
			
			if(rs.next()){
				System.out.println("rs.next() 있음");
				if(bb.getPasswd().equals(rs.getString("passwd"))){  
					
					sql = "update board_kjh set name=?, subject=?, content=? "
							+ "where bno=?";  	
					
					pstmt = con.prepareStatement(sql);
					System.out.println("pstmt 객체 생성 완료");
					
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setInt(4, bb.getBno());
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
		
	}// updateBoard(bb)
	
	
	// deletePro
	
	public int deleteBoard(int bno,String passwd) {
		
		int result = -1;
		
		try {
			getCon();
			
			sql = "select passwd from board_kjh where bno=?";
					
			pstmt = con.prepareStatement(sql);	
			
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){
					// 글삭제
					sql = "delete from board_kjh where bno=?";  
					
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
	public void reInsertBoard(BoardBean bb){
		
		int num = 0;
		
		try {
			getCon();
			
			// 답글 번호 계산
			sql = "select max(bno) from board_kjh";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;  
			}
			System.out.println("답글 번호 : " + num);
			
			
			// 답글 순서 재배치
			sql = "update board_kjh set re_seq=re_seq+1 where re_ref=? and re_seq>?"; 
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			
			pstmt.executeUpdate();
			
			
			// 답글 추가 동작
			sql = "insert into board_kjh values(?,?,?,?,?,?,?,?,?,now(),?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);  
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPasswd());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setInt(7, bb.getRe_ref());  //기존 원글의 그룹번호와 동일
			pstmt.setInt(8, bb.getRe_lev()+1); // 기존의 값 + 1   
			pstmt.setInt(9, bb.getRe_seq()+1); // 기존의 값 + 1  
			pstmt.setString(10, bb.getIp());
			
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
