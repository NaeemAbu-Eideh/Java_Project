<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${param.lang != null ? param.lang : sessionScope['jakarta.servlet.jsp.jstl.fmt.locale.session']}"
               scope="session"/>
<fmt:setBundle basename="messages"/>

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
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>

            <div class="mr-30 flex items-center">

                <!-- Home -->
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/dashboard">
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.home"/></p>
                </a>

                <!-- Document Analysis -->
                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.documentAnalysis"/></p>
                    </a>
                </c:if>

                <!-- About -->
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/about-us">
                    <span class="material-symbols-outlined text-white">info</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.aboutUs"/></p>
                </a>

                <!-- Profile -->
                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all"
                       href="<c:out value='/${user.firstname}/profile'/>">
                        <span class="material-symbols-outlined text-white">person</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.profile"/></p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all"
                       href="/dashboard/logout">
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.logout"/></p>
                    </a>
                </c:if>

                <!-- Login -->
                <c:if test="${user_id == null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/login">
                        <span class="material-symbols-outlined text-white">login</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.loginRegister"/></p>
                    </a>
                </c:if>
                <div class="flex items-center gap-3 ml-4">

                    <select onchange="changeLang(this.value)"
                            class="px-3 py-2 rounded-lg bg-white text-yellow-700 font-semibold cursor-pointer">

                        <option value="en" <c:if test="${pageContext.response.locale.language == 'en'}">selected</c:if>>
                            🇬🇧 English
                        </option>

                        <option value="ar" <c:if test="${pageContext.response.locale.language == 'ar'}">selected</c:if>>
                            🇵🇸 عربي
                        </option>

                    </select>

                </div>

            </div>
        </div>

        <!-- 404 CONTENT -->
        <div class="mt-20">
            <h1 class="text-center text-4xl font-bold mb-5">
                <fmt:message key="error.404.title"/>
            </h1>

            <p class="text-center text-5xl font-bold">404</p>

            <p class="text-center text-2xl my-10">
                <fmt:message key="error.404.description"/>
            </p>
        </div>

    </body>
</html>
