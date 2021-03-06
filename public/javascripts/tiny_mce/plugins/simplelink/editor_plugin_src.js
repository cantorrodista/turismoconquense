/**
 * @author Choan Gálvez
 */
(function() {

tinymce.PluginManager.requireLangPack('simplelink');

tinymce.create('tinymce.plugins.SimpleLinkPlugin', {

    
    getInfo : function() {
      return {
          longname :  'Simple Link',
          author :    'Choan Gálvez',
          authorurl : 'http://choangalvez.nom.es',
          infourl :   'mailto:choan.galvez@gmail.com',
          version :   '0.1'
      };
    },


    init : function(ed, url) {
      
      ed.addCommand('mceSimpleLink', function(b, value) {
        var e, href;
        if (e = ed.dom.getParent(ed.selection.getNode(), 'A')) {
    			href = ed.dom.getAttrib(e, 'href');
    		}
        var url = window.prompt(ed.translate('simplelink.insert_url'), href || '');
        if (url) {
          ed.execCommand('mceInsertLink', 0, url);
        }
      });

      ed.addButton('link', {
        title : 'simplelink.link',
				cmd : 'mceSimpleLink'
			});
  					
    }
    

});

tinymce.PluginManager.add('simplelink', tinymce.plugins.SimpleLinkPlugin);

})();