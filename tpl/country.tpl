<html>
  <head>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    .google-maps {
        position: relative;
        padding-bottom: 75%; // This is the aspect ratio
        height: 0;
        overflow: hidden;
    }
    .google-maps iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100% !important;
        height: 100% !important;
    }
</style>
  </head>
<body>
<h1>Country: {{country.name.common}}</h1>
<b>Capital: </b>{{country.capital}}
<br/>

<div class="google-map">
<iframe
  width="600"
  height="450"
  frameborder="0" style="border:0"
  src="https://www.google.com/maps/embed/v1/view?key={{api_key}}&center={{country.latlng[0]}},{{country.latlng[1]}}&zoom=8"
  allowfullscreen>
</iframe>
</div>
<p><a href="/">BACK</a></p>
</body>
</html>
