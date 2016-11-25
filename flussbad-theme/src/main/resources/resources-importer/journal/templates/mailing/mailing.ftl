<#--
    mailing.ftl: Format the mailing structure
    
    Created:    2016-10-18 22:59 by Christian Berndt
    Modified:   2016-11-25 15:53 by Christian Berndt
    Version:    1.0.6
-->

<style>
    .newsletter {
        background-color: #ebebeb;
        font-size: 18px;
        font-family: 'Apercu Pro Regular', Calibri, Roboto, sans-serif;       
        line-height: 30px;   
    }
    
    .newsletter a {
        color: #648889;
        text-decoration: underline;
    }
    
    .newsletter a:active,
    .newsletter a:focus,
    .newsletter a:hover {
        color: #526f70;
    }
    
    .newsletter .date {
        font-size: 16px;
        text-transform: uppercase;
    }
    
    .newsletter h2 {
        font-family: 'Apercu Pro Bold', Calibri, Roboto, sans-serif;
        font-size: 31.5px;     
        line-height: 40px;   
        margin-top: 0;
    }
    
    .newsletter .introduction {
        padding: 0 40px 40px;
    }
    
    .newsletter p {
        margin-bottom: 0;
    }
    
    .newsletter .section {
        background-color: #ffffff;
        margin-bottom: 50px;
    }
    
    .newsletter .section .content {
        padding: 40px;
    }
    
    .newsletter .section img {
        width: 100%;
        height: auto;
    }
    
    .newsletter-footer {
        background: #fff;
        font-size: 16px;
        padding: 40px;
        text-align: center; 
    }
    
    .newsletter-footer .container div {
        padding: 20px 0;
    }
    
    .newsletter-footer hr,
    .portlet-newsletter .newsletter-footer hr {
        border: 7.5px solid #ebebeb;
        margin: 0; 
    }
    
    
</style>

<div class="newsletter">
    <div class="container newsletter-container">
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
                                    <img src="${cur_section.image.getData()}&imageThumbnail=3" />
                                </#if>
                            </#if> 
                            <div class="content">                            
                                <#if cur_section.date??>
                                    <#if cur_section.date.getData()?has_content>
                                        <#assign date = getterUtil.getLong(cur_section.date.getData()) />
                                        <#if (date gt 0)>
                                            <#assign dateObj = dateUtil.newDate(date) />
                                            <div class="date">${dateUtil.getDate(dateObj, "dd MMM yy", locale)}</div>
                                        </#if>
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
    <div class="newsletter-footer">
        <div class="container">
            <div class="copyright">
                Copyright &copy; 2016 Flussbad Berlin e.V. Gemeinnütziger Verein <br/>
                Falckensteinstr. 48, 10997 Berlin. All rights reserved.
            </div>
            <div class="phone">
                Tel: +49.(0)30.555744-50 <br/>
                <a href="http://www.flussbad-berlin.de">www.flussbad-berlin.de</a>
            </div>
            <div class="links">
                <a href="http://www.betterplace.org" target="_blank">Bei Betterplace spenden</a> /
                <a href="https://www.flussbad-berlin.de/wir/mitglieder" target="_blank">Mitglied werden</a><br/>
                <a href="https://www.boost-project.com" target="_blank">Flussbad boosten</a> /
                <a href="https://de-de.facebook.com/flussbadberlin/" target="_blank">Flussbad mögen</a>
            </div>
            <div class="span8 offset2">
                <hr>
            </div>
            <div class="span12 unsubscribe">
                <a href="mailto:info@flussbad-berlin.de?subject=Abmelden">Abmelden</a>
            </div>
        </div>
    </div>  
</div>
