<div align="center"><img src ="http://i.imgur.com/hn7YyWh.png?1" /> <br> <br> <h1>Forecast for iOS </h1> <h3> A small Swift Weather App </h3></div>

<div align="center">

<img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg">
<img src="https://img.shields.io/badge/deployment%20target-iOS%209-brightgreen.svg">
<img src="https://img.shields.io/badge/language-Swift%202-brightgreen.svg">

</div>

<br>


### Screenshots

<table align="center" border="0">

<tr>
<td> <img src="http://i.imgur.com/9X9XJQP.png"> </td>
<td> <img src="http://i.imgur.com/uiC6biV.png"> </td>
</tr>

<tr> <td colspan="2" align="center">Symbols and background change with time and weather condition</td> </tr>


</table>

### Features

* Accurate, location-based weather data by Forecast.io API
* 5-day forecast
* Dynamic background depending on current temperature
* Clean UI

### Used Resources

Forecast uses the [forecast.io](https://forecast.io) API for weather data. The Tab Bar Icon is licensed under CC BY-ND 3.0 and provided by [icons8](http://icons8.com).  The weather icons are provided by [weathericons.io](http://weathericons.io).

### Notes by Developer

In case you want to improve this app, feel free to create an issues or a Pull Request.
Right now, I use some bad practices (for example bad callback handling), I'll try to fix most of that in the next couple of days.

### Build Notes

To build this project sucessfully, please just add Alamofire and SwifityJSON pods. 

    pod 'Alamofire', '~> 3.0'
    pod ‘SwiftyJSON’
    pod 'SwiftOverlays', '~> 1.0'

### License
This project is licensed under the MIT License, see [here](https://opensource.org/licenses/MIT) for more information.

