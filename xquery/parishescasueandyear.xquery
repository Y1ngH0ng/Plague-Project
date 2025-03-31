for $year in distinct-values(
    for $b in collection('../xml/Parish_Registers/?select=*.xml')//burial
    return substring($b/@date, 1, 4)
)
let $burials-in-year := 
    for $b in collection('../xml/Parish_Registers/?select=*.xml')//burial
    where substring($b/@date, 1, 4) = $year
    return $b
for $cause in distinct-values($burials-in-year/@cause)
let $count := count($burials-in-year[@cause = $cause])
order by $year, $cause
return
  <entry>
    <year>{ $year }</year>
    <cause>{ $cause }</cause>
    <count>{ $count }</count>
  </entry>
