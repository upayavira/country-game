<html>
  <head>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
<body>
<h1>Countries</h1>
<ul>
{% for country in countries %}
  <ul><a href="countries/{{country.name.common}}">{{country.name.common}}</a></ul>
{% endfor %}
</ul>
<a href="/">BACK</a> 
</body>
</html>
