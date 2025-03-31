for $year in distinct-values(
  for $b in collection('../xml/Parish_Registers/?select=*.xml')//burial
  return substring($b/@date, 1, 4)
)
let $burials-in-year := 
  for $b in collection('../xml/Parish_Registers/?select=*.xml')//burial
  where substring($b/@date, 1, 4) = $year
  return $b
order by $year
return
  <entry>
    <year>{ $year }</year>
    {
      for $cause in distinct-values($burials-in-year/@cause)
      let $count := count($burials-in-year[@cause = $cause])
      return <cause name="{ $cause }" count="{ $count }"/>
    }
  </entry>
