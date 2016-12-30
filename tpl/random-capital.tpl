<html>
  <head>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script>
       function show() {
         document.getElementById('detail').style.display='block';
       }
    </script>
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
<h1>Capital: </b>{{country.capital}}</h1>

<div id="detail" style="display:none">
Country: {{country.name.common}}
<br/>

<div class="google-maps">
<iframe
  width="600"
  height="450"
  frameborder="0" style="border:0"
  src="https://www.google.com/maps/embed/v1/view?key={{api_key}}&center={{country.latlng[0]}},{{country.latlng[1]}}&zoom={{zoom}}"
  allowfullscreen>
</iframe>
</div>
</div>
<p><a href="#" onclick="show();return false;">REVEAL</a></p>
<p><a href="#" onclick="location.reload()">NEXT</a></p>
<p><a href="/">BACK</a></p>
</body>
</html>
