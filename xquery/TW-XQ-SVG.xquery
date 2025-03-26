xquery version "3.1";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');
declare variable $pars:=//parish;
declare variable $bill-week:=//bill/data(@week);
declare variable $xspacer := 10;
declare variable $yspacer := 35;


<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 6000">
    <desc></desc>
    <g alignment-baseline="baseline" transform="translate(10,100)">
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
        <text x="-190" y="{$pos * $yspacer}" text-align="center" >{$parname}</text>
           <text x="{$plag* $xspacer +15}" y="{$pos * $yspacer -10}" text-align="center">{$plag}</text>
           <text x="{$bur* $xspacer}" y="{$pos * $yspacer +10}" text-align="center">{$bur}</text>
           </g>} 
           
                    </g>
           </g>
           </svg>