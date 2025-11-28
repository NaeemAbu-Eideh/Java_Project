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
        <div class="shadow-xl/30 flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7  block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>
            <div class="mr-30 flex items-center">
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/dashboard">
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white">Home</p>
                </a>

                <c:if test="${ user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/request">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">Request Service</p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/my-requests">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">My Requests</p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white">Document Analysis</p>
                    </a>
                </c:if>
                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="">
                    <span class="material-symbols-outlined text-[#DCA53F]">info</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]">About Us</p>
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

        <div class="pt-10 bg-gradient-to-r from-yellow-600 to-yellow-500">
            <p class="mt-10 text-[1.1em] text-white text-center">About Government Services</p>
            <p class="mt-5 pb-25 text-[1.4em] text-white text-center">Dedicated to serving our citizens with excellence, transparency, and innovation</p>
        </div>

        <div class="flex justify-evenly items-center mt-15 mb-10">
            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">2M+</p>
                <p class="text-[1.3em] text-center">Citizens Served</p>
            </div>
            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">500K+</p>
                <p class="text-[1.3em] text-center">Requests Processed</p>
            </div>
            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">98%</p>
                <p class="text-[1.3em] text-center">Satisfaction Rate</p>
            </div>
            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">24/7</p>
                <p class="text-[1.3em] text-center">Service Availability</p>
            </div>
        </div>

        <div class="pt-15 h-110 bg-white">
            <p class="mb-10 text-center text-[1.4em]">Our Core Principles</p>
            <div class="">
                <div class="flex w-350 mx-auto justify-between">
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] to-[#D68E00] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">circle_circle</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold">Our Mission</p>
                            <p class="text-[1.2em]">To provide accessible, efficient, and transparent government services to all citizens through innovative digital solutions.</p>
                        </div>
                    </div>
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] to-[#D68E00] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">group</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold">Our Vision</p>
                            <p class="text-[1.2em]">A future where every citizen can access government services seamlessly, anytime and anywhere, with full transparency and accountability.</p>
                        </div>
                    </div>
                </div>
                <div class="flex w-350 mt-7 mx-auto justify-between">
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] to-[#D68E00] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">license</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold">Our Values</p>
                            <p class="text-[1.2em]">Integrity, transparency, innovation, and citizen-first approach guide everything we do in serving our community.</p>
                        </div>
                    </div>
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] to-[#D68E00] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">language</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold">Our Reach</p>
                            <p class="text-[1.2em]">Serving millions of citizens nationwide with a commitment to continuous improvement and technological advancement.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="pt-15 h-100">
            <p class="mt-10 text-center">Our Story</p>
            <p class="mt-10 w-300 text-[1.1em] mx-auto"><span>Founded in 2020, the Government Services Portal was established to modernize and streamline how citizens interact with government services. What started as a simple online form system has evolved into a comprehensive digital platform serving millions of citizens.</span><br><br><span>Our journey began with a simple question: "How can we make government services more accessible and efficient for everyone?" This question led to the development of our integrated platform that brings together passport services, national ID processing, document verification, and much more.</span><br><br><span>Today, we continue to innovate with cutting-edge technology including AI-powered document analysis, real-time request tracking, and enhanced security measures to protect citizen data. Our commitment remains unchanged: to serve our citizens with excellence and integrity.</span></p>
        </div>
        <div class="pt-15 mt-10 h-90 bg-gradient-to-r bg-gradient-to-r from-yellow-600 to-yellow-500">
            <p class="text-center text-white mb-10">Contact Us</p>
            <div class="flex justify-around w-300 mx-auto">
                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-[50%] bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">phone</span>
                    </div>
                    <p class="mt-3 text-center text-white">Phone</p>
                    <p class="mt-1 text-center text-white">1-800-GOV-SERV</p>
                    <p class="mt-1 text-center text-white">Sun-Thr, 8AM-2PM</p>
                </div>
                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-[50%] bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">email</span>
                    </div>
                    <p class="mt-3 text-center text-white">Email</p>
                    <p class="mt-1 text-center text-white">support@govservices.gov</p>
                    <p class="mt-1 text-center text-white">24/7 Response</p>
                </div>
                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-[50%] bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">location_on</span>
                    </div>
                    <p class="mt-3 text-center text-white">Address</p>
                    <p class="mt-1 text-center text-white">123 Government Plaza</p>
                    <p class="mt-1 text-center text-white">Capital City, 12345</p>
                </div>
            </div>
        </div>

    </body>
</html>