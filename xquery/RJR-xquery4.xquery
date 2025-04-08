for $register in collection('../xml/Parish_Registers/?select=*.xml')/register
let $parish-name := $register/@parish
let $burials := $register//burial
let $months := distinct-values(for $b in $burials return substring($b/@date,6,2))
let $sorted-months :=for $m in $months order by $m return $m order by $parish-name 
return
    <parish name="{ $parish-name }">
    {
        for $month in $sorted-months
        let $burials-in-month :=
     $burials[substring(date,6,2) =$month]
     return
        <month value="{$month}">
        {
        for $cause in distinct-values($burials-in-month/@cause)
        let$count := count($burials-in-month[@cause = $cause])
        return <cause
        name="{ $cause }" count="{ $count }"/>
            }
            </month>
            
            }</parish>