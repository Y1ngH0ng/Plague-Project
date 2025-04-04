xquery version "3.1";

for $b in //burial
return 
<html>
  <head>
    <title>Burial Summary</title>
  </head>
  <body>
    <h2>Burial Summary</h2>
    
    <p><strong>Total Deaths:</strong> {count(//burial)}</p>

    <h3>Causes of Death Breakdown</h3>
    <table border="1">
      <tr>
        <th>Cause of Death</th>
        <th>Count</th>
      </tr>
      {
        for $cause in distinct-values(//burial/@cause)
        let $count := count(//burial[@cause = $cause])
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


