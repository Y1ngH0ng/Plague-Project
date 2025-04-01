xquery version "3.1";
declare option saxon:output "method=text";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');

declare variable $linefeed := "&#10;";



concat("Label, Parish, Plag#, Week#",$linefeed,string-join(


let $pars:=$source-files[.//bill/data(@week)='01']//parish


for $par in $pars
    let $parname := $par/data(@name)
    order by $parname
  (:  where $parname!="tbd" :)
    (: TLW This was an attempt to stop tbd from showing up but it isn;t even without this:)


    for $bill in $source-files
    
        let $this-par := $bill//parish[data(@name)=$parname]
        let $plag := $this-par/data(@plag)
        let $weeknum:=$bill//bill//data(@week)
        where $weeknum>0
        
        
       
       
        return concat($parname,',',$plag,',', $weeknum, ',', $linefeed)))=>string-join()
        (: output clones each parish 52 times when instead it needs to ne just one. This should be troubleshot:)

