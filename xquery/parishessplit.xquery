for $register in collection('../xml/Parish_Registers/?select=*.xml')/register
let $parish-name := $register/@parish
let $burials := $register//burial
let $years := distinct-values(for $b in $burials return substring($b/@date, 1, 4))
order by $parish-name
return
  <parish name="{ $parish-name }">
    {
      for $year in $years
      let $burials-in-year := $burials[substring(@date, 1, 4) = $year]
      return
        <year value="{ $year }">
          {
            for $cause in distinct-values($burials-in-year/@cause)
            let $count := count($burials-in-year[@cause = $cause])
            return <cause name="{ $cause }" count="{ $count }"/>
          }
        </year>
    }
  </parish>
