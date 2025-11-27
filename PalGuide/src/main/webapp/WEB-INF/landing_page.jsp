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
    <body class="min-h-screen bg-gradient-to-br from-yellow-50 to-white items-center justify-center">
        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7  block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>
            <div class="mr-30 flex items-center">
                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="">
                    <span class="material-symbols-outlined text-[#DCA53F]">home</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]">Home</p>
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

                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href= <c:out value="/${user.firstname}/profile"/> >
                        <span class="material-symbols-outlined text-white">person</span>
                        <p class="ml-1 text-[1.1em] text-white">Profile</p>
                    </a>
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href= <c:out value="/dashboard/logout"/>>
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

        <p class="text-center text-[1.2em] mt-20">Welcome to PalGuide Portal</p>
        <p class="w-185 text-center mx-auto text-[1.4em] mt-10">Access essential government services online. Fast, secure, and convenient. Submit requests, track status, and get assistance all in one place.</p>

        <div class="flex items-center mt-10 justify-between w-120 mx-auto mb-15">
            <a class="w-50 bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all flex items-center">
                <span class="ml-10">Request a Service</span>
            </a>
            <a class="w-50 bg-gradient-to-r from-gray-300 to-gray-500 text-white py-3 rounded-lg hover:from-gray-500 hover:to-gray-500 transition-all flex items-center">
                <span class="ml-10">Analyze Document</span>
            </a>
        </div>

        <div class="py-20 bg-white">
            <p class="text-center text-[1.2em] mb-10">Our Services</p>
            <div class="flex mx-auto w-360">
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] to-[#D68E00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">Passport Renewal</p>
                        <p class="w-60">Renew your passport quickly and easily online </p>
                    </div>
                </div>
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] to-[#D68E00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">National ID</p>
                        <p class="w-60">Apply for or renew your national identification</p>
                    </div>
                </div>
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] to-[#D68E00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">Birth Certificate</p>
                        <p class="w-60">Request official birth certificate copies</p>
                    </div>
                </div>
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] to-[#D68E00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">upload</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">Document Analysis</p>
                        <p class="w-60">Get Ai-powered guidance for your documents</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="pt-20 h-100">
            <p class="text-[1.2em] text-center my-10">Why Choose us</p>
            <div class="flex items-center w-360 mx-auto">
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-[50%] bg-[#EAA900] to-[#D68E00] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">pace</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">24/7 Access</p>
                    <p class="text-[1.2em] text-center mb-5">Submit requests anytime, anywhere</p>
                </div>
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-[50%] bg-[#EAA900] to-[#D68E00] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">shield</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">Secure & Safe</p>
                    <p class="text-[1.2em] text-center mb-5">Your data is protected with encryption</p>
                </div>
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-[50%] bg-[#EAA900] to-[#D68E00] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">group</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">Expert Support</p>
                    <p class="text-[1.2em] text-center mb-5">Our team is here to help you</p>
                </div>
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-[50%] bg-[#EAA900] to-[#D68E00] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">check_circle_unread</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">Track Status</p>
                    <p class="text-[1.2em] text-center mb-5">Monitor your requests in real-time</p>
                </div>
            </div>
        </div>

        <div class="h-100 bg-[#D28900] to-[#EFAF00] py-20">
            <p class="text-white text-center mt-10 my-7 text-[1.3em]">Ready to Get Started?</p>
            <p class="text-white text-center mb-7 text-[1.3em]">Join thousands of citizens using our platform for their government service needs</p>
            <a class="block w-70 h-15 mx-auto border px-3 text-center flex items-center justify-center text-[1.4em] text-[#D28900] bg-[#FEFDED] border-2 border-[#FEFDED] rounded-xl" href= <c:out value="/start-request"/> ><span>Start Your Request</span></a>
        </div>

    </body>
</html>