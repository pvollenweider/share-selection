<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="font-awesome.min.css,shareSelectedText.css"/>
<template:addResources type="javascript" resources="jquery.min.js,shareSelectedText.js"/>
<template:addResources type="inline">

<c:set var="bindedComponent" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
    <c:choose>
        <c:when test="${bindedComponent.path eq renderContext.mainResource.node.path}">
            <c:set var="sectionSelector" value="body"/>
        </c:when>
        <c:otherwise>
            <c:set var="sectionSelector" value="div#section_${currentNode.identifier}"/>
        </c:otherwise>

    </c:choose>


    <script>
        window.onload = function() {

            // plugin initialization with default options
            shareSelectedText('${sectionSelector}', {
                tooltipClass: '${currentNode.properties.tooltipClass.string}',    // cool, if you want to customize the tooltip
                sanitize: true,      // will sanitize the user selection to respect the Twitter Max length (recommended)
                buttons: [           // services that you want to enable you can add :
                    <c:forEach var="service" items="${currentNode.properties.services}" varStatus="status">
                        '${service}'<c:if test="${! status.last}">,</c:if>
                    </c:forEach>
                ],
                anchorsClass: '',    // class given to each tooltip's links
                twitterUsername: '${currentNode.properties.twitterUsername.string}', // for twitter widget, will add 'via @twitterUsername' at the end of the tweet.
                facebookAppID: '${currentNode.properties.facebookAppID.string}', // Can also be an HTML element inside the <head> tag of your page : <meta property="fb:APP_ID" content="YOUR_APP_ID"/>
                facebookDisplayMode: '${currentNode.properties.facebookDisplayMode.string}', //can be 'popup' || 'page'
                tooltipTimeout: 250  //Timeout before that the tooltip appear in ms
            });
        }
    </script>
</template:addResources>