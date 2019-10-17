import $ from 'jquery';

const CkEditor = () => {

  $(document).on('turbolinks:load', event => {
    if ($('#blog_description').length === 0) {
      return;
    }

    console.log("Ck editor load")
    if (typeof CKEDITOR != 'undefined') {
      if (CKEDITOR.instances['blog_description']) { CKEDITOR.instances['blog_description'].destroy(); }
      CKEDITOR.replace('blog_description', {"toolbar":"mini"});
    } else {
      console.log("CKEDITOR undefined")
    }
  });
};

export default CkEditor;
