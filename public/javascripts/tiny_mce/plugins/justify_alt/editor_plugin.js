
(function(){var ALIGN_CLASSES='left=aleft;center=acenter;right=aright';function alignToClass(node){var el,c=0,align;if(node.nodeType==1){if(node.style&&node.style.textAlign){align=node.style.textAlign;node.removeAttribute('mce_style');node.style.textAlign='';node.className+=(node.className?' ':'')+ALIGN_CLASSES[align];}
while(el=node.childNodes[c++]){alignToClass(el);}}
return node;}
function classToAlign(node){var m,el,c=0;if(!classToAlign.re){var a=[];classToAlign.conf={};for(var i in ALIGN_CLASSES){a.push(ALIGN_CLASSES[i]);classToAlign.conf[ALIGN_CLASSES[i]]=i;}
classToAlign.re=new RegExp('(^|\\s+)('+a.join('|')+')(\\s+|$)');}
if(node.nodeType==1){m=node.className.match(classToAlign.re);if(m){node.style.textAlign=classToAlign.conf[m[2]];node.className=node.className.replace(new RegExp('(^|\\s+)'+m[2]+'(\\s+|$)'),'');}
while(el=node.childNodes[c++]){classToAlign(el);}}}
tinymce.PluginManager.requireLangPack('justify_alt');tinymce.create('tinymce.plugins.JustifyAltPlugin',{getInfo:function(){return{longname:'Justify Alt',author:'Choan Gálvez',authorurl:'http://choangalvez.nom.es',infourl:'mailto:choan.galvez@gmail.com',version:'0.2'};},init:function(ed,url){ALIGN_CLASSES=ed.getParam('justify_alt_classnames',ALIGN_CLASSES,'hash');ed.addCommand('mceJustifyAlt',function(b,value){var se=ed.selection,n=se.getNode(),nn=n.nodeName,dom=ed.dom,bl;if(nn=='IMG'){return;}
else{ed.execCommand('mceJustify',b,value);}});for(var i=0,aligns=['left','center','right'],c=aligns.length;i<c;i++){ed.addButton('justify'+aligns[i],{title:'justify_alt.justify'+aligns[i]+'_desc',cmd:'mceJustifyAlt',value:aligns[i]});}
ed.onSetContent.add(function(ed,o){classToAlign(ed.getBody());});ed.onPreProcess.add(function(ed,o){if(o.get){alignToClass(o.node);}});}});tinymce.PluginManager.add('justify_alt',tinymce.plugins.JustifyAltPlugin);})();