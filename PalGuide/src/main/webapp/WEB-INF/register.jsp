<%--
  Created by IntelliJ IDEA.
  User: Naeem Abu-Eideh
  Date: 11/18/2025
  Time: 9:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-[#FEFEF7]">
        <div class="w-30 h-30 mx-auto mt-15 rounded-[50%] bg-[#E4A100] pt-8">
            <img class="w-13 h-13 block mx-auto" src= <c:out value="/img/government.png"/> >
        </div>
        <p class="text-center mt-5 text-[1.4em]">Create Account</p>
        <p class="text-center mt-5 text-[1.4em]">Join the government services portal</p>

        <form:form cssClass="w-150 h-165 mx-auto bg-white shadow-md pt-8" action="/sign-up/register" method="post" modelAttribute="register">
            <p class="ml-8 mb-6 text-[1.2em]">Personal Information:</p>
        </form:form>
    </body>
</html>