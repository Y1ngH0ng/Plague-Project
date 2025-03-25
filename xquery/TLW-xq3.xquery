xquery version "3.1";
declare option saxon:output "method=html";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');

<html>
<head><title>Week count with Plague numbers</title></head>
<body>
<table>
<tr><th>Name</th><th>Week 1</th></tr>

{
(:let $parnames :=$source-files[bill/data/data(@week)='1']:)
let $pars:=$source-files[.//bill/data(@week)='01']//parish

(:order by $source-files[bill/data/data(@week)='1']//parish/string(@name)
group by $parname:=$source-files[bill/data/data(@week)='1']//parish/string(@name)  :)
for $par in $pars
let $parname := $par/data(@name)
order by $parname

let $plag:=$par/data(@plag)
let $bur:= $par/data(@bur)
return <tr><td>{$parname}</td><td>{$plag}</td></tr> 
(:let $bills:= $source-files/bill


for $bill in $bills
let $weeknum:=$bills/data(@week)
:)







(: I get this to generate an HTMl Table of all the bills with plag counts and parish names. I just cannot get the week count to show up. Also I was trying to alphabetize it but could not get it to work:)
}

</table>
</body>
</html>
(:return concat($parname,' had plag numbers ', $plag, ',during week ', $weeknum,'&#xa;'):)
(:{$weeknum}:)