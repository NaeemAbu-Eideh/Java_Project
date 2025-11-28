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
    <body class=" bg-gradient-to-br from-yellow-50 to-white items-center justify-center">
        <div class="flex justify-between items-center bg-gradient-to-r from-yellow-600 via-yellow-500 to-yellow-600">
            <div class="flex items-center ml-30 py-3">
                <div class="w-16 h-16 bg-white rounded-2xl flex items-center">
                    <img class="w-7 block mx-auto" alt="logo" src="/img/government.png"/>
                </div>
                <p class="ml-4 text-[1.2em]">PalGuide</p>
            </div>
            <div class="mr-30 flex items-center">
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href= <c:out value="/dashboard"/>>
                    <span class="material-symbols-outlined text-white">home</span>
                    <p class="ml-1 text-[1.1em] text-white">Home</p>
                </a>

                <c:if test="${user.role == 'USER'}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/request">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">Request Service</p>
                    </a>
                </c:if>

                <c:if test="${user.role != 'USER'}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/dash">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">Request Dashboard</p>
                    </a>
                </c:if>

                <c:if test="${ user_id != null}">
                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="my-request">
                        <span class="material-symbols-outlined text-white">docs</span>
                        <p class="ml-1 text-[1.1em] text-white">My Requests</p>
                    </a>

                    <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/analysis">
                        <span class="material-symbols-outlined text-white">upload</span>
                        <p class="ml-1 text-[1.1em] text-white">Document Analysis</p>
                    </a>
                </c:if>
                <a class="px-2 h-16 rounded-2xl flex items-center mr-4 hover:bg-[#A65F00] transition-all" href="/about-us">
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
                <div class="w-80  rounded-2xl shadow-md bg-white pt-10 mb-5">
                    <div class="h-20 w-20 flex items-center justify-center rounded-[50%] bg-gradient-to-r from-yellow-600 to-yellow-500 mx-auto mb-10">
                        <c:if test="${user.profileImage == null}">
                            <span class="material-symbols-outlined profile-image text-white">person</span>
                        </c:if>
                        <c:if test="${user.profileImage != null}">
                            <img class="w-20 h-20 rounded-[50%]" src= <c:out value="/user/${user.id}/image"/>>
                        </c:if>
                    </div>
                    <form action="/${user.firstname}/profile/upload-image"
                          method="post"
                          enctype="multipart/form-data"
                          class="mb-5 flex flex-col items-center mt-2">

                        <input id="profileImage"
                               type="file"
                               name="profileImage"
                               accept="image/*"
                               class="hidden"
                               onchange="this.form.submit()" />

                        <label for="profileImage"
                               class="cursor-pointer px-5 py-2 rounded-lg bg-gradient-to-r from-yellow-600 to-yellow-500
                  text-white text-sm font-medium hover:from-yellow-700 hover:to-yellow-600
                  transition-all flex items-center">
                            <span class="material-symbols-outlined mr-2 text-white">upload</span>
                            <span>Upload new photo</span>
                        </label>
                    </form>
                    <p class="text-center mb-5"><c:out value="${user.firstname} ${user.lastname}"/></p>
                    <p class="text-center pb-8"><c:out value="${user.email}"/></p>
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
            <div>
                <div id="static" class="pb-6 w-150 bg-white shadow-md pt-8 rounded-2xl mb-3">
                    <div class="flex items-center justify-between mx-auto w-130">
                        <p class="mb-6 text-[1.2em]">Personal Information:</p>
                        <button onclick="showForm(this)" type="button" class="flex items-center text-yellow-500 hover:text-yellow-600">
                            <span class="material-symbols-outlined">edit</span>
                            <span class="ml-3">Edit</span>
                        </button>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span> First Name</p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.firstname}"/> </p>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>Last Name</p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.lastname}"/> </p>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span> Phone Number</p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.phone}"/> </p>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"><span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span> National ID Number</p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.nationalId}"/> </p>
                        <p class="mt-2 "> National ID Number Cannot Change </p>
                    </div>

                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"><span class="material-symbols-outlined text-[#DCA53F] mr-2">date_range</span>Address</p>
                        <select class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center">
                            <c:forEach var="address" items="${user.addresses}">
                                <option class="rounded-2xl"> <c:out value="${address.state}-${address.city}-${address.street}"/> </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <form:form id="form" cssClass="mb-6 bg-white hidden pb-6 w-150 mx-auto bg -white shadow-md pt-8 rounded-2xl" action="/${user.firstname}/profile/edit" method="post" modelAttribute="user">
                    <div class="flex items-center justify-between mx-auto w-130">
                        <p class="mb-6 text-[1.2em]">Personal Information:</p>
                        <div class="flex justify-between items-center">
                            <button onclick="showDetails(this)" type="button" class="border-2 border-yellow-600 pr-3 flex items-center mr-6 block py-3 rounded-lg hover:bg-yellow-200 transition-all">
                                <span class="material-symbols-outlined text-yellow-600">arrow_back</span>
                                <span class="ml-3 text-yellow-600">Back</span>
                            </button>
                            <button class=" pr-3 flex items-center block  bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all">
                                <span class="material-symbols-outlined text-white">save</span>
                                <span class="ml-3 text-white">Save Changes</span>
                            </button>
                        </div>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="firstname"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="firstname"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span> First Name *</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="firstname"/>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="lastname"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="lastname"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">person</span>Last Name *</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="lastname"/>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="phone"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="phone"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">call</span> Phone Number *</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="phone"/>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="text-[1.1em] block mb-2 flex items-center"><span class="material-symbols-outlined text-[#DCA53F] mr-2">id_card</span> National ID Number</p>
                        <p class="border border-gray-300 w-130 h-10 px-3 rounded-xl flex items-center"> <c:out value="${user.nationalId}"/> </p>
                        <p class="mt-2 "> National ID Number Cannot Change </p>
                    </div>
                    <button id="newAddress" onclick="showAddress(this)" type="button" class="w-50 ml-12 block  bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all">
                        Add new Address
                    </button>
                </form:form>

                <form:form id="address" cssClass="hidden bg-white pb-6 w-150 mx-auto bg -white shadow-md pt-8 rounded-2xl" action="/${user.firstname}/profile/add-address" method="post" modelAttribute="address">
                    <p class="ml-8 mb-6 text-[1.2em]">Add address:</p>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="state"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="state"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">flag</span> State</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="state"/>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="city"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="city"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">location_city</span>City</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="city"/>
                    </div>
                    <div class="ml-12 mb-6">
                        <p class="mt-2 text-sm text-red-600"><form:errors path="street"/></p>
                        <form:label cssClass="text-[1.1em] block mb-2 flex items-center" path="street"> <span class="material-symbols-outlined text-[#DCA53F] mr-2">add_road</span> Street</form:label>
                        <form:input cssClass="border border-gray-300 w-130 h-10 px-3 rounded-xl" path="street"/>
                    </div>
                    <button onclick="hideAddress()" class="w-50 ml-12 block  bg-gradient-to-r from-yellow-600 to-yellow-500 text-white py-3 rounded-lg hover:from-yellow-700 hover:to-yellow-600 transition-all">Add Address</button>
                </form:form>

            </div>
        </div>
        <script src="/js/edit_profile.js"></script>
    </body>
</html>