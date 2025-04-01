xquery version "3.1";
declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');
declare variable $pars:=//parish;
declare variable $bill-week:=//bill/data(@week);
declare variable $xspacer := 10;
declare variable $yspacer := 35;

<html>
<head><title>Plague Deaths for Week{$bill-week}</title></head>
<body>

<p><table> 
<th>Plague Numbers for Week {$bill-week}</th>
{let $pars:=//parish
for $par in $pars
let $plag:=$par/data(@plag)
let $parname:=$par/data(@name)


return <tr><td>{$parname}</td><td>{$plag}</td></tr>}

</table>
</p>

<p>The Graph Below is a visual of Plague-Deaths per week for {$bill-week}. The Red Line is Plague Deaths and the Blue Line is total burials. Parishes that do not have any Plague Deaths or Burials are not listed on the graph but are on the table</p>

<svg xmlns="http://www.w3.org/2000/svg" height="5000" width="7000" align="center">
    <desc></desc>
    <g alignment-baseline="baseline" transform="translate(300,100)">
<text x="6" y="-6">Week {$bill-week}</text>
        <text x="250" y="-6">Red=Plague and Blue=Burials</text>
      <line x1="0" y1="0" x2="2500" y2="0" stroke-width="5" stroke="black" />
        
        <line x1="0" y1="0" x2="0" y2="4750" stroke-width="5" stroke="black" />
<g/>
<g>
{
for $par at $pos in $pars
let $plag:=$par/data(@plag)
let $parname:=$par/data(@name)
let $bur:= $par/data(@bur)
where $plag >0
where $bur >0



return <g><line x1="0" y1="{$pos * $yspacer -5}" x2="{$plag * $xspacer} " y2="{$pos * $yspacer -5}" stroke="red" stroke-width="25"/>
        
        <line x1="0" y1="{$pos * $yspacer}" x2="{$bur * $xspacer}" y2="{$pos*$yspacer}" stroke="blue" stroke-width="15"/>
        <text font-size="20" x="-225" y="{$pos * $yspacer}" text-align="center">{$parname}</text>
           <text font-size="15" x="{$plag* $xspacer +15}" y="{$pos * $yspacer -10}" text-align="center">{$plag}</text>
           <text font-size="15" x="{$bur* $xspacer}" y="{$pos * $yspacer +10}" text-align="center">{$bur}</text>
           </g>} 
           
                    </g>
           </g>
           </svg>
           
           </body>
           </html>