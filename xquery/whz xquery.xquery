xquery version "3.1";

declare variable $source-files := collection('../xml/Parish_Registers/?select=*.xml');
declare variable $stchristopherstocks := doc('../xml/Parish_Registers/StChristopherStocks.xml');
(:telling where to get the source:)
let $stocks := $stchristopherstocks//burials[./burial[@cause="plague"]] (:find the thing tag by @cause plauge:)
for $stock in $stocks
    let $stock-name := $stock/burial[@cause="plague"]
    let $stock-info := $stock/text() (:give me text of the @cause tag above:)
return $stock/string() (:give me the list of the @cause plague:)
(:return concat($stock-name, 'name' ,$stock-info, "$#xa"):)

(:not giving me anything as a output:)
