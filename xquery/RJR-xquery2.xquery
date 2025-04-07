xquery version "3.1";

declare variable $source-files := doc('../Documents/Github/Plague-Project/xml/Parish_Registers/ST-NicholasAcons.xml');

let $gd-plagdeaths := //burials[descendant::burial[@cause="plag"]]
let $gd-plagdeaths2 := $gd-plagdeaths//burials/data(@cause)=> distinct-values()
let $gd-plagcount := 

return (concat ("The amount of plague deaths in this parish are" , $gd-plagdeaths, "thank you."))