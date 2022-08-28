<#include "${templatesPath}/NAVIGATION-MACRO-FTL" />

<style>
    #navbar_${portletDisplay.getId()} .list-group-item {
        border: none;
    }
    #navbar_${portletDisplay.getId()} .sidebar-menu {
        width: 400px;
        max-width: 400px;
    }
    #navbar_${portletDisplay.getId()} .panel-header,
    #navbar_${portletDisplay.getId()} .panel-header a{
        padding: 12px 0 12px 12px;
        font-family: 'SF Pro Medium';
        font-style: normal;
        font-size: 17px;
        line-height: 20px;
        letter-spacing: -0.02em;
        color: #272833
    }
    #navbar_${portletDisplay.getId()} .list-group-item{
        padding:0;
    }
    #navbar_${portletDisplay.getId()} .sidebar-content .panel-header{
        padding: 12px 0 12px 28px;
    }
    #navbar_${portletDisplay.getId()} .sidebar-content .panel-header .panel-header{
        padding:0;
    }

    #navbar_${portletDisplay.getId()} .sidebar-content .panel-header,
    #navbar_${portletDisplay.getId()} .sidebar-content .panel-header a{
        font-family: 'SF Pro Regular';
        font-size: 16px;
        line-height: 22px;
        letter-spacing: -0.01em;
        color: #272833;
    }

    #navbar_${portletDisplay.getId()} .panel-header.active-page,
    #navbar_${portletDisplay.getId()} .panel-header.active-page a{
        background: transparent;
        color: #012049;
        font-family: 'SF Pro Bold';
        font-size: 16px;
        line-height: 21px;

    }
    #navbar_${portletDisplay.getId()} .active-page a:hover,
    #navbar_${portletDisplay.getId()} .panel-header a:hover,
    #navbar_${portletDisplay.getId()} .sidebar-content .panel-header a:hover{
        text-decoration: none;
    }
    #navbar_${portletDisplay.getId()} .active-page::before {
        content: '';
        height: 100%;
        width: 4px;
        background: #002F6C;
        position: absolute;
        left: 0;
        top: 0;
    }

    #navbar_${portletDisplay.getId()} .back-link {
        margin: 10px 20px;
        display: block;
        font-weight: bold;
        color: #777;
        letter-spacing: 1px;
        text-decoration: none;
    }
</style>

<#if !entries?has_content>
    <#if themeDisplay.isSignedIn()>
        <div class="alert alert-info">
            <@liferay.language key="there-are-no-menu-items-to-display" />
        </div>
    </#if>
<#else>

    <#assign isLayoutFound = false />
    <#assign layoutNavItem = "" />
    <#assign backLink = "" />

    <#assign friendlyUrl = themeDisplay.getLayoutFriendlyURL(themeDisplay.getLayout()) />

    <#assign navItems = entries />
    <#list navItems as nav_item>
        <#if nav_item.getURL()?ends_with(friendlyUrl)>
            <#assign isLayoutFound = true />
            <#assign layoutNavItem = nav_item />
        </#if>
        <#if !isLayoutFound>
            <#assign isLayoutFound = true />
            <#assign layoutNavItem = nav_item />
        </#if>
        <#if nav_item.hasBrowsableChildren()>
            <#list nav_item.getChildren() as nav_child>
                <#if nav_child.getURL()?ends_with(friendlyUrl)>
                    <#assign isLayoutFound = true />
                    <#assign layoutNavItem = nav_child />
                    <#assign backLink = nav_item.getURL() />
                </#if>
                <#if nav_child.hasBrowsableChildren()>
                    <#list nav_child.getChildren() as nav_sub_child>
                        <#if nav_sub_child.getURL()?ends_with(friendlyUrl)>
                            <#assign isLayoutFound = true />
                            <#assign layoutNavItem = nav_child />
                            <#assign backLink = nav_item.getURL() />
                        </#if>
                    </#list>
                </#if>
            </#list>
        </#if>
    </#list>

    <#assign
    portletDisplay = themeDisplay.getPortletDisplay()
    navbarId = "navbar_" + portletDisplay.getId()
    />
    <div id="${navbarId}" class="navbar-blank navbar-nav navbar-site"  role="menubar">

        <div class="sidebar-menu">
            <#if backLink?has_content>
                <a href="${backLink}" class="back-link"> < Go Back </a>
            </#if>
            <div class="">
                <#assign nav_css_class = "panel-header sidebar-header" />
                <#if layoutNavItem.getURL()?ends_with(friendlyUrl)>
                    <#assign nav_css_class = "${nav_css_class} active-page" />
                </#if>
                <div class="${nav_css_class}">
                        <span>
                            <a href="${layoutNavItem.getURL()}" ${layoutNavItem.getTarget()} role="menuitem">${layoutNavItem.getName()}</a>
                        </span>
                </div>
                <#if layoutNavItem.hasBrowsableChildren()>
                    <div class="sidebar-content" id="sidebar_layout_${layoutNavItem.getLayoutId()}">
                        <div class="list-group-item">
                            <ul aria-labelledby="sidebar_layout_${layoutNavItem.getLayoutId()}" class="nav nav-equal-height nav-stacked" role="menu">
                                <#list layoutNavItem.getChildren() as nav_child>
                                    <#assign nav_child_css_class = "panel-header sidebar-header" />
                                    <#if nav_child.getURL()?ends_with(friendlyUrl)>
                                        <#assign nav_child_css_class = "${nav_child_css_class} active-page" />
                                    </#if>
                                    <li class="${nav_child_css_class}" role="presentation">
                                        <div class="panel-header sidebar-header">
                                                <span>
                                                    <a href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menuitem" data-title="${nav_child.getName()}">
                                                        ${nav_child.getName()}
                                                    </a>
                                                </span>
                                        </div>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </#if>
            </div>
        </div>
    </div>
</#if>