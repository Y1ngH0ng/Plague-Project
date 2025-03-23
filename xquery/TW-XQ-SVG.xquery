xquery version "3.1";
declare variable $source-files:=collection('../XML/Bills-mortality-validated/?select=*.xml');
declare option saxon:output "method=text";
let $pars:=//parish
for $par in $pars
let $plag:=$par/@plag
let $parname:=$par/@name
let $bur:= $par/@bur



return concat($parname,',',$plag, ',', $bur,'&#xa;')
