xquery version "3.1";

declare variable $source-files := collection('../XML/Bills-mortality-validated/?select=*.xml');
declare variable $Bills-mort-27 := doc('../XML/Bills-mortality-validated/Bills-Mortality-27.xml');

let $doc := $Bills-mort-27
let $parishes := $doc//parish
let $total-plague := sum($parishes/@plag)

return 
    <result>
        <total-plague>{$total-plague}</total-plague>
        {
            for $parish in $parishes
            where $parish/@plag >= 1
            order by $parish/@plag descending
            return <parish name="{$parish/@name}" plague-count="{$parish/@plag}"/>
        }
    </result>


(:let $pars:=//parish
for $par in $pars
let $plag:=$par/@plag
let $parname:=$par/@name
return concat($parname,' had plag numbers ', $plag ,'&#xa;'):)

