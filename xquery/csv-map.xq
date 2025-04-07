xquery version "3.1";
declare option saxon:output "method=text";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');

declare variable $linefeed := "&#10;";
(:declare variable $parname:=/parish/data(@name);  :)


(:whc: First we need to assemble the top row of the table :)
concat("Week Plague", ",",string-join(
         for $bill in $source-files
         let $weeknum:=$bill//bill//data(@week)
         return $weeknum, ","),",","Week Percent",string-join(for $bill in $source-files
         let $weeknum:=$bill//bill//data(@week)
         return $weeknum, ","), $linefeed,
(:whc: note that we do not end with a closing paren after $linefeed. That's because the concat() is assembling not just this line but the entire table. :)
(:whc: Next we need the FLWOR statement to create all the rows of data  :)
string-join(
let $pars:=$source-files[.//bill/data(@week)='01']//parish[data(@alt)!="tbd"]
for $par in $pars
    let $parname := $par/data(@name)
    let $par-alt-name := $par/data(@alt)
    order by $par-alt-name
    (:whc: the next return begins each row of the table, then the string-join assembles all the comma-separated values in the row :)
    return concat($par-alt-name, ",", string-join(
        for $bill in $source-files
        let $this-par := $bill//parish[data(@name)=$parname]
        let $plag := $this-par/data(@plag)
        let $weeknum:=$bill//bill//data(@week)
        where $weeknum>0
        let $bur:= $this-par/data(@bur)
        
        return if ($bur=0) then concat($plag,",0"    
               ) else concat($plag,",",($plag div $bur) * 100)),","),    
               $linefeed)) 


