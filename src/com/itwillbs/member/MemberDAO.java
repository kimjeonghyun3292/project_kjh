package com.itwillbs.member;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {

	 Connection con = null;
	 PreparedStatement pstmt = null;
	 ResultSet rs = null;
	 String sql = "";
	 
	 
	 private Connection getCon() throws Exception{ 
		 
		 Context init = new InitialContext();
		 
		 DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/project_kjh");
		 
		 con = ds.getConnection();
		 
		 return con;
		 
	 }
	
	 public void closeDB(){
		 try{
			 if( rs!= null) rs.close();
			 if( pstmt!=null) pstmt.close();
			 if( con !=null) con.close();
		 }catch (SQLException e){
			 e.printStackTrace();
		 }
	 }
	
	

	    // 회원가입 메서드(insertMember())
	    public void insertMember(MemberBean mb){  
	    	
	    	try {
	    	con = getCon();
	    	
	    	// sql
	    	sql = "insert into project_kjh(id,pass,pass2,name,birthday,gender,"
	    			+ "phone,zip,addr1,addr2,email,event) values(?,?,?,?,?,?,?,?,?,?,?,?)";
	    	
	    	pstmt = con.prepareStatement(sql);
	    	
	    	// ?
	    	pstmt.setString(1, mb.getId());
	    	pstmt.setString(2, mb.getPass());
	    	pstmt.setString(3, mb.getPass2());
	        pstmt.setString(4, mb.getName());
	        pstmt.setInt(5, mb.getBirthday());
	        pstmt.setString(6, mb.getGender());
	        pstmt.setString(7, mb.getPhone());
	        pstmt.setInt(8, mb.getZip());
	        pstmt.setString(9, mb.getAddr1());
	        pstmt.setString(10, mb.getAddr2());
	        pstmt.setString(11, mb.getEmail());
	        pstmt.setString(12, mb.getEvent());
	        
	        
	        // 실행
	        pstmt.executeUpdate();
	        
	        System.out.println("회원 정보 가입 완료!");
	        
	    	} catch (Exception e) {
				e.printStackTrace();
			}finally{
				
			}closeDB();
	    
	    
	        
	    }// 회원가입 메서드(insertMember())

	 
	  //getMember(id)
		public MemberBean getMember(String id){
			MemberBean mb = null;  
	
		
				
				try {
					con = getCon();
				
				
			
				sql = "select * from project_kjh where id=?";
				pstmt = con.prepareStatement(sql);
				
			 
				pstmt.setString(1, id);
			
				rs=pstmt.executeQuery();
			
				if(rs.next()){
				
					mb = new MemberBean();
	 
					mb.setBirthday(rs.getInt("birthday"));  
					mb.setEmail(rs.getString("email"));
					mb.setGender(rs.getString("gender"));
					mb.setId(rs.getString("id"));
					mb.setName(rs.getString("name"));
					mb.setPass(rs.getString("pass"));
					mb.setPhone(rs.getString("phone"));
					mb.setEvent(rs.getString("event"));
					mb.setAddr1(rs.getString("addr1"));
					mb.setAddr2(rs.getString("addr2"));
					mb.setZip(rs.getInt("zip"));
					
					
					System.out.println("회원정보 저장 완료!");
					System.out.println(mb);
					
				}
				
				System.out.println(" 구문 실행 완료! ");
	 
		    } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}finally {
				closeDB();
			
			}
				return mb;
	 
		}//getMember(id)
	 
	 
	 
	 
	 
	 
	
	// 로그인 체크 메서드 idCheck(id,pass)
	 public int idCheck(String id, String pass){
	 	int result = -1;
	 	
	 
	 	try {
	 	con = getCon();
	 	
	 	sql = "select pass from project_kjh where id=?";
	 	
	 	pstmt = con.prepareStatement(sql);
	 	
	 	pstmt.setString(1, id);
	 	
	 	rs = pstmt.executeQuery();
	 	
	 	
	 	if(rs.next()){
	 		if(pass.equals(rs.getString("pass"))){
	 			result = 1;  
	 		}else{
	 	       result = 0;   
	 	
	 		}
	 	}else{
	 		result = -1;  
	 	}
	 	
	 	System.out.println("로그인 처리 완료 : " + result);
	 	
	 	
	 	
	 	} catch (Exception e){
	 		e.printStackTrace();
	 	} finally {
	 		closeDB();
	 	}
	 	

	 	return result;
	 	
	 
	  	
	 	
	 }//idCheck(id,pass)


   //updateMember(id)
	public int updateMember(MemberBean mb){
		int result = -1;
		
    
	
	   try {
	
			con = getCon();
		
	
	   sql = "select pass from project_kjh where id=?";
	   
	   pstmt = con.prepareStatement(sql);
	   
	   pstmt.setString(1, mb.getId());
	   
	  rs = pstmt.executeQuery(); 
	
	   if(rs.next()){
	    	if(mb.getPass().equals(rs.getString("pass"))){
	
	    sql = "update project_kjh set name=?, birthday=?, gender=?, phone=?, zip=?, addr1=?, addr2=?, email=?, event=? " 
	    	 + "where id=?";
	
	    		pstmt = con.prepareStatement(sql);
	    		
	    		
	    		pstmt.setString(1, mb.getName());
	    		pstmt.setInt(2, mb.getBirthday());
	    		pstmt.setString(3, mb.getGender());
	    		pstmt.setString(4, mb.getPhone());
	    		pstmt.setInt(5, mb.getZip());
	    		pstmt.setString(6, mb.getAddr1());
	    		pstmt.setString(7, mb.getAddr2());
	    		pstmt.setString(8, mb.getEmail());
	    		pstmt.setString(9, mb.getEvent());
	    		pstmt.setString(10, mb.getId());
	    		
	    		pstmt.executeUpdate();
	    		
	    		System.out.println("정보수정완료");
	
	    		result = 1;
	    	}else{
	    		result = 0;
	    	}
	    	
	    }else{
	    	//사용자가 없는 경우
	    	result = -1;
	    }
	    
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		
	}finally{
		closeDB();
	}
	return result;
	
		  
	
}//updateMember(id)


//deleteMember(id,pass)
	public int deleteMember(String id,String pass){
		int result = -1;
		
		
		try {
			// 1,2 디비 연결
		     con = getCon();
			
			// 3 SQL 구문작성
			sql = "select pass from project_kjh where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			// 4 실행 -> rs
			rs = pstmt.executeQuery();
			
			// 5 데이터처리	
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 3
					sql = "delete from project_kjh where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					// 4
					pstmt.executeUpdate();
					result = 1;
				}else{
				   result = 0;	
				}				
			}else{
				result =-1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}//deleteMember(id,pass)


	// 중복아이디 체크하는 메서드 joinIdCheck(id)
	public int joinIdCheck(String id){
		int result = -1;
		
		   
		   try{
		  
		   getCon();
		   
		  
		   sql = "select * from project_kjh where id=?";
		   pstmt = con.prepareStatement(sql);
		   
		  
		   pstmt.setString(1, id);
		   
		  
		   rs = pstmt.executeQuery();
		   
		  
		   if(rs.next()){
			   result=0;  
			     
			   }else{
				   result=1; 
			   
		   }
		   
		   System.out.println("아이디 중복체크 : " + result);
		   
		   } catch (Exception e) {
				e.printStackTrace();
			}finally{
				closeDB();
			
				  
			
			}
		   
		   return result;
	   } 
	// 중복아이디 체크하는 메서드 joinIdCheck(id)   
		
		
	
	
	
	

}

