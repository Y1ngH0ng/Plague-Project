(: this is the yearly parish data being pull from the xml and turned into a SVG out put in a horizontal bar graph :)
xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "yes";

let $entries := collection('your-collection-uri')//entry
let $causes := for $c in distinct-values($entries/cause)
               let $count := count($entries[cause = $c])
               order by $count descending
               return <cause name="{$c}" count="{$count}"/>

let $topCauses := subsequence($causes, 1, 4)
let $max := max(for $c in $topCauses return xs:integer($c/@count))

let $scale := 600 div $max
let $bar-color := '#cc3333'

return
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="400">
  <desc>Deaths by Cause - Horizontal Bar Graph</desc>

  <!-- Chart Title -->
  <text x="400" y="30" font-family="Arial" font-size="20" text-anchor="middle" font-weight="bold">
    Deaths by Cause (1664–1666)
  </text>

  <!-- Background -->
  <rect x="140" y="50" width="620" height="100" fill="lightgray" fill-opacity="0.3" rx="10" ry="10"/>

  <g transform="translate(150, 60)" font-family="Arial" font-size="12">
    <!-- X-axis line -->
    <line x1="0" y1="0" x2="600" y2="0" stroke="black" stroke-width="2"/>

    <!-- Grid lines and ticks -->
    {
      for $x in (0, 100, 300, 500)
      return (
        <line x1="{$x}" y1="0" x2="{$x}" y2="90" stroke="#eee"/>,
        <text x="{$x}" y="-5" text-anchor="middle">{$x}</text>
      )
    }

    <!-- Bars and Labels -->
    {
      for $i in 1 to count($topCauses)
      let $cause := $topCauses[$i]
      let $name := $cause/@name/string()
      let $count := xs:integer($cause/@count)
      let $length := round($count * $scale)
      let $y := 15 * $i
      return (
        <text x="-10" y="{$y}" text-anchor="end">{$name}</text>,
        <line x1="0" y1="{$y}" x2="{$length}" y2="{$y}" stroke="{$bar-color}" stroke-width="15"/>
      )
    }
  </g>

  <!-- X-axis label -->
  <text x="450" y="180" font-family="Arial" font-size="14" text-anchor="middle">
    Number of Deaths
  </text>
</svg>
