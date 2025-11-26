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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"/>
    </head>
    <body class="min-h-screen bg-gradient-to-br from-yellow-50 to-white items-center justify-center py-12 px-4">
        <div class="flex justify-center mb-4">
            <div class="bg-yellow-500 text-white p-4 rounded-full">
                <img class="w-14 block mx-auto" alt="logo" src="/img/government.png" />
            </div>
        </div>

        <p class="text-center mt-5 text-[1.4em]">Create Account</p>
        <p class="text-center mt-5 text-[1.4em]">Join the government services portal</p>

        <div class="flex items-center mb-5 w-140 mx-auto mt-3">
            <div class="w-15 h-15 bg-yellow-500 text-white rounded-full mr-2">
                <p class="text-[1.1em] text-center mt-4">1</p>
            </div>
            <p class="text-[1.2em] mr-10">Personal Info</p>
            <div class="w-30 h-3 bg-gray-300 mr-3"></div>
            <div class="w-15 h-15 bg-gray-300 text-white rounded-full mr-2">
                <p class="text-[1.1em] text-center mt-4">2</p>
            </div>
            <p class="text-[1.2em] mr-10">Security</p>
        </div>

        <form:form cssClass="pb-6 w-150 mx-auto bg-white shadow-md pt-8 rounded-2xl" action="/sign-up/step1/next" method="post" modelAttribute="register">
            <p class="ml-8 mb-6 text-[1.2em]">Personal Information:</p>
            <div class="ml-12 mb-6">
                <p><form:errors path="firstname"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="firstname"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span> First Name *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="firstname"/>
            </div>
            <div class="ml-12 mb-6">
                <p><form:errors path="lastname"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="lastname"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>Last Name *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="lastname"/>
            </div>
            <div class="ml-12 mb-6">
                <p><form:errors path="email"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="email"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">mail</span> Email Address *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="email"/>
            </div>
            <div class="ml-12 mb-6">
                <p><form:errors path="phone"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="phone"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span> Phone Number *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="phone"/>
            </div>
            <div class="ml-12 mb-6">
                <p><form:errors path="nationalId"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="nationalId"><span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span> National ID Number  *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="nationalId"/>
            </div>

            <div class="ml-12 mb-6">
                <p><form:errors path="dob"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="dob"><span class="material-symbols-outlined text-[#DCA53F] mr-2">date_range</span> Date of berth  *</form:label>
                <form:input type="date" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="dob"/>
            </div>

            <div class="ml-12 mb-6">
                <p><form:errors path="password"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="password"><span class="material-symbols-outlined text-[#DCA53F] mr-2">Password</span> Password  *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="password"/>
            </div>
            <div class="ml-12 mb-6">
                <p><form:errors path="confirmPassword"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="confirmPassword"><span class="material-symbols-outlined text-[#DCA53F] mr-2">Password</span> Confirm Password  *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="confirmPassword"/>
            </div>
            <button type="submit"
                    class=" w-140 block mx-auto bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all">
                Next
            </button>
        </form:form>
    </body>
</html>