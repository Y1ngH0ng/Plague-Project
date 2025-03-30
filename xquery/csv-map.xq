xquery version "3.1";
declare option saxon:output "method=text";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');




 for $bill in $source-files
         let $weeknum:=$bill//bill//data(@week)
       
         
let $pars:=$source-files[.//bill/data(@week)='01']//parish


for $par in $pars
    let $parname := $par/data(@name)
    order by $parname


    for $bill in $source-files
    
        let $this-par := $bill//parish[data(@name)=$parname]
        let $plag := $this-par/data(@plag)
        
        return concat($parname,',',$plag,',', $weeknum, ',', '&#xa;')

