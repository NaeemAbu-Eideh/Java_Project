<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

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

        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600 sticky top-0 mb-10">

            <!-- LOGO + APP NAME -->
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">
                    <fmt:message key="navbar.appName"/>
                </p>
            </div>

            <!-- NAV LINKS -->
            <div class="mr-30 flex items-center">

                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="/">
                    <span class="material-symbols-outlined text-[#DCA53F]">home</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]">
                        <fmt:message key="navbar.home"/>
                    </p>
                </a>

                <c:if test="${user_id != null}">
                    <c:if test="${user.role == 'USER'}">
                        <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/request">
                            <span class="material-symbols-outlined text-white">docs</span>
                            <p class="ml-1 text-[1.1em] text-white">
                                <fmt:message key="navbar.requestService"/>
                            </p>
                        </a>
                    </c:if>

                    <c:if test="${user.role != 'USER'}">
                        <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/dash">
                            <span class="material-symbols-outlined text-white">docs</span>
                            <p class="ml-1 text-[1.1em] text-white">
                                <fmt:message key="navbar.requestsDashboard"/>
                            </p>
                        </a>
                    </c:if>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/my-requests">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.myRequests"/>
                        </p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.documentAnalysis"/>
                        </p>
                    </a>
                </c:if>

                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/about-us">
                    <span class="material-symbols-outlined text-white">info</span>
                    <p class="ml-1 text-[1.1em] text-white">
                        <fmt:message key="navbar.aboutUs"/>
                    </p>
                </a>

                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all"
                       href="<c:out value='/${user.firstname}/profile'/>">
                        <span class="material-symbols-outlined text-white">person</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.profile"/>
                        </p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all"
                       href="<c:out value='/dashboard/logout'/>">
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.logout"/>
                        </p>
                    </a>
                </c:if>

                <c:if test="${user_id == null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all"
                       href="<c:out value='/login'/>">
                        <span class="material-symbols-outlined text-white">login</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.loginRegister"/>
                        </p>
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

        <!-- HERO SECTION -->
        <p class="text-center text-[1.2em] mt-20">
            <fmt:message key="hero.title"/>
        </p>

        <p class="w-185 text-center mx-auto text-[1.4em] mt-10">
            <fmt:message key="hero.subtitle"/>
        </p>

        <!-- BUTTONS -->
        <div class="flex items-center mt-10 justify-between w-120 mx-auto mb-15">

            <a class="w-50 bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all flex items-center"
               href="<c:out value='/request'/>">
                <span class="ml-10">
                    <fmt:message key="buttons.request"/>
                </span>
            </a>

            <a class="border-2 border-yellow-600 w-50 text-yellow-600 py-3 rounded-lg hover:bg-yellow-200 transition-all flex items-center"
               href="<c:out value='/analysis'/>">
                <span class="ml-10">
                    <fmt:message key="buttons.analysis"/>
                </span>
            </a>
        </div>

        <!-- SERVICES -->
        <div class="py-20 bg-white">

            <p class="text-center text-[1.2em] mb-10">
                <fmt:message key="services.title"/>
            </p>

            <div class="flex mx-auto w-360">

                <!-- Passport -->
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">
                            <fmt:message key="services.passport"/>
                        </p>
                        <p class="w-60">
                            <fmt:message key="services.passport.desc"/>
                        </p>
                    </div>
                </div>

                <!-- National ID -->
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">
                            <fmt:message key="services.id"/>
                        </p>
                        <p class="w-60">
                            <fmt:message key="services.id.desc"/>
                        </p>
                    </div>
                </div>

                <!-- Birth Certificate -->
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">docs</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">
                            <fmt:message key="services.birth"/>
                        </p>
                        <p class="w-60">
                            <fmt:message key="services.birth.desc"/>
                        </p>
                    </div>
                </div>

                <!-- Document Analysis -->
                <div class="border-gray-300 hover:border-[#EEAD00] border-2 rounded-xl w-100 mr-7">
                    <div class="ml-7 mt-5 mb-4 h-12 w-12 bg-[#EEAD00] rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white">upload</span>
                    </div>
                    <div class="ml-7 mb-10">
                        <p class="text-[1.3em]">
                            <fmt:message key="services.document"/>
                        </p>
                        <p class="w-60">
                            <fmt:message key="services.document.desc"/>
                        </p>
                    </div>
                </div>

            </div>
        </div>

        <!-- WHY CHOOSE US -->
        <div class="pt-20 h-100">
            <p class="text-[1.2em] text-center my-10">
                <fmt:message key="why.title"/>
            </p>

            <div class="flex items-center w-360 mx-auto">

                <!-- 24/7 Access -->
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-full bg-[#EAA900] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">pace</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.access"/>
                    </p>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.access.desc"/>
                    </p>
                </div>

                <!-- Secure -->
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-full bg-[#EAA900] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">shield</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.secure"/>
                    </p>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.secure.desc"/>
                    </p>
                </div>

                <!-- Support -->
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-full bg-[#EAA900] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">group</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.support"/>
                    </p>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.support.desc"/>
                    </p>
                </div>

                <!-- Track -->
                <div class="w-90 mr-7">
                    <div class="h-12 w-12 flex items-center justify-center rounded-full bg-[#EAA900] mx-auto mb-7 mt-3">
                        <span class="material-symbols-outlined text-white">check_circle_unread</span>
                    </div>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.track"/>
                    </p>
                    <p class="text-[1.2em] text-center mb-5">
                        <fmt:message key="why.track.desc"/>
                    </p>
                </div>

            </div>
        </div>

        <!-- READY SECTION -->
        <div class="h-100 bg-[#D28900] py-20">
            <p class="text-white text-center mt-10 mb-7 text-[1.3em]">
                <fmt:message key="start.title"/>
            </p>

            <p class="text-white text-center mb-7 text-[1.3em]">
                <fmt:message key="start.subtitle"/>
            </p>

            <a class="block w-70 h-15 mx-auto border px-3 text-center flex items-center justify-center text-[1.4em] text-[#D28900] bg-[#FEFDED] border-2 border-[#FEFDED] rounded-xl"
               href="<c:out value='/start-request'/>">
                <span>
                    <fmt:message key="start.button"/>
                </span>
            </a>
        </div>

        <script>
            function changeLang(lang) {
                let url = window.location.pathname;
                window.location.href = url + "?lang=" + lang;
            }
        </script>

    </body>
</html>
