xquery version "3.1";
declare option saxon:output "method=html";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');

<html>
<head><title>Week count with Plague numbers</title></head>
<body>
<table>
<tr><th>Name</th><th>Plag count</th><th>Week #</th></tr>
{let $pars:=$source-files//parish
let $weeks:=$source-files//bill
let $weeknum:=$weeks/@week
for $par in $pars
let $plag:=$par/@plag
let $parname:=$par/string(@name)



(: I get this to generate an HTMl Table of all the bills with plag counts and parish names. I just cannot get the week count to show up. Also I was trying to alphabetize it but could not get it to work:)
return <tr><td>{$parname}</td><td>{$plag}</td><td>{$weeknum}</td></tr> }

</table>
</body>
</html>
(:return concat($parname,' had plag numbers ', $plag, ',during week ', $weeknum,'&#xa;'):)
(:{$weeknum}:)