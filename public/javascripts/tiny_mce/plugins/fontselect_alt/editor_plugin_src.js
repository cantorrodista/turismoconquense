/**
 * @author Choan Gálvez
 */
(function() {

var DOM = tinymce.DOM, each = tinymce.each;

tinymce.create('tinymce.plugins.FontselectAltPlugin', {

    
    getInfo : function() {
      return {
          longname :  'Fontselect Alt',
          author :    'Choan Gálvez',
          authorurl : 'http://choangalvez.nom.es',
          infourl :   'mailto:choan.galvez@gmail.com',
          version :   '0.1'
      };
    },


    init : function(ed, url) {
      var faces = {}, cnames = [], settings = {}, revsettings = {}, re = [], c = 0;
      faces = ed.getParam('theme_advanced_fonts', ed.theme.settings.theme_advanced_fonts, 'hash');
      cnames = tinymce.explode(ed.getParam('fontselect_alt_classes', 'font-andale,font-arial,font-arial-black,font-book-antiqua,font-comic-sans,font-courier,font-georgia,font-helvetica,font-impact,font-symbol,font-tahoma,font-terminal,font-times-new-roman,font-trebuchet-ms,font-verdana,font-webdings,font-wingdings'));
      
      // configure
      each(faces, function(v, k) {
        settings[cnames[c]] = v;
        revsettings[v] = cnames[c];
        re.push(cnames[c]);
        c += 1;
      });
      
      re = new RegExp('(^|\\s+)(' + re.join('|') + ')(\\s+|$)');
      
      function convertToFonts(no) {
        var nl, n, i;
        nl = DOM.select('span', no);
        for (i = nl.length - 1; i >= 0; i--) {
          n = nl[i];
          if (n.className) {
            m = n.className.match(re);
            if (m) {
              DOM.setStyle(n, 'font-family', settings[m[2]]);
            }
          }
        }
      }
      
      
      ed.onSetContent.add(function(ed, o) {
        convertToFonts(ed.getBody());
      });
                  			
			ed.onPreProcess.add(function(ed, o) {
			  var col, i, ff, cn;
			  
			  if (o.get) {
			    col = DOM.select('font', o.node);
			    for (i = col.length - 1; i >= 0; i--) {
			      ff = DOM.getAttrib(col[i], 'face');
			      if (ff) {
			        cn = revsettings[ff];
              DOM.setAttrib(col[i], 'face', '');
			        DOM.addClass(col[i], cn);
			      }
			    }
			  }
			});
  		
    }
    

});

tinymce.PluginManager.add('fontselect_alt', tinymce.plugins.FontselectAltPlugin);

})();