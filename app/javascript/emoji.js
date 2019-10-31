import $ from 'jquery';
import EmojiButton from 'emoji-button';

const Emoji = () => {
  $(document).on('turbolinks:load', event => {
    if ($(".blog_summary").length > 0) {
      initButton();
    }
  });

  $(document).on('click', '.emoji-btn', event => {
    event.preventDefault();
  });

  const initButton = () => {
    const $emojiButton = document.createElement("a");
    $emojiButton.className = "emoji-btn btn"
    const $emojiHolder = document.createElement("span");
    $emojiHolder.className = "emoji-icon"
    $emojiHolder.innerHTML = "<img src='/assets/images/smiley.png'/>"
    $emojiButton.append($emojiHolder);

    $(".blog_summary").append($emojiButton);
    const picker = new EmojiButton();

    picker.on('emoji', emoji => {
      console.log("Selected emoji")
      console.log(emoji)
      //var emojiString = "<span class=\"emoji\">" + emoji + "</span>"
      //console.log(emojiString)
      $(".blog_summary").find('input')[0].value += emoji;
    });

    $emojiButton.addEventListener('click', () => {
      picker.pickerVisible ? picker.hidePicker() : picker.showPicker($emojiButton);
    });
  }
}

export default Emoji;
