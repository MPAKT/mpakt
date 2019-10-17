import $ from 'jquery';

const CkEditor = () => {

  $(document).on('turbolinks:load', event => {
    if ($('#blog_description').length === 0) {
      return;
    }

    console.log("Ck editor load")
    ClassicEditor.create( document.querySelector( '#blog_description' ) )
                 .catch( error => {
                    console.error( error );
                 });
  });
};

export default CkEditor;
