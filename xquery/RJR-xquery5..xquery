

for $register in collection('../xml/Parish_Registers/?select=*.xml')/register
let $parish-name := $register/@parish
let $burials := $register//burial
let $month := distinct-values(for $b in $burials return substring($b/@date, 6, 2))
order by $parish-name
return
  <parish name="{ $parish-name }">
    {
      for $month in $month
      let $burials-in-year := $burials[substring(@date, 6, 2) = $month]
      return
        <month value="{ $month }">
          {
            for $cause in distinct-values($burials-in-year/@cause)
            let $count := count($burials-in-year[@cause = $cause])
            return <cause name="{ $cause }" count="{ $count }"/>
          }
        </month>
    }
  </parish>