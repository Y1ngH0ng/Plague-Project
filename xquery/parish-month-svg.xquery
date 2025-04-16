xquery version "3.1";
declare option saxon:output"method=html";
declare option saxon:output"doctype-system=about:legacy-compat";
declare variable $start-year := 1664;
declare variable $start-month := 01;
declare variable $total-charts := 32;
declare variable $bar-scale := 5;
declare variable $xspacer := "10";
declare variable $yspacer := "20";
declare variable $chart-padding := 500;
declare variable $registers := collection('../xml/Parish_Registers/?select=*.xml')/register;

<html>
<head>
<title>hi</title>

</head>
<body>








<svg  viewBox="0 0 1000 6000">
{
  for $i in 0 to $total-charts - 1
  let $year := $start-year + floor(($start-month + $i - 1) div 12)
  let $month := (($start-month + $i - 1) mod 12) + 1
  let $month-str := if ($month lt 10) then concat("0", $month) else string($month)
  let $y-offset := $i * $chart-padding
  return 
    <g transform="translate(150, {$y-offset})" font-family="Arial" font-size="12">
       
         <text x="0" y="20" font-size="20" font-weight="bold">
        {concat("Month: ", $month-str, " / ", $year)}
      </text>
          <!-- X-axis line -->
          <!--<div class="x-axis">
        <line x1="0" y1="" x2="600" y2="" stroke="black" stroke-width="2"/>
        </div>-->
        <!-- Grid lines 
        <line x1="0" y1="-15" x2="600" y2="-15" stroke="#ccc" stroke-dasharray="2,2"/>
        <line x1="0" y1="0" x2="0" y2="90" stroke="#ccc" stroke-dasharray="2,2"/>
        <line x1="100" y1="0" x2="100" y2="90" stroke="#eee"/>
        <line x1="300" y1="0" x2="300" y2="90" stroke="#eee"/>
        <line x1="500" y1="0" x2="500" y2="90" stroke="#eee"/>-->
        
        <!-- X-axis ticks -->
        <text x="0" y="-5" text-anchor="middle">0</text>
        <text x="100" y="-5" text-anchor="middle">100</text>
        <text x="300" y="-5" text-anchor="middle">300</text>
        <text x="500" y="-5" text-anchor="middle">500</text>
        <text x="0" y="5" ></text>
{      for $register at $n in $registers (:$n is a position indicator:)
      let $parish-name := $register/@parish
      let $burials := $register//burial[
        substring(@date, 1, 4) = string($year) and 
        substring(@date, 6, 2) = $month-str
      ]
     
      where exists($burials)
      let $cause := distinct-values($burials/@cause)
      let $cause-count := count($cause)
      let $y-spacing := if ($cause-count lt 5) then $yspacer else $xspacer
      let $chart-height := number($cause-count) * number($y-spacing) + 50
      let $parish-y := 30 + ($n - 1) * ($chart-height + 20)
      return
      
      <g transform="translate(0, {$parish-y})">
      
         <!-- Gray translucent background box -->
   <!-- <rect x="0" y="0" width="620" height="100" fill="lightgray" fill-opacity="0.3" rx="10" ry="10"/> -->
<!-- Gray translucent background box (dynamic height) -->
<rect x="0" y="0" width="620" height="{$chart-height}" fill="lightgray" fill-opacity="0.3" rx="10" ry="10"/>

<!-- X-axis line and ticks positioned 10px below rect -->
<g class="x-axis">
  <line x1="0" y1="{$chart-height + 10}" x2="600" y2="{$chart-height + 10}" stroke="black" stroke-width="2"/>
  <text x="0" y="{$chart-height + 5}" text-anchor="middle">0</text>
  <text x="100" y="{$chart-height + 5}" text-anchor="middle">100</text>
  <text x="300" y="{$chart-height + 5}" text-anchor="middle">300</text>
  <text x="500" y="{$chart-height + 5}" text-anchor="middle">500</text>
</g>

        <parish name="{$parish-name}">
       
          {
            for $cause at $cause-no in distinct-values($burials/@cause)
            let $count := count($burials[@cause = $cause])
            let $yspacer := 30 +number($cause-no)*number($yspacer)
            let $bar-length := $count * $bar-scale
             return (
             
            <text x="10" y="{$yspacer + 5}" font-size="12">{$cause}</text>,
            <line x1="150" y1="{$yspacer}" x2="{150 + $bar-length}" y2="{$yspacer}" stroke="steelblue" stroke-width="10"/>,
            <text x="{155 + $bar-length}" y="{$yspacer + 5}" font-size="12" font-weight="bold">{$count}</text>
          )}
          
          
         
          
        </parish>
  
        </g>
        }
 
        </g> 
        }
</svg>
</body>
</html>