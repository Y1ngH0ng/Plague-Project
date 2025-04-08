declare variable $target-year := "1664";
declare variable $target-month := "02";

let $registers := collection('../xml/Parish_Registers/?select=*.xml')/register

return
<year value="{$target-year}">
  <month value="{$target-month}">
    {
      for $register in $registers
      let $parish-name := $register/@parish
      let $burials := $register//burial[
        substring(@date, 1, 4) = $target-year and 
        substring(@date, 6, 2) = $target-month
      ]
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
</year>
