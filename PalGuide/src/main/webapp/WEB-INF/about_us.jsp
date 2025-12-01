<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${param.lang != null ? param.lang : sessionScope['jakarta.servlet.jsp.jstl.fmt.locale.session']}"
               scope="session"/> <fmt:setBundle basename="messages"/>

<html
        lang="${pageContext.response.locale.language}"
        dir="${pageContext.response.locale.language == 'ar' ? 'rtl' : 'ltr'}"
        class="${pageContext.response.locale.language == 'ar' ? 'rtl' : ''}"
>
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"/>
        <link rel="stylesheet" href="/css/css.css">
    </head>

    <body class="min-h-screen bg-gradient-to-br from-yellow-50 to-white items-center justify-center">
        <div class="shadow-xl/30 flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">

            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]"><fmt:message key="navbar.appName"/></p>
            </div>

            <div class="mr-30 flex items-center ltr-only">

                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dashboard"> <span
                        class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.home"/></p>
                </a>

                <c:if test="${user_id != null}"> <c:if test="${user.role == 'USER'}"> <a
                        class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/request"> <span
                        class="material-symbols-outlined text-white">docs</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestService"/></p>
                </a> </c:if>

                    <c:if test="${user.role != 'USER'}"> <a
                            class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dash"> <span
                            class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestsDashboard"/></p>
                    </a> </c:if>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/my-requests">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.myRequests"/></p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/analysis"> <span
                            class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.documentAnalysis"/></p>
                    </a> </c:if>

                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="/about-us"> <span
                        class="material-symbols-outlined text-[#DCA53F]">info</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]"><fmt:message key="navbar.aboutUs"/></p>
                </a>

                <c:if test="${user_id != null}"> <a
                        class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                        href="/${user.firstname}/profile"> <span
                        class="material-symbols-outlined text-white">person</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.profile"/></p>
                </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dashboard/logout">
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.logout"/></p>
                    </a> </c:if>

                <c:if test="${user_id == null}"> <a
                        class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/login"> <span
                        class="material-symbols-outlined text-white">login</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.loginRegister"/></p>
                </a> </c:if>

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

        <div class="pt-10 bg-gradient-to-r from-yellow-600 to-yellow-500">
            <p class="mt-10 text-[1.1em] text-white text-center">
                <fmt:message key="about.header"/>
            </p>

            <p class="mt-5 pb-25 text-[1.4em] text-white text-center">
                <fmt:message key="about.subheader"/>
            </p>
        </div>

        <div class="flex justify-evenly items-center mt-15 mb-10">

            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">2M+</p>
                <p class="text-[1.3em] text-center"><fmt:message key="about.citizens"/></p>
            </div>

            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">500K+</p>
                <p class="text-[1.3em] text-center"><fmt:message key="about.requests"/></p>
            </div>

            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">98%</p>
                <p class="text-[1.3em] text-center"><fmt:message key="about.satisfaction"/></p>
            </div>

            <div>
                <p class="text-[1.3em] text-yellow-500 text-center">24/7</p>
                <p class="text-[1.3em] text-center"><fmt:message key="about.availability"/></p>
            </div>

        </div>

        <div class="pt-15 h-110 bg-white">
            <p class="mb-10 text-center text-[1.4em]">
                <fmt:message key="about.corePrinciples"/>
            </p>

            <div>
                <div class="flex w-350 mx-auto justify-between">

                    <!-- Mission -->
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">circle_circle</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold"><fmt:message key="about.missionTitle"/></p>
                            <p class="text-[1.2em]"><fmt:message key="about.missionText"/></p>
                        </div>
                    </div>

                    <!-- Vision -->
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">group</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold"><fmt:message key="about.visionTitle"/></p>
                            <p class="text-[1.2em]"><fmt:message key="about.visionText"/></p>
                        </div>
                    </div>

                </div>

                <div class="flex w-350 mt-7 mx-auto justify-between">

                    <!-- Values -->
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">license</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold"><fmt:message key="about.valuesTitle"/></p>
                            <p class="text-[1.2em]"><fmt:message key="about.valuesText"/></p>
                        </div>
                    </div>

                    <!-- Reach -->
                    <div class="flex">
                        <div class="h-12 w-12 flex items-center justify-center rounded-2xl bg-[#EAA900] mb-7 mt-3">
                            <span class="material-symbols-outlined text-white">language</span>
                        </div>
                        <div class="ml-3 w-150 mt-2">
                            <p class="text-[1.4em] font-bold"><fmt:message key="about.reachTitle"/></p>
                            <p class="text-[1.2em]"><fmt:message key="about.reachText"/></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="pt-15 h-100">
            <p class="mt-10 text-center"><fmt:message key="about.storyTitle"/></p>

            <p class="mt-10 w-300 text-[1.1em] mx-auto">
                <fmt:message key="about.storyParagraph"/>
            </p>
        </div>

        <div class="pt-15 mt-10 h-90 bg-gradient-to-r from-yellow-600 to-yellow-500">
            <p class="text-center text-white mb-10"><fmt:message key="about.contactUs"/></p>

            <div class="flex justify-around w-300 mx-auto">

                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-full bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">phone</span>
                    </div>
                    <p class="mt-3 text-center text-white"><fmt:message key="about.phoneLabel"/></p>
                    <p class="mt-1 text-center text-white">1-800-GOV-SERV</p>
                    <p class="mt-1 text-center text-white"><fmt:message key="about.workingHours"/></p>
                </div>

                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-full bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">email</span>
                    </div>
                    <p class="mt-3 text-center text-white"><fmt:message key="about.emailLabel"/></p>
                    <p class="mt-1 text-center text-white">support@govservices.gov</p>
                    <p class="mt-1 text-center text-white"><fmt:message key="about.responseTime"/></p>
                </div>

                <div class="w-70">
                    <div class="mx-auto h-12 w-12 flex items-center justify-center rounded-full bg-white border-2 border-yellow-300 mb-3 mt-3">
                        <span class="material-symbols-outlined text-yellow-600">location_on</span>
                    </div>
                    <p class="mt-3 text-center text-white"><fmt:message key="about.addressLabel"/></p>
                    <p class="mt-1 text-center text-white">123 Government Plaza</p>
                    <p class="mt-1 text-center text-white"><fmt:message key="about.city"/></p>
                </div>

            </div>
        </div>
        <script>
            function changeLang(lang) {
                let url = window.location.pathname;
                window.location.href = url + "?lang=" + lang;
            }
        </script>

    </body>
</html>

