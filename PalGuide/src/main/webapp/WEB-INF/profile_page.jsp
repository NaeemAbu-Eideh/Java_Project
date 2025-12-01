<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

    <body class="bg-gradient-to-br from-yellow-50 to-white items-center justify-center">

        <!-- NAVBAR -->
        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">

            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">
                    <fmt:message key="navbar.appName"/>
                </p>
            </div>

            <div class="mr-30 flex items-center">

                <!-- Home -->
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dashboard">
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.home"/></p>
                </a>

                <!-- Request Service -->
                <c:if test="${user.role == 'USER'}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/request">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestService"/></p>
                    </a>
                </c:if>

                <!-- Dashboard (Gov / Admin) -->
                <c:if test="${user.role != 'USER'}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/dash">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.requestsDashboard"/></p>
                    </a>
                </c:if>

                <!-- My Requests -->
                <c:if test="${user_id != null}">
                    <c:if test="${user.role == 'USER'}"><a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/my-requests">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.myRequests"/></p>
                    </a> </c:if>

                    <!-- Document Analysis -->
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.documentAnalysis"/></p>
                    </a>
                </c:if>

                <!-- About Us -->
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/about-us">
                    <span class="material-symbols-outlined text-white">info</span>
                    <p class="ml-1 text-[1.1em] text-white"><fmt:message key="navbar.aboutUs"/></p>
                </a>

                <!-- Profile -->
                <a class="px-2 h-16 bg-white rounded-2xl flex items-center mr-4">
                    <span class="material-symbols-outlined text-[#DCA53F]">person</span>
                    <p class="ml-1 text-[1.1em] text-[#DCA53F]">
                        <fmt:message key="navbar.profile"/>
                    </p>
                </a>

                <!-- Logout -->
                <c:if test="${user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]"
                       href="<c:out value='/${user.firstname}/profile/logout'/>">
                        <span class="material-symbols-outlined text-white">logout</span>
                        <p class="ml-1 text-[1.1em] text-white">
                            <fmt:message key="navbar.logout"/>
                        </p>
                    </a>
                </c:if>

                <!-- Login -->
                <c:if test="${user_id == null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00]" href="/login">
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

        <!-- PROFILE HEADER -->
        <div class="w-360 mx-auto mt-20 mb-7">
            <p class="font-bold text-[1.4em] mb-3">
                <fmt:message key="profile.title"/>
            </p>
            <p class="text-[1.2em]">
                <fmt:message key="profile.subtitle"/>
            </p>
        </div>

        <div class="flex w-360 mx-auto">

            <!-- LEFT PANEL -->
            <div class="mr-30">

                <!-- Image & Basic Info -->
                <div class="w-80 rounded-2xl shadow-md bg-white pt-10 mb-5">

                    <div class="h-20 w-20 flex items-center justify-center rounded-full bg-gradient-to-r from-yellow-600 to-yellow-500 mx-auto mb-10">
                        <c:if test="${user.profileImage == null}">
                            <span class="material-symbols-outlined profile-image text-white">person</span>
                        </c:if>
                        <c:if test="${user.profileImage != null}">
                            <img class="w-20 h-20 rounded-full" src="<c:out value='/user/${user.id}/image'/>"/>
                        </c:if>
                    </div>

                    <!-- Upload -->
                    <form action="/${user.firstname}/profile/upload-image"
                          method="post"
                          enctype="multipart/form-data"
                          class="mb-5 flex flex-col items-center mt-2">

                        <input id="profileImage" type="file" name="profileImage" accept="image/*"
                               class="hidden" onchange="this.form.submit()"/>

                        <label for="profileImage"
                               class="cursor-pointer px-5 py-2 rounded-lg bg-gradient-to-r from-yellow-600 to-yellow-500
                       text-white text-sm font-medium hover:from-yellow-700 hover:to-yellow-600
                       transition-all flex items-center">
                            <span class="material-symbols-outlined mr-2">upload</span>
                            <span><fmt:message key="profile.uploadPhoto"/></span>
                        </label>
                    </form>

                    <!-- Name + Email -->
                    <p class="text-center mb-5"><c:out value="${user.firstname} ${user.lastname}"/></p>
                    <p class="text-center pb-8"><c:out value="${user.email}"/></p>

                </div>

                <!-- ACCOUNT TYPE -->
                <div class="w-80 rounded-2xl shadow-md bg-white pt-10 mb-5 pb-5">

                    <p class="ml-5 text-[1.2em] mb-6">
                        <fmt:message key="profile.accountType"/>
                    </p>

                    <p class="mx-auto flex items-center justify-center border bg-gray-200 rounded-2xl h-14 w-30 text-[1.3em]">

                        <c:if test="${user.role == 'USER'}">
                            <fmt:message key="profile.role.citizen"/>
                        </c:if>

                        <c:if test="${user.role == 'Gov'}">
                            <fmt:message key="profile.role.government"/>
                        </c:if>

                        <c:if test="${user.role == 'Admin'}">
                            <fmt:message key="profile.role.admin"/>
                        </c:if>

                    </p>
                </div>

            </div>

            <!-- RIGHT SIDE -->
            <div>

                <!-- STATIC DETAILS -->
                <div id="static" class="pb-6 w-150 bg-white shadow-md pt-8 rounded-2xl mb-3">

                    <div class="flex items-center justify-between mx-auto w-130">
                        <p class="mb-6 text-[1.2em]">
                            <fmt:message key="profile.personalInfo"/>
                        </p>

                        <button onclick="showForm(this)" type="button"
                                class="flex items-center text-yellow-500 hover:text-yellow-600">
                            <span class="material-symbols-outlined">edit</span>
                            <span class="ml-3"><fmt:message key="profile.edit"/></span>
                        </button>
                    </div>

                    <!-- First Name -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>
                            <fmt:message key="profile.firstName"/>
                        </p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:out value="${user.firstname}"/>
                        </p>
                    </div>

                    <!-- Last Name -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>
                            <fmt:message key="profile.lastName"/>
                        </p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:out value="${user.lastname}"/>
                        </p>
                    </div>

                    <!-- Phone -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span>
                            <fmt:message key="profile.phone"/>
                        </p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:out value="${user.phone}"/>
                        </p>
                    </div>

                    <!-- National ID -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span>
                            <fmt:message key="profile.nationalId"/>
                        </p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:out value="${user.nationalId}"/>
                        </p>
                        <p class="mt-2 text-sm">
                            <fmt:message key="profile.nationalId.note"/>
                        </p>
                    </div>

                    <!-- Address -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">date_range</span>
                            <fmt:message key="profile.address"/>
                        </p>

                        <select class="border border-gray-300 w-130 h-10 px-3 rounded-xl">
                            <c:forEach var="address" items="${user.addresses}">
                                <option>
                                    <c:out value="${address.state}-${address.city}-${address.street}"/>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                </div>

                <!-- EDIT FORM -->
                <form:form id="form" cssClass="hidden mb-6 bg-white pb-6 w-150 mx-auto shadow-md pt-8 rounded-2xl"
                           action="/${user.firstname}/profile/edit" method="post" modelAttribute="user">

                    <div class="flex items-center justify-between mx-auto w-130">
                        <p class="mb-6 text-[1.2em]">
                            <fmt:message key="profile.personalInfo"/>
                        </p>

                        <div class="flex items-center">

                            <button onclick="showDetails(this)" type="button"
                                    class="border-2 border-yellow-600 pr-3 flex items-center mr-6 py-3 rounded-lg hover:bg-yellow-200">
                                <span class="material-symbols-outlined text-yellow-600">arrow_back</span>
                                <span class="ml-3 text-yellow-600">
                                    <fmt:message key="profile.back"/>
                                </span>
                            </button>

                            <button class="pr-3 flex items-center bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600">
                                <span class="material-symbols-outlined text-white">save</span>
                                <span class="ml-3">
                                    <fmt:message key="profile.saveChanges"/>
                                </span>
                            </button>

                        </div>
                    </div>

                    <!-- First Name -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="firstname"/></p>
                        <form:label path="firstname" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>
                            <fmt:message key="profile.firstName"/> *
                        </form:label>
                        <form:input path="firstname" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <!-- Last Name -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="lastname"/></p>
                        <form:label path="lastname" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>
                            <fmt:message key="profile.lastName"/> *
                        </form:label>
                        <form:input path="lastname" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <!-- Phone -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="phone"/></p>
                        <form:label path="phone" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span>
                            <fmt:message key="profile.phone"/> *
                        </form:label>
                        <form:input path="phone" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <!-- National ID -->
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span>
                            <fmt:message key="profile.nationalId"/>
                        </p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:out value="${user.nationalId}"/>
                        </p>
                        <p class="mt-2"><fmt:message key="profile.nationalId.note"/></p>
                    </div>

                    <!-- Add Address button -->
                    <button id="newAddress" onclick="showAddress(this)" type="button"
                            class="w-50 ml-12 bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600">
                        <fmt:message key="profile.addAddress"/>
                    </button>

                </form:form>

                <!-- ADD ADDRESS FORM -->
                <form:form id="address" cssClass="hidden bg-white pb-6 w-150 mx-auto shadow-md pt-8 rounded-2xl"
                           action="/${user.firstname}/profile/add-address" method="post" modelAttribute="address">

                    <p class="ml-8 mb-6 text-[1.2em]">
                        <fmt:message key="profile.addAddressTitle"/>
                    </p>

                    <!-- State -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="state"/></p>
                        <form:label path="state" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">flag</span>
                            <fmt:message key="profile.state"/>
                        </form:label>
                        <form:input path="state" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <!-- City -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="city"/></p>
                        <form:label path="city" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">location_city</span>
                            <fmt:message key="profile.city"/>
                        </form:label>
                        <form:input path="city" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <!-- Street -->
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="street"/></p>
                        <form:label path="street" cssClass="text-[1.1em] mb-2 flex items-center">
                            <span class="material-symbols-outlined text-[#DCA53F] mr-2">add_road</span>
                            <fmt:message key="profile.street"/>
                        </form:label>
                        <form:input path="street" cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl"/>
                    </div>

                    <button onclick="hideAddress()"
                            class="w-50 ml-12 bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600">
                        <fmt:message key="profile.addAddressButton"/>
                    </button>

                </form:form>

            </div>
        </div>

        <script src="/js/edit_profile.js"></script>
        <script>
            function changeLang(lang) {
                window.location.href = window.location.pathname + "?lang=" + lang;
            }
        </script>

    </body>
</html>
