<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String dbURL = "jdbc:mysql://localhost:3306/ultras";
    String dbUser = "root";
    String dbPassword = "";

    Connection connection = null;
    PreparedStatement updateStatement = null;

    String idStr = request.getParameter("id");
    String name = request.getParameter("name");
    String brandIdStr = request.getParameter("brand_id");
    String priceStr = request.getParameter("price");
    String color = request.getParameter("color");
    String specification = request.getParameter("specification");
    String image = request.getParameter("image");
    
    if (idStr == null || brandIdStr == null || priceStr == null || name == null || color == null || specification == null || image == null) {
        out.println("<div class='alert alert-danger'>Missing required parameters.</div>");
    } else {
        int id = Integer.parseInt(idStr);
        int brand_id = Integer.parseInt(brandIdStr);
        int price = Integer.parseInt(priceStr);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String updateQuery = "UPDATE products SET name = ?, brand_id = ?, price = ?, color = ?, specification = ?, image = ? WHERE id = ?";
            updateStatement = connection.prepareStatement(updateQuery);
            updateStatement.setString(1, name);
            updateStatement.setInt(2, brand_id);
            updateStatement.setInt(3, price);
            updateStatement.setString(4, color);
            updateStatement.setString(5, specification);
            updateStatement.setString(6, image);
            updateStatement.setInt(7, id);

            int rowsAffected = updateStatement.executeUpdate();

            if (rowsAffected > 0) {
            	
                out.println("<div class='alert alert-success'>Product updated successfully!</div>");
                response.sendRedirect("viewproduct.jsp");

            } else {
                out.println("<div class='alert alert-danger'>Failed to update product. Please try again.</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div>");
        } finally {
            try {
                if (updateStatement != null) updateStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

</html>
