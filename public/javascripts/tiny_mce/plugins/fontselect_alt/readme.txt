# Plugin: Fontselect Alt

The Fontselect Alt plugin converts the style information added by the `fontselect` selector in the advanced theme to class attributes. 
  
This plugin was developed by Choan Gálvez in April, 2008. Paid by The Cocktail.


## Version History
  0.1 by choan


## Installation

* Copy the `fontselect_alt` directory to the plugins directory of TinyMCE.
* Add plugin to TinyMCE plugin option list.
* Use the option `fontselect_alt_classes` to establish the relationship between the titles and classnames used in the selector and the output

## Initialization Example
tinyMCE.init({
    theme : "advanced",
    // ...
    plugins : "fontselect_alt,...",
    theme_advanced_fonts : "Arial=arial,helvetica,sans-serif;Courier New=courier new,courier,monospace;",
    // follows the same order than theme_advanced_fonts
    fontselect_alt_classes: 'font-arial,monospace'
});
