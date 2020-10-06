<%@page import="com.itwillbs.file.FileBoardBean"%>
<%@page import="com.itwillbs.file.FileBoardDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@ page import="java.awt.Graphics2D" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>WebContent/board/writePro.jsp</h1>
  
  <%
  
  request.setCharacterEncoding("UTF-8");
  
  
  %>
   
   <jsp:useBean id="fb" class="com.itwillbs.file.FileBoardBean"/>
 
 <% 
  
 %>
 <jsp:setProperty property="*" name="fb"/>
 

 
 
 <%
     // 파일 저장 위치 (가상경로-upload폴더)
     // 실제 저장위치 : 
     // -> D:\workspace_jsp7\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\fileUpload/upload
     //System.out.println("가상경로 : " + request.getRealPath("/upload"));
     String uploadPath = request.getRealPath("/upload");
     System.out.println("============ uploadFilePath = " + uploadPath); 
     
     // 저장 크기 지정(10MB)
     int maxSize = 10 * 1024 * 1024;
     
     // 정보 저장 변수
  //   String name = "";
  //   String subject = "";
       String filename = "";
       String OFilename= "";
     
     
     try{
     // MultipartRequest 객체 사용 파일업로드
     MultipartRequest multi = new MultipartRequest(
    		                    request,
    		                    uploadPath,
     		                    maxSize,
    		                    "UTF-8",
    		                    new DefaultFileRenamePolicy()
    		                    );
     
     
     
     // 파일업로드 완료
     
     // 전달되는 이름, 제목 저장
     
     fb.setName(multi.getParameter("name"));
     fb.setPasswd(multi.getParameter("passwd"));
     fb.setSubject(multi.getParameter("subject"));
     fb.setContent(multi.getParameter("content"));
     
     
     // 전달된 파일의 이름 확인
     Enumeration files = multi.getFileNames();
     
     String file1 = (String)files.nextElement();
     // 서버에 저장되는 파일 이름
     fb.setFile(multi.getFilesystemName(file1));
     System.out.println("filename : " + filename);
     
     // 원래 파일이름
     fb.setFile(multi.getOriginalFileName(file1));
     System.out.println("OFilename :" + OFilename);
     
     // 업로드 동작 끝
     // => 예외 발생 가능성 높음
     
     }catch(Exception e){
    	 e.printStackTrace();
     }
     
     
     
     
     %>
     
     
     <%
   
   ServletContext context = request.getServletContext();
   
 //  String imagePath = context.getRealPath("/upload");
//   int size = 1*1024*1024;
//   String filename = "";
   
  
		   
		   
	ParameterBlock pb = new ParameterBlock();	   
   
    pb.add(uploadPath + "/" + fb.getFile());
    RenderedOp rOp = JAI.create("fileload", pb);
    
    BufferedImage bi = rOp.getAsBufferedImage();
    BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_RGB);
    Graphics2D g = thumb.createGraphics();
    g.drawImage(bi, 0, 0, 100, 100, null);
    File file = new File(uploadPath + "/sm_" + fb.getFile());
    ImageIO.write(thumb, "jpg", file);
   
   %>

  <%-- --   -원본이미지-<br>
    <img src = "../upload/<%=file %>"><p>
    -썸네일이미지-<br>
    <img src = "../upload/sm_<%=file %>">   --%>
     
     
 
     <% 
 
 System.out.println(fb);
 
     
 FileBoardDAO fdao = new FileBoardDAO();
  
 fdao.insertBoard(fb);
  
 response.sendRedirect("boardList.jsp");
  
  
 %> 
 
 
 
 
 
 
 
 
  
  
  
</body>
</html>