xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5";

let $current-year := "Bill of Mortality"
let $weeks := (1 to 52)
return
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <title>Weekly Links</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 2em; }}
            h1 {{ color: #333; }}
            .week-container {{ display: flex; flex-wrap: wrap; gap: 10px; }}
            .week-link {{
                display: block;
                padding: 8px 12px;
                background-color: #f0f0f0;
                border-radius: 4px;
                text-decoration: none;
                color: #0066cc;
            }}
            .week-link:hover {{ background-color: #e0e0e0; }}
        </style>
    </head>
    <body>
        <h1>Weekly Links - {$current-year}</h1>
        <div class="week-container">
        {
            for $week in $weeks
            return
                <a href="week-{$week}-data.html" class="week-link">Week {$week}</a>
        }
        </div>
    </body>
</html>