# List Outgoing Display Numbers for all Enterprise Voice-enabled CSUsers

function main
    {
    $AgentList = Get-CsUser -Filter { EnterpriseVoiceEnabled -eq $true }

    foreach ($agent in $AgentList)
        {
        if ($agent.LineURI -eq [String]::Empty)
            {
            # No LineURI - skip
            }
        else
            {
            $Agentname = $agent.DisplayName
            $AgentLineURI = $agent.lineuri
            $AgentLineURI = $AgentLineURI.substring(4)
           # if ($AgentLineURI -like '*ext*')
            if ($AgentLineURI -like '+5*')
                {
                $OutboundDisplayNumber = Return-OutboundDisplayNumber $AgentLineURI
                $Result = "Agent; " + $agentname + " " + $OutboundDisplayNumber
                $Result
                }
            else
                {
                #$OutboundDisplayNumber = $AgentLineURI
                #$Result = $agentname + " " + $OutboundDisplayNumber
                #$Result
                }
            }
        }
    }

function Return-OutboundDisplayNumber ($ALineURI)
    {
    $AllTranslationRules = Get-CsOutboundCallingNumberTranslationRule
    foreach ($TranslationRule in $AllTranslationRules)
        {
        If ($ALineURI -match $TranslationRule.Pattern) 
            {
            $TranslationRule.translation
            }
        Else 
            {
            # "No match in translation rules."
            }
        }
    }

#    Return-OutboundDisplayNumber '+50005041;ext=9122'
#    Return-OutboundDisplayNumber '+50005082;ext=9156'


main



#'tel:+4750005001;ext=9023' -match '^tel:\+4750005001(\s*\S)*$'
