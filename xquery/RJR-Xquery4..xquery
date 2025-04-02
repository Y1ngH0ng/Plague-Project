declare variable $allDocs := collection('../xml/Parish_Registers/?select=*.xml');  

    let $month :=
        if (matches($date, "^\d{4}-\d{2}-\d{2}$"))
        then substring($date, 1, 7)
        else "unknown"
        
        return
        
         <month>{ $month }</month>