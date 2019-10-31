import $ from 'jquery';
import EmojiButton from 'emoji-button';

const Emoji = () => {
  $(document).on('turbolinks:load', event => {
    if ($(".blog_summary").length > 0) {
      initButton();
    }
  });

  $(document).on('click', '.emojis', event => {
    event.preventDefault();
    console.log("Clicked emojis")
  });

  const initButton = () => {
    const $emojiButton = document.createElement("button");
    $emojiButton.className = "emojis btn"
    $emojiButton.innerHTML = "Emojis"
    $(".blog_summary").append($emojiButton);
    const picker = new EmojiButton();

    picker.on('emoji', emoji => {
      document.querySelector('input').value += emoji;
    });

    $emojiButton.addEventListener('click', () => {
      picker.pickerVisible ? picker.hidePicker() : picker.showPicker($emojiButton);
    });
  }
}

export default Emoji;
