import $ from 'jquery';

const Inline = () => {

  $(document).on('click', '.btn', event => {
    console.log(event.target)
  });
};

export default Inline;
