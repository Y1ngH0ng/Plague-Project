
xquery version "3.1";

declare variable $source-files := collection('../xml/Parish_Registers/?select=*.xml');
declare variable $stchristopherstocks := doc('../xml/Parish_Registers/StChristopherStocks.xml');

let $burials := $stchristopherstocks//burial[@cause="plague"]
return
<svg xmlns="http://www.w3.org/2000/svg" width="600" height="400" viewBox="0 0 600 400">
  <rect width="600" height="400" fill="black"/>
  <text x="300" y="30" text-anchor="middle" font-size="20">Plague Burials in St. Christopher Stocks Parish</text>
  
  {
    for $burial at $pos in $burials
  
    return (
      <circle cx="100" cy="50" r="10" fill="red"/>,
      <text x="120" y="5" font-size="14">
        {$burial/person/name/string() || " (" || $burial/date/string() || ")"}
      </text>
    )
  }
  
  <text x="300" y="380" text-anchor="middle" font-size="14">
    Total plague burials: {count($burials)}
  </text>
</svg>

