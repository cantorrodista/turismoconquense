(function() {

var each = tinymce.each;

tinymce.PluginManager.requireLangPack('bigsmall');

tinymce.create('tinymce.plugins.BigSmallPlugin', {

    
    getInfo : function() {
      return {
          longname :  'Big/Small plugin',
          author :    'Choan C. Gálvez',
          authorurl : 'http://choangalvez.nom.es',
          infourl :   'mailto:choan.galvez@gmail.com',
          version :   '0.1'
      };
    },


    init : function(ed, url) {
      var t = this, extend = tinymce.extend, s;
      t.editor = ed;
      
      t.settings = s = extend({
        bigsmall_classes : 'X-Large=xlarge;Large=large;Default=default;Small=small'
      }, ed.settings);
      
      ed.onNodeChange.add(t._nodeChanged, t);
      
    },
    
    createControl : function(n, cm) {
      if (n == 'bigsmall') {
        var t = this, ed = t.editor;
        var c = cm.createListBox(n, {
          title : 'bigsmall.fontsize',
          onselect : function(v) {
            if (v == 'default') {
              ed.execCommand('mceSetStyleInfo', 0, {command : 'removeformat'});
              c.select();
              return false;
            }
            else {
              ed.execCommand('mceSetCSSClass', 0, v);
            }
          }
        });
        if (c) {
          each(ed.getParam('bigsmall_classes', t.settings.big_small_classes, 'hash'), function(v, k) {
            c.add(ed.translate(k), v, { 'class': v } );
          });
        }
        return c;
      }
    },
    
    _nodeChanged : function(ed, cm, n, co) {
      var c;
      
      if (c = cm.get('bigsmall')) {
        if (n.className) {
          c.select(n.className);
        } else
          c.select();
      }
    }

});

tinymce.PluginManager.add('bigsmall', tinymce.plugins.BigSmallPlugin);

})();