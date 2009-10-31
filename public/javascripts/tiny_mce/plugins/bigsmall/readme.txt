# Plugin: Big/Small

The Big/Small plugin adds a configurable font size selector managed by classnames. 
  
This plugin was developed by Choan Gálvez in April, 2008. Paid by The Cocktail.


## Version History
  0.1 by choan


## Installation

* Copy the `bigsmall` directory to the plugins directory of TinyMCE.
* Add plugin to TinyMCE plugin option list.
* Add `bigsmall` buttons to button list.
* Use the option `bigsmall_classes`, in TinyMCE hash format, to set the titles and classnames used in the selector and the output

## Initialization Example
tinyMCE.init({
    theme : "advanced",
    // ...
    plugins : "bigsmall,...",
    theme_advanced_buttons : "...,bigsmall,...",
    bigsmall_classes : "X Large=large;Large=large;Default=default;Small=small"
});
