<#--
    Event template: Format the Event structure
    
    Created:    2015-10-01 19:09 by Christian Berndt
    Modified:   2015-10-01 23:23 by Christian Berndt
    Version:    0.9.1
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign date_Data = getterUtil.getLong(date.getData())>

<div class="event">
    <div class="container">
        <div class="content span8 offset2">
			<#if (date_Data > 0)>
				<#assign date_DateObj = dateUtil.newDate(date_Data)>
				<div class="date">${dateUtil.getDate(date_DateObj, "dd MMM yyyy - HH:mm", locale)}</div>
			</#if>
            <div class="location">${location.getData()}</div>
            <h1>${title.getData()}</h1>
            <div class="lead">${summary.getData()}</div>
            <#if section.getSiblings()?has_content>
                <#list section.getSiblings() as cur_section>
                    <div class="section">
                        <h2>${cur_section.getData()}</h2>
                        <#if cur_section.body??>
	                        <div class="section-body">${cur_section.body.getData()}</div>
                        </#if>
                    </div>
                </#list>
            </#if> 
        </div>
    </div>
</div>