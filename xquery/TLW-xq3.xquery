xquery version "3.1";
declare option saxon:output "method=html";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');

<html>
<head><title>Week count with Plague numbers</title></head>
<body>
<table>
<tr><th>Name</th><th>Week 1</th></tr>

{
(:whc: This starts by limiting parishes to the ones listed in the week 1 bill, so it only comes up with the list of parishes a single time, not separately for each bill:)
let $pars:=$source-files[.//bill/data(@week)='01']//parish

(:whc: still iterating only over the parishes listed in the week 1 bill :)
for $par in $pars
    let $parname := $par/data(@name)
    order by $parname

    return <tr><td>{$parname}</td>
    { (:whc: next, to create the sequence of weekly plague deaths by iterating over the bills:)
    for $bill in $source-files
    
    (:whc: the range variable finds, from each bill in sequence, the one parish with the same @name as the one for which we're currently building the table row :)
        let $this-par := $bill//parish[data(@name)=$parname]
        let $plag := $this-par/data(@plag)
    (:whc: now we tell it to create one td element for each bill aka each week :)
        return<td>{$plag}</td>}

</tr> 
}

</table>
</body>
</html>
(:return concat($parname,' had plag numbers ', $plag, ',during week ', $weeknum,'&#xa;'):)
(:{$weeknum}:)