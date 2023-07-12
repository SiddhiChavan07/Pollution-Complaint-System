<%@ page language="java" import="java.sql.*"%>
<%@include file="common-database.jsp" %>

<%
    String pincode = request.getParameter("pincode");
    if(pincode.equals("") || pincode == null){
        out.println(" Please enter pincode!");
        return;
    }
    
    try{
        con = fetchConnection();
        stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String selectQuery = "select * from police_station_record where ps_pincode = '"+pincode+"'";
        rs = stmt.executeQuery(selectQuery);
        if(!rs.next()){
            out.println(" Records not found!");
        } else {
            rs.beforeFirst();
            String data = "";
            data = "<tr>"+
                        "<th> Police Station Name </th>"+
                        "<th> Address </th>"+
                        "<th> City </th>"+
                        "<th> Pincode </th>"+
                        "<th> Contact No </th>"+
                    "</tr>";
            while(rs.next()){
                data += "<tr>"+
                            "<td valign=\"middle\">"+rs.getString("ps_name")+"</td>"+
                            "<td valign=\"middle\">"+rs.getString("ps_address")+"</td>"+
                            "<td valign=\"middle\">"+rs.getString("ps_city")+"</td>"+
                            "<td valign=\"middle\">"+rs.getString("ps_pincode")+"</td>"+
                            "<td valign=\"middle\">"+rs.getString("contact_no")+"</td>"+
                        "</tr>";
            }
            out.println(data);
        }
    } catch(Exception e){
        out.println(" Display police station data by pincode exception: " +e);
    } finally {
        closeConnection();
    }
%>