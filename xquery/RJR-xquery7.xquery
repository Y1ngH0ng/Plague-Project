let $registers := collection('../xml/Parish_Registers/?select=*.xml')/register

let $year-months := distinct-values(
  for $r in $registers
  for $b in $r//burial
  let $year := substring($b/@date, 1, 4)
  let $month := substring($b/@date, 6, 2)
  return concat($year, '-', $month)
)

let $sorted-year-months := 
  for $ym in $year-months
  order by $ym
  return $ym

let $years := distinct-values(for $ym in $sorted-year-months return substring($ym, 1, 4))
let $sorted-years := for $y in $years order by $y return $y

return
for $year in $sorted-years
return
  <year value="{$year}">
    {
      for $ym in $sorted-year-months
      where substring($ym, 1, 4) = $year
      let $month := substring($ym, 6, 2)
      return
        <month value="{$month}">
          {
            for $register in $registers
            let $parish-name := $register/@parish
            let $burials := $register//burial[substring(@date, 1, 4) = $year and substring(@date, 6, 2) = $month]
            where exists($burials)
            return
              <parish name="{$parish-name}">
                {
                  for $cause in distinct-values($burials/@cause)
                  let $count := count($burials[@cause = $cause])
                  return <cause name="{$cause}" count="{$count}"/>
                }
              </parish>
          }
        </month>
    }
  </year>
