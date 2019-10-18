import $ from 'jquery';

const CkEditor = () => {

  $(document).on('turbolinks:load', event => {
    if ($('#blog_description').length === 0) {
      return;
    }

    var editors = $(".ck-editor")
    if (editors.length > 0) {
      return;
    }
    ClassicEditor.create( document.querySelector( '#blog_description' ), {
    	                    removePlugins: [ 'ImageToolbar', 'ImageCaption', 'ImageStyle', 'MediaEmbed' ],
    	                    // Explicit toolbar feature list, so we can exclude picture upload and media embed
    	                    toolbar: [ 'bold', 'italic', 'bulletedList', 'numberedList', 'blockQuote', 'heading', 'link' ],
    		                  image: {} })
                  .catch( error => {
                    console.error( error );
                  });

    $().hide();

  });
};

export default CkEditor;
