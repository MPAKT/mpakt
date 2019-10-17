
//<![CDATA[
(function() {
  if (typeof CKEDITOR != 'undefined') {
    if (CKEDITOR.instances['blog_description']) { CKEDITOR.instances['blog_description'].destroy(); }
    CKEDITOR.replace('blog_description', {"toolbar":"mini","customConfig":"/assets/ckeditor/config-6c18aba38808e9ebfa4e474fb0035158f6676e4b977b4cbbe1f27b3609cb7807.js"});
  } else {
    console.log("CKEDITOR undefined")
  }
})();
//]]>
