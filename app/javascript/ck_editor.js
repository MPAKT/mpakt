import $ from 'jquery';

const CkEditor = () => {

  $(document).on('turbolinks:load', event => {
    if ($('#blog_description').length === 0) {
      return;
    }

    console.log("Ck editor load")
    ClassicEditor.create( document.querySelector( '#blog_description' ), {
    	                    removePlugins: [ 'ImageToolbar', 'ImageCaption', 'ImageStyle', 'MediaEmbed' ],
    		                  image: {} })
                  .catch( error => {
                    console.error( error );
                  });

    $().hide();

  });
};

export default CkEditor;
