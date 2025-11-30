
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
                <p class="text-center mt-5 "><span class=" material-symbols-outlined bg-yellow-500">check_circle_unread</span></p>
            </div>
            <p class="text-[1.2em] mr-10">Personal Info</p>
            <div class="w-30 h-3 bg-yellow-500 mr-3"></div>
            <div class="w-15 h-15 bg-yellow-500 text-white rounded-full mr-2">
                <p class="text-[1.1em] text-center mt-4">2</p>
            </div>
            <p class="text-[1.2em] mr-10">Address</p>
        </div>

        <form:form cssClass="pb-6 w-150 mx-auto bg-white shadow-md pt-8 rounded-2xl" action="/sign-up/step2/register" method="post" modelAttribute="address">
            <p class="ml-8 mb-6 text-[1.2em]">Personal Information:</p>
            <div class="ml-12 mb-6">
                <p class="mt-2 text-sm text-red-600"><form:errors path="state"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="state"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">flag</span> State *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="state"/>
            </div>
            <div class="ml-12 mb-6">
                <p class="mt-2 text-sm text-red-600"><form:errors path="city"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="city"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">location_city</span>City *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="city"/>
            </div>
            <div class="ml-12 mb-6">
                <p class="mt-2 text-sm text-red-600"><form:errors path="street"/></p>
                <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="street"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">add_road</span> Street *</form:label>
                <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="street"/>
            </div>
            <div class="flex items-center justify-around">
                <a  class="text-center w-40 block mx-auto bg-gradient-to-r from-gray-600 to-gray-500 text-white py-3 rounded-lg hover:from-gray-300 hover:to-gray-600 transition-all"
                    href=<c:out value="/sign-up/step2/back"/>>
                    Back
                </a>
                <button type="submit"
                        class=" w-40 block mx-auto bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all">
                    Create
                </button>
            </div>
            <div class="flex items-center my-4">
                <span class="flex-1 border"></span>
                <span class="px-4 text-gray-500">Or</span>
                <span class="flex-1 border"></span>
            </div>

            <p class="text-center text-gray-700 mt-3">
                Already hava an account?
                <a class="text-yellow-600 font-semibold hover:underline" href= <c:out value="/login"/> >Go to Login</a>
            </p>
        </form:form>
    </body>
</html>
