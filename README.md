[![Build Status](https://travis-ci.org/gprasant/express-sextant.png?branch=master)](https://travis-ci.org/gprasant/express-sextant)

**Sextant** *n.*

  1. An astronomical instrument used at sea to determine latitude and longitude.
  2. An express utility to list all the routes an express app responds to.

# express-sextant

Rails sextant like library for express.js to check out route matching in express apps

## Installation

``` shell
$ npm install {package_name} --save
```

## Usage

In your express app, after you have created the express application, require {package_name}, passing in the app object. Thats it !

    var express = require("express");
    var app = express();

    require("{package_name}")(app);


Now, after your app has booted up, navigate to localhost:3000/routes to see the routes that your app supports.