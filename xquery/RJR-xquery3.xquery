xquery version "3.1";

declare namespace file = "http://expath.org/ns/file";

let $dir := "/Users/rjromano/Documents/GitHub/Plague-Project/xml/Parish_Registers"
let $files := file:list($dir, false())

let $all-burials :=
  for $f in $files
  where ends-with($f, ".xml") and not(ends-with($f, ".rnc"))
  let $full := concat($dir, "/", $f)
  return
    try {
      let $doc := doc($full)
      for $burial in $doc//burial

      let $cause :=
        if ($burial/@cause) then lower-case(normalize-space(string($burial/@cause)))
        else if ($burial/cause) then lower-case(normalize-space(string($burial/cause)))
        else ""

      where not(matches($cause, 'plag'))

      let $date :=
        if ($burial/@date) then string($burial/@date)
        else if ($burial/date) then string($burial/date)
        else ""

      let $month :=
        if (matches($date, "^\d{4}-\d{2}-\d{2}$"))
        then substring($date, 1, 7)
        else "unknown"

      let $name :=
        if ($burial/@name) then normalize-space(string($burial/@name))
        else if ($burial/name) then normalize-space(string($burial/name))
        else ""

      return
        <entry>
          <month>{ $month }</month>
          <name>{ $name }</name>
          <cause>{ $cause }</cause>
          <date>{ $date }</date>
        </entry>
    } catch * {
      ()
    }

let $grouped :=
  for $m in distinct-values($all-burials/month)
  let $group := $all-burials[month = $m]
  let $suspicious := count($group[cause = "x"])
  order by $m
  return
    <month name="{$m}">
      <count>{ $suspicious }</count>
      {
        for $b in $group
        return
          <burial>
            <name>{ $b/name/string() }</name>
            <cause>{ $b/cause/string() }</cause>
            <date>{ $b/date/string() }</date>
          </burial>
      }
    </month>

return
<non-plague-burials>
  { $grouped }
</non-plague-burials>
