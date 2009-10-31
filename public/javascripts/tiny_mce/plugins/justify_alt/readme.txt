# Plugin: Justify Alt

The Justify Alt plugin converts the style information added by the justify buttons of the advanced theme to class attributes.

In addition, avoids the use of the justify buttons to float images.
  
This plugin was developed by Choan Gálvez in April, 2008. Paid by The Cocktail.


## Version History
  0.1 by choan
  0.2 by choan
    - fixed transformation when setting content


## Installation

* Copy the `justify_alt` directory to the plugins directory of TinyMCE.
* Add plugin to TinyMCE plugin option list.
* Use the option `justify_alt_classnames` to set the relationship between classnames and alignments.

## Initialization Example
tinyMCE.init({
    theme : "advanced",
    // ...
    plugins : "justify_alt,...",
  	justify_alt_classnames : 'left=aleft;center=acenter;right=aright'
});
