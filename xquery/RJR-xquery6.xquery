let $registers := collection('../xml/Parish_Registers/?select=*.xml')/register
let $all-months := distinct-values(
    for $r in $registers
    for $b in $r//burial
    return substring($b/@date, 6, 2)
)
let $sorted-months := for $m in $all-months order by $m return $m

return
for $month in $sorted-months
return
  <month value="{$month}">
    {
      for $register in $registers
      let $parish-name := $register/@parish
      let $burials-in-month := $register//burial[substring(@date, 6, 2) = $month]
      return
        <parish name="{$parish-name}">
          {
            for $cause in distinct-values($burials-in-month/@cause)
            let $count := count($burials-in-month[@cause = $cause])
            return <cause name="{$cause}" count="{$count}"/>
          }
        </parish>
    }
  </month>
