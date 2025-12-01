<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<fmt:setLocale value="${param.lang != null ? param.lang : sessionScope['jakarta.servlet.jsp.jstl.fmt.locale.session']}"
               scope="session"/>
<fmt:setBundle basename="messages"/>

<html>
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"/>
        <link rel="stylesheet" href="/css/css.css">
    </head>

    <body class="min-h-screen bg-gradient-to-br from-yellow-50 to-white items-center justify-center">

        <!-- NAV BAR -->
        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>

            <div class="mr-30 flex items-center">

                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                   href="/dashboard">
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.home"/></p>
                </a>

                <c:if test="${ user_id != null}">
                    <c:if test="${user.role == 'USER'}">
                        <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/request">
                            <span class="material-symbols-outlined text-white">docs</span>
                            <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestService"/></p>
                        </a>
                    </c:if>

                    <c:if test="${user.role != 'USER'}">
                        <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dash">
                            <span class="material-symbols-outlined text-white">docs</span>
                            <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestsDashboard"/></p>
                        </a>
                    </c:if>

                    <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4" href="">
                        <span class="material-symbols-outlined text-[#DCA53F]">docs</span>
                        <p class="ml-1 text-[1.1em] text-[#DCA53F]"><fmt:message key="navbar.myRequests"/></p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.documentAnalysis"/></p>
                    </a>
                </c:if>

                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/about-us">
                    <span class="material-symbols-outlined text-white">info</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.aboutUs"/></p>
                </a>

                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                       href="/${user.firstname}/profile">
                        <span class="material-symbols-outlined text-white">person</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.profile"/></p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                       href="/dashboard/logout">
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.logout"/></p>
                    </a>
                </c:if>

                <c:if test="${user_id == null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                       href="/login">
                        <span class="material-symbols-outlined text-white">login</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.loginRegister"/></p>
                    </a>
                </c:if>

                <!-- LANGUAGE SWITCH -->
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

        <!-- HEADER -->
        <div class="mt-10 w-400 mx-auto">
            <h2 class="font-bold text-3xl"><fmt:message key="myRequests.title"/></h2>
            <p class="mt-4"><fmt:message key="myRequests.subtitle"/></p>
        </div>

        <!-- REQUEST STATUS BOX -->
        <div class="pt-10 mb-5 mt-10 w-400 h-80 mx-auto bg-white shadow-md">
            <div class="mt-5 mb-4 h-15 w-15 bg-gray-300 rounded-[50%] mx-auto flex items-center justify-center">
                <span class="clock-icon material-symbols-outlined text-white">pace</span>
            </div>

            <c:if test="${user.transactions == null}">
                <p class="text-center mb-3"><fmt:message key="myRequests.empty.title"/></p>
                <p class="text-center text-gray-700 mb-5"><fmt:message key="myRequests.empty.subtitle"/></p>
            </c:if>

            <c:if test="${user.transactions != null}">
                <p class="text-center mb-5"><fmt:message key="myRequests.addNew"/></p>
            </c:if>

            <a class="text-center w-50 block mx-auto bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all"
               href="/request">
                <fmt:message key="myRequests.makeRequest"/>
            </a>
        </div>

        <!-- REQUEST LIST -->
        <c:if test="${user.transactions != null}">
            <div class="w-400 mx-auto mt-10">
                <p class="text-2xl mb-5 font-bold"><fmt:message key="myRequests.listTitle"/></p>

                <c:forEach items="${user.transactions}" var="request">
                    <div class="shadow-md bg-gray-100 w-100 pt-2 rounded-2xl mb-5 mr-5">
                        <div class="flex justify-between w-90 mx-auto">
                            <p class="text-gray-700 text-[0.8em]">
                                <c:out value="${request.createdAt}"/>
                            </p>

                            <div class="flex rounded-2xl bg-blue-200 items-center">
                                <div class="bg-blue-700 w-2 h-2 rounded-[50%] ml-2"></div>
                                <p class="text-blue-700 text-[0.8em] mr-2 ml-2">
                                    <c:out value="${request.status}"/>
                                </p>
                            </div>
                        </div>

                        <p class="font-bold text-[1.3em] w-90 mx-auto">
                            <c:out value="${request.user.firstname}"/>
                            <c:out value="${request.user.lastname}"/>
                        </p>

                        <p class="text-gray-700 text-[0.8em] w-90 mx-auto mt-2"><fmt:message key="myRequests.request.title"/></p>
                        <p class="text-gray-700 text-[0.8em] w-90 mx-auto mt-2"><c:out value="${request.title}"/></p>

                        <p class="text-gray-700 text-[0.8em] w-90 mx-auto mt-3"><fmt:message key="myRequests.request.description"/></p>
                        <p class="text-gray-700 text-[0.8em] w-90 mx-auto mt-2"><c:out value="${request.description}"/></p>

                        <div class="flex justify-between w-90 mx-auto mt-3">
                            <div>
                                <p class="text-gray-700 text-[0.8em]"><fmt:message key="myRequests.request.amount"/></p>
                                <p class="text-green-500 text-[0.8em]"><c:out value="${request.amount}"/> USD</p>
                            </div>

                            <div>
                                <p class="text-gray-700 text-[0.8em]"><fmt:message key="myRequests.request.payment"/></p>
                                <p class="text-gray-700 text-[0.8em]"><c:out value="${request.paymentStatus}"/></p>
                            </div>
                        </div>

                        <hr class="mt-3">

                        <div class="flex justify-between w-90 mx-auto">
                            <p class="text-gray-700 text-[0.8em] mt-2">
                                <fmt:message key="myRequests.request.id"/> <c:out value="${request.id}"/>
                            </p>

                            <a class="text-blue-600 text-[0.8em] mt-2 flex items-center">
                                <fmt:message key="myRequests.request.viewDetails"/>
                                <span class="material-symbols-outlined text-blue-600">arrow_forward</span>
                            </a>
                        </div>

                    </div>
                </c:forEach>

            </div>
        </c:if>

        <script>
            function changeLang(lang) {
                let url = window.location.pathname;
                window.location.href = url + "?lang=" + lang;
            }
        </script>

    </body>
</html>
