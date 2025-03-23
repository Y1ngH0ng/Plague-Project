xquery version "3.0";
declare variable $bills := collection('./Bills-mortality-validated')//bill[@week];
declare variable $parish-registers := collection('./Bills-mortality-validated')/register;
declare variable $parish-registers-with-causes := $parish-registers[.//burial/@cause];
declare variable $parish-registers-no-causes := $parish-registers[.//burial/not(@cause)];


<html>
<head><title>Bills of Mortality: Analysis</title></head>
<body>
<h1>Trends in London Bills of Mortality, 1665</h1>
<h2>Parishes with the greatest number of plague deaths, by week</h2>
<p>(Excludes weeks when no plague deaths reported)</p>
<table>
<tr><th>Week no.</th><th>Parish name</th><th>Parish plague deaths</th><th>Total plague deaths</th></tr>
{for $b in $bills
where $b//summary/burials/data(@plague) > 0
let $maxPlagueNo := $b//parish/data(@plag)=>max()
let $maxPlaguePar := $b//parish[data(@plag)=$maxPlagueNo]/data(@name)
let $startDate := $b/data(@week-from)=>replace(., "-", "")
order by $b/data(@week)
return
<tr><th>{$b/data(@week)}</th><td>{$maxPlaguePar}</td><td>{$maxPlagueNo}</td><td>{$b//summary/burials/data(@plague)}</td></tr>
}
</table>
<h2>Parishes with highest total death count by week, 1665</h2>
<p>Includes all weeks</p>
<table>
<tr><th>Week no.</th><th>Parish name</th><th>Parish deaths</th><th>London total deaths</th></tr>
{for $b in $bills
let $maxDeathNo := $b//parish/data(@bur)=>max()
let $maxDeathPar := $b//parish[data(@bur)=$maxDeathNo]/data(@name)
order by $b/data(@week)
return
<tr><th>{$b/data(@week)}</th><td>{$maxDeathPar}</td><td>{$maxDeathNo}</td><td>{$b//summary/burials/data(@total)}</td></tr>
}
</table>
<h2>Parishes with plague causing the highest percentage of deaths</h2>
<p>(Excludes weeks when no plague deaths reported)</p>
<p>(This table not working correctly: I must be doing my math wrong)</p>
<table>
<tr><th>Week no.</th><th>Parish name</th><th>Parish plague deaths</th><th>Total plague deaths</th><th>Percent in highest parish</th></tr>
{for $b in $bills
where $b//summary/burials/data(@plague) > 0
let $maxPlaguePercent := $b//parish[(data(@plag) div data(@bur))=max($b//parish/(data(@plag) div data(@bur)))]
/(data(@plag) div data(@bur))

let $maxPlaguePercentPar := $b//parish[(data(@plag) div data(@bur))=$maxPlaguePercent]/data(@name)
let $maxPlagueNo := $b//parish/data(@plag)=>max()
order by $b/data(@week)
return
<tr><th>{$b/data(@week)}</th>
<td>{$maxPlaguePercentPar}</td>
<td>{$maxPlagueNo}</td>
<td>{$b//summary/burials/(data(@plague) div data(@total)) * 100}%</td>
<td>{$maxPlaguePercent[1] * 100}%</td></tr>
}
</table>
<h2>Reported Deaths by Week: Plague and Other Leading Causes</h2>
        <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox = "0 0 1100 800"
            width="100%"
            height="100%">
            <g
                transform="translate(40,750)">
                <g>
                    {
                        for $b in $bills
                        order by $b/data(@week)
                        return
                            <g>
                            <text x="{$b/data(@week) * 20 - 5}" y="100">{$b/data(@week)}</text>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Aged"]/data(@count)) div -10}"
                                    r="5"
                                    fill="blue"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Consumption"]/data(@count)) div -10}"
                                    r="5"
                                    fill="red"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Convulsion"]/data(@count)) div -10}"
                                    r="5"
                                    fill="orange"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Dropsie"]/data(@count)) div -10}"
                                    r="5"
                                    fill="yellow"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Feaver"]/data(@count)) div -10}"
                                    r="5"
                                    fill="green"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Flox_and_Small-pox"]/data(@count)) div -10}"
                                    r="5"
                                    fill="blue-green"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Griping_in_the_Guts"]/data(@count)) div -10}"
                                    r="5"
                                    fill="brown"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Spotted_Feaver"]/data(@count)) div -10}"
                                    r="5"
                                    fill="purple"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Surfeit"]/data(@count)) div -10}"
                                    r="5"
                                    fill="tangerine"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Teeth"]/data(@count)) div -10}"
                                    r="5"
                                    fill="ivory"
                                    opacity="75%"/>
                                <circle
                                    cx="{$b/data(@week) * 20}"
                                    cy="{number($b//Q{}item[@cause = "Plague"]/data(@count)) div -10}"
                                    r="5"
                                    fill="black"
                                    opacity="75%"/>
                            
                            </g>
                    }</g>
            </g>
        </svg>

</body>
</html>
