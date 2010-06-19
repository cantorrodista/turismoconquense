/**
 * 
 * @author Choan Gálvez
 * @copyright TODO
 */
(function() {

tinymce.PluginManager.requireLangPack('simpleimage');

tinymce.create('tinymce.plugins.SimpleImagePlugin', {

    
    getInfo : function() {
      return {
          longname :  'Simple Image',
          author :    'Choan Gálvez',
          authorurl : 'http://choangalvez.nom.es',
          infourl :   'mailto:choan.galvez@gmail.com',
          version :   '0.2'
      };
    },


    init : function(ed, url) {
      
      ed.addCommand('mceSimpleImage', function(b, value) {
        var defSrc = '';
        
        // flash placeholder
  			if (ed.dom.getAttrib(ed.selection.getNode(), 'class').indexOf('mceItem') != -1)
  				return;

        if (ed.selection.getNode().nodeName == 'IMG') {
          defSrc = ed.dom.getAttrib(ed.selection.getNode(), 'src');
        }

        var url = prompt(ed.translate('simpleimage.image_url'), defSrc);

        if (url === '' || url === null) {          
          if (ed.selection.getNode().nodeName == 'IMG') {
            ed.dom.remove(ed.selection.getNode());
            ed.execCommand('mceRepaint');
          }
          return true;
        }
        
    		// Fixes crash in Safari
    		if (tinymce.isWebKit)
    			ed.getWin().focus();
    		
        var attrs = { src: url, alt: '' };
        var el = ed.selection.getNode();
        if (el.nodeName == 'IMG') {
          ed.dom.setAttribs(el, attrs);
        }
        else {
    			ed.execCommand('mceInsertContent', false, '<img id="__mce_tmp" src="javascript:;" />', {skip_undo : 1});
    			ed.dom.setAttribs('__mce_tmp', attrs);
    			ed.dom.setAttrib('__mce_tmp', 'id', '');
    			ed.undoManager.add();
    		}
      });

      ed.addButton('image', {
				title : 'simpleimage.image',
				cmd : 'mceSimpleImage'
			});

			ed.addCommand('mceSimpleImage_align', function(b, value) {
			  var el = ed.selection.getNode();
			  // las clases corresponden a las utilizadas en the shaker
			  var classes = { left: 'imgizqda', right: 'imgdcha', center: 'imgcen' };
			  if (ed.dom.hasClass(el, classes[value])) {
			    ed.dom.removeClass(el, classes[value]);
			  }
			  else {
  			  for (var c in classes) {
  			    ed.dom.removeClass(el, classes[c]);
  			  }
  			  ed.dom.addClass(el, classes[value]);
			  }
			});
			
			for (var i = 0, aligns = ['left', 'center', 'right'], c = aligns.length; i < c; i++) {
        ed.addButton('image_align_' + aligns[i], {
  				title : 'simpleimage.image_align_' + aligns[i],
  				cmd : 'mceSimpleImage_align',
  				image : url + '/images/img_' + aligns[i] + '.gif',
  				value: aligns[i]
  			});
			}
  		
  		ed.onNodeChange.add(function(ed, cm, n) {
        for (var i = 0, aligns = [ 'left', 'center', 'right' ]; i < aligns.length; i++) {
          cm.setDisabled('image_align_' + aligns[i], n.nodeName != 'IMG' || ed.dom.getAttrib(n, 'class').indexOf('mceItem') != -1);
        }
        if (n.nodeName != 'IMG')
  				return;
        cm.setActive('image_align_left', ed.dom.hasClass(n, 'imgizqda'));
        cm.setActive('image_align_center', ed.dom.hasClass(n, 'imgcen'));
        cm.setActive('image_align_right',  ed.dom.hasClass(n, 'imgdcha'));
			});
  					
    }
    

});

tinymce.PluginManager.add('simpleimage', tinymce.plugins.SimpleImagePlugin);

})();