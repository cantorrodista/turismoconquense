# Plugin: Simple Image

The Simple Image plugin replaces the default TinyMCE dialog for images by a simple prompt and adds three alignment buttons to set the image position using CSS classes.

This plugin was developed by Choan Gálvez in April, 2008. Paid by The Cocktail.


## Version History
  0.1 by choan
  0.2 by choan
    - avoid edition of object placeholders


## Installation

* Copy the `simpleimage` directory to the plugins directory of TinyMCE.
* Add plugin to TinyMCE plugin option list.
* Add the buttons to a toolbar
* Currently the class names are hardcoded in the plugin as `{ left: 'imgizqda', right: 'imgdcha', center: 'imgcen' }`

## Initialization Example
tinyMCE.init({
    theme : "advanced",
    // ...
    plugins : "simpleimage,...",
    theme_advanced_buttons1: "image,image_align_left,image_align_center,image_align_right"
});
