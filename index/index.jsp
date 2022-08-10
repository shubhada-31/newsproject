<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.util.*" %>

<html>
<head>
<title>KC APP BY KS</title>
<style>
.button{
background-color: #04AA6D;
border:none;
color:white;
padding:10px;
font-size:20px;
text-decoration: none;
margin:4px 2px;
}
.button3{border-radius: 20px; }
</style>
</head>
<body>
<center>
<h1>Kamal Classes</h1>
<form method="POST">
<input type ="email" name="em" placeholder="enter email add">
<br><br>
<button class="button button3" name="sub">Subscribe</button>
<button class="button button3" name="unsub">Unsubscribe</button>

</form>
<%
if(request.getParameter("sub")!=null)
{
String em=request.getParameter("em");
try
{
DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
String url="jdbc:mysql://localhost:3306/kc5july22";
String un="root";
String pw="Shubha@2002";
Connection con=DriverManager.getConnection(url,un,pw);
String sql="insert into subs values(?)";
PreparedStatement pst=con.prepareStatement(sql);
pst.setString(1,em);
pst.executeUpdate();
out.println("u have been subs");
 //mail kaha se jayega
 Properties p=System.getProperties();
 p.put("mail.smtp.host", "smtp.gmail.com");
 p.put("mail.smtp.port", 587);
 p.put("mail.smtp.auth", true);
 p.put("mail.smtp.starttls.enable", true);


//aapka un and pw ka authentication
Session ms = Session.getInstance(p, new Authenticator(){ public PasswordAuthentication getPasswordAuthentication() {
String un = "testershubhada@gmail.com";
String pw = "nsiqntndwuapyrso";
return new PasswordAuthentication(un, pw);
   }
 });
try
{
    //mail ko draft karke bhejo
   MimeMessage msg= new MimeMessage(ms);
   msg.setSubject("Mail from Kamal Classes");
   msg.setText("congrats for your subscription");
   msg.setFrom(new InternetAddress("testershubhada@gmail.com"));
   msg.addRecipient(Message.RecipientType.TO, new InternetAddress(em) );
   Transport.send(msg);
    }
   catch(Exception e)
   {
    out.println("issue-->" + e);
   }
con.close();
}

catch(SQLException e)
{
out.println("u are already  subs");
}
}

if(request.getParameter("unsub")!=null)
{
String em=request.getParameter("em");
try{
DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
String url="jdbc:mysql://localhost:3306/kc5july22";
String un="root";
String pw="Shubha@2002";
Connection con=DriverManager.getConnection(url,un,pw);

String s1="select * from subs where email=?";
PreparedStatement p1=con.prepareStatement(s1);
p1.setString(1,em);
ResultSet rs=p1.executeQuery();
if(rs.next()){
String sql="delete from subs where email=?";
PreparedStatement pst=con.prepareStatement(sql);
pst.setString(1,em);
pst.executeUpdate();
out.println("u have been unsubs");
//mail kaha se jayega
 Properties p=System.getProperties();
 p.put("mail.smtp.host", "smtp.gmail.com");
 p.put("mail.smtp.port", 587);
 p.put("mail.smtp.auth", true);
 p.put("mail.smtp.starttls.enable", true);


//aapka un and pw ka authentication
Session ms = Session.getInstance(p, new Authenticator(){ 
 public PasswordAuthentication getPasswordAuthentication() {
String un = "testershubhada@gmail.com";
String pw = "nsiqntndwuapyrso";
return new PasswordAuthentication(un, pw);
   }
 });
try
{
    //mail ko draft karke bhejo
   MimeMessage msg= new MimeMessage(ms);
   msg.setSubject("Mail from Kamal Classes");
   msg.setText("sorry you lost subscription");
   msg.setFrom(new InternetAddress("testershubhada@gmail.com"));
   msg.addRecipient(Message.RecipientType.TO, new InternetAddress(em) );
   Transport.send(msg);
    }
   catch(Exception e)
   {
    out.println("issue-->" + e);
   }
con.close();

 }
else{
out.println("u r not subsribed");
}
con.close();
}
catch(SQLException e)
{
out.println("u r alredy subs");
}
}


%>
</center>
</body>
</html>