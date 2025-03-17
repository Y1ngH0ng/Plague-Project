xquery version "3.1";
declare variable $source-files:=collection('../XML\Bills-mortality-validated/?select=*.xml');
declare variable $Bills-mort-24:=('$source-files/Bills-Mortality-24.xml');


(:let $plag:=//parish/@plag
let $plagcount:=//parish/@plag
=>count():)

(: I am trying to get the value of the attribute @plag but I will not work:)
(:Instead it gives me the total count of the attributes not the values:)

(:return $plagcount:)

(:let $parname:=//parish/@name
let $name-list:=$parname


return $name-list=>string-join('&#xa;'):)

(:This works and gives me the names in a list form but the last attemtpt will not work:)
(:Here I was tryig to build a list of Parish names and plag numbers on Bills of Mort 24 and it did not work:)
(:let $pars:=//parish
for $par in $pars
let $plag:=$par/@plag
let $parname:=$par/@name


return concat($parname,' had plag numbers ', $plag ,'&#xa;'):)

let $pars:=//parish
let $plagtotal:=//parish/@plag=>sum()
for $par in $pars
let $plag:=$par/@plag

return $plagtotal



