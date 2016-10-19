<#--
    newsletter.ftl: Format the newsletter structure
    
    Created:    2016-10-18 22:59 by Christian Berndt
    Modified:   2016-10-19 09:59 by Christian Berndt
    Version:    1.0.1
-->

<style>
    .newsletter {
        background-color: #ebebeb;
    }
    
    .newsletter .introduction {
        padding: 0 40px 40px;
    }
    
    .newsletter p {
        margin-bottom: 0;
    }
    
    .newsletter .section {
        background-color: #ffffff;
        margin-bottom: 45px;
    }
    
    .newsletter .section .content {
        padding: 40px;
    }
    
</style>

<div class="newsletter">
    <div class="container">
        <div class="span8 offset2">
            <#if introduction??>
                <#if introduction.getData()?has_content>
                    <div class="introduction section">
                            ${introduction.getData()}
                    </div>
                </#if>
            </#if>
            <#if section?? >
                <#if section.getSiblings()?has_content>    
                    <#list section.getSiblings() as cur_section>
                        <div class="section">
                            <#if cur_section.image??>
                                <#if cur_section.image.getData()?has_content>
                                    <img src="${cur_section.image.getData()}">
                                </#if>
                            </#if> 
                            <div class="content">                            
                                <#if cur_section.date??>
                                    <#if cur_section.date.getData()?has_content>
                                        <div class="date">
                                            ${cur_section.date.getData()}
                                        </div>
                                    </#if>
                                </#if>                                                   
                                <#if cur_section.getData()?has_content>
                                    <h2>${cur_section.getData()}</h2>
                                </#if>
                                <#if cur_section.text??>
                                    <#if cur_section.text.getData()?has_content>
                                        ${cur_section.text.getData()}
                                    </#if>
                                </#if>
                            </div>
                        </div>            
                    </#list>
                </#if>
            </#if>
        </div>  
    </div>  
</div>