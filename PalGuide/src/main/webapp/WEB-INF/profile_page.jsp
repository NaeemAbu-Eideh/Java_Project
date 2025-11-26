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
        <link rel="stylesheet" href="/css/css.css">
    </head>
    <body class="min-h-screen bg-gradient-to-br from-yellow-50 to-white items-center justify-center">
        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7  block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>
            <div class="mr-30 flex items-center">
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href= <c:out value="/dashboard"/>>
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white">Home</p>
                </a>

                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="">
                    <span class="material-symbols-outlined text-white">docs</span>
                    <p class="ml-1 text-[1.1em] text-white">Request Service</p>
                </a>

                <c:if test="${ user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">My Requests</p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white">Document Analysis</p>
                    </a>
                </c:if>
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="">
                    <span class="material-symbols-outlined text-white">info</span>
                    <p class="ml-1 text-[1.1em] text-white">About Us</p>
                </a>
                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="" >
                    <span class="material-symbols-outlined text-[#DCA53F]">person</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]">Profile</p>
                </a>
                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href= <c:out value="/${user.firstname}/profile/logout"/>>
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white">Logout</p>
                    </a>
                </c:if>
                <c:if test="${user_id == null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href=<c:out value="/login"/>>
                        <span class="material-symbols-outlined text-white">login</span>
                        <p class="ml-1 text-[1.1em] text-white">Login | Register</p>
                    </a>
                </c:if>
            </div>
        </div>

        <div class="w-360 mx-auto mt-20 mb-7">
            <p class="font-bold text-[1.4em] mb-3">My Profile</p>
            <p class="text-[1.2em]">Manage your personal information and settings</p>
        </div>

        <div class="flex w-360 mx-auto">
            <div class="mr-30">
                <div class="w-80 h-73 rounded-2xl shadow-md bg-white pt-10 mb-5">
                    <div class="h-20 w-20 flex items-center justify-center rounded-[50%] bg-[#EAA800] to-[#D79000] mx-auto mb-10">
                        <span class="material-symbols-outlined profile-image text-white">person</span>
                    </div>

                    <p class="text-center mb-5"><c:out value="${user.firstname} ${user.lastname}"/></p>
                    <p class="text-center mb-5"><c:out value="${user.email}"/></p>
                </div>
                <div class="w-80 rounded-2xl shadow-md bg-white pt-10 mb-5 pb-5">
                    <p class=" ml-5 text-[1.2em] mb-6">Account Type</p>
                    <p class="mx-auto flex items-center justify-center border bg-gray-200 rounded-2xl h-14 w-30 text-[1.3em]">
                        <c:if test="${user.role == 'USER'}">
                            <c:out value="Citizen"/>
                        </c:if>
                    </p>
                </div>
            </div>
            <div class="pb-6 w-150 bg-white shadow-md pt-8 rounded-2xl">
                <p class="ml-8 mb-6 text-[1.2em]">Personal Information:</p>
                <div class="ml-12 mb-6">
                    <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span> First Name *</p>
                    <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.firstname}"/> </p>
                </div>
                <div class="ml-12 mb-6">
                    <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>Last Name *</p>
                    <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.lastname}"/> </p>
                </div>
                <div class="ml-12 mb-6">
                    <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span> Phone Number *</p>
                    <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.phone}"/> </p>
                </div>
                <div class="ml-12 mb-6">
                    <p class="text-[1.1em] block mb-2 flex items-center"><span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span> National ID Number  *</p>
                    <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.nationalId}"/> </p>
                    <p class="mt-2 "> National ID Number Cannot Change </p>
                </div>

                <div class="ml-12 mb-6">
                    <p class="text-[1.1em] block mb-2 flex items-center"><span class="material-symbols-outlined text-[#DCA53F] mr-2">date_range</span> Date of berth  *</p>
                    <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.dob}"/>  </p>
                </div>
            </div>
        </div>

    </body>
</html>