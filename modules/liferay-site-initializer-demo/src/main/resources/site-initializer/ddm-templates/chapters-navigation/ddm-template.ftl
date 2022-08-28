<#include "${templatesPath}/NAVIGATION-MACRO-FTL" />

<style>
    #navbar_${portletDisplay.getId()} .sections-wrapper {
        display: flex;
        flex-wrap: wrap;
    }

    #navbar_${portletDisplay.getId()} .section-card {
        border: 1px solid rgba(9,16,24,.12);
        border-radius: .25rem;
        box-shadow: 0 6px 15px -6px rgb(9 16 29);
        cursor: pointer;
        margin-left: 1rem;
        margin-right: .5rem;
        margin-top: 1.5rem;
        padding: 1.25rem 1.5rem;
        transition: transform .2s ease;
        width: 45%;
    }

    #navbar_${portletDisplay.getId()} .section-card:hover {
        border-bottom: 3px solid #0b5fff;
        box-shadow: 0 6px 11px 0 rgb(9 16 29);
        margin-bottom: -3px;
        text-decoration: none;
        transform: translateY(-4px);
    }

    #navbar_${portletDisplay.getId()} .section-card a h4 {
        text-decoration: none;
    }
    #navbar_${portletDisplay.getId()} .section-card a h4 {
        color: #09101d;
        border-left: 3px solid #42bfc2;
        margin-left: -1.5rem;
        padding-left: 1.25rem;
        font-size: 1.125rem;
        margin-bottom: .5rem;
    }

    #navbar_${portletDisplay.getId()} ul.subsection {
        margin-top: 10px;
        padding: 0;
    }
    #navbar_${portletDisplay.getId()} ul.subsection li {
        list-style-type: none;
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
                </#if>
                <#if nav_child.hasBrowsableChildren()>
                    <#list nav_child.getChildren() as nav_sub_child>
                        <#if nav_sub_child.getURL()?ends_with(friendlyUrl)>
                            <#assign isLayoutFound = true />
                            <#assign layoutNavItem = nav_sub_child />
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

    <div id="${navbarId}">
        <#if layoutNavItem.hasBrowsableChildren()>
            <div class="sections-wrapper">
                <#list layoutNavItem.getChildren() as nav_child>
                    <div class="section-card">
                        <div class="autofit-row autofit-row-center">
                            <div class="autofit-col autofit-col-expand">
                                <a href="${nav_child.getURL()}">
                                    <h4 class="sidebar title">${nav_child.getName()}</h4>
                                </a>
                                <#if nav_child.hasBrowsableChildren()>
                                    <ul class="subsection">
                                        <#list nav_child.getChildren() as nav_sub_child>
                                            <li>
                                                <a href="${nav_sub_child.getURL()}">
                                                    ${nav_sub_child.getName()}
                                                </a>
                                            </li>
                                        </#list>
                                    </ul>
                                </#if>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
</#if>