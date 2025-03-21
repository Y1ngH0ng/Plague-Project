xquery version "3.1";

declare variable $allDocs := collection('../Plague-Project/xquery/jw-xquery2/?select=*.xml');
for $b in //burial
return 
<html>
  <head>
    <title>Burial Summary</title>
  </head>
  <body>
    <h2>Burial Summary</h2>
    
    <p>Total Deaths: {count($allDocs//burial)}</p>

    <h3>Causes of Death Breakdown</h3>
    <table border="1">
      <tr>
        <th>Cause of Death</th>
        <th>Count</th>
      </tr>
      {
        for $cause in distinct-values($allDocs//burial/@cause)
        let $count := count($allDocs//burial[@cause = $cause])
        order by $count descending
        return 
          <tr>
            <td>{data($cause)}</td>
            <td>{$count}</td>
          </tr>
      }
    </table>
  </body>
</html>
