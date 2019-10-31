import $ from 'jquery';
import EmojiPicker from "rm-emoji-picker";

const Emoji = () => {
  $(document).on('turbolinks:load', event => {
    if ($(".blog_summary").length > 0) {
      initButton();
    }
  });

  $(document).on('click', '.emojis', event => {
    console.log("Clicked emojis")
  });

  /*$(document).on('click', '.btn', event => {
    console.log("Clicked button")
    //event.preventDefault();
  });*/

  const initButton = () => {
    const $emojiIcon = document.createElement("i");
    $emojiIcon.className = "emojis btn fa fa-smile-o"
    //$emojiIcon.innerHTML = "Emojis"
    $(".blog_summary").append($emojiIcon);

    const $picker = new EmojiPicker({
      sheets: {
        apple   : '/assets/sheets/sheet_apple_64_indexed_128.png',
        google  : '/assets/sheets/sheet_google_64_indexed_128.png',
        twitter : '/assets/sheets/sheet_twitter_64_indexed_128.png',
        emojione: '/assets/sheets/sheet_emojione_64_indexed_128.png'
      },
      onOpen : () => {
        console.log("EmojiPicker opened")
      }
    });

    const container = $('.blog_summary')[0]; // $(".blog_summary")
    const editable  = $(".blog_summary").find("input")[0]

    $picker.listenOn($emojiIcon, container, editable);

    /*picker.on('emoji', emoji => {
      console.log("Selected emoji")
      console.log(emoji)
      $(".blog_summary").find('input')[0].value += emoji;
    });

    $emojiButton.addEventListener('click', () => {
      picker.pickerVisible ? picker.hidePicker() : picker.showPicker($emojiButton);
    });*/
  }
}

export default Emoji;
