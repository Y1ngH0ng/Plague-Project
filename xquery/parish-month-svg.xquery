declare variable $target-year := "1664";
declare variable $target-month := "02";
declare variable $xspacer := "10";
declare variable $yspacer := "20";
declare variable $registers := collection('../xml/Parish_Registers/?select=*.xml')/register;
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">

    <g transform="translate(150, 60)" font-family="Arial" font-size="12">
        <!--whc: change the following to a text output that gives the month and year using the variables:
<year value="{$target-year}"> 
  <month value="{$target-month}">  -->
        
{      for $register at $n in $registers (:$n is a position indicator:)
      let $parish-name := $register/@parish
      let $burials := $register//burial[
        substring(@date, 1, 4) = $target-year and 
        substring(@date, 6, 2) = $target-month
      ]
      where exists($burials)
      return
      <g>  <!--position using transform translate and $n from above-->
          <!-- Gray translucent background box -->
    <rect x="140" y="50" width="620" height="100" fill="lightgray" fill-opacity="0.3" rx="10" ry="10"/> <!--whc: height of box can be scaled to fit the number of causes in that parish that month-->
    <!-- X-axis line -->
        <line x1="0" y1="0" x2="600" y2="0" stroke="black" stroke-width="2"/>
        
        <!-- Grid lines -->
        <line x1="0" y1="-15" x2="600" y2="-15" stroke="#ccc" stroke-dasharray="2,2"/>
        <line x1="0" y1="0" x2="0" y2="90" stroke="#ccc" stroke-dasharray="2,2"/>
        <line x1="100" y1="0" x2="100" y2="90" stroke="#eee"/>
        <line x1="300" y1="0" x2="300" y2="90" stroke="#eee"/>
        <line x1="500" y1="0" x2="500" y2="90" stroke="#eee"/>
        
        <!-- X-axis ticks -->
        <text x="0" y="-5" text-anchor="middle">0</text>
        <text x="100" y="-5" text-anchor="middle">100</text>
        <text x="300" y="-5" text-anchor="middle">300</text>
        <text x="500" y="-5" text-anchor="middle">500</text>
        <parish name="{$parish-name}"><!--replace this as a text element-->
          {
            for $cause at $cause-no in distinct-values($burials/@cause)
            let $count := count($burials[@cause = $cause])
            return <cause name="{$cause}" count="{$count}"/>
            (:output cause as text label for bar, count as end label for bar, and use count to determine the length of bar:)
            (:output line element for bar for graph, length based on $count, y-position based on $cause-no times a yspacer :)
          }
        </parish></g>
}
</g>
</svg>