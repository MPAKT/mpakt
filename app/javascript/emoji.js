import $ from 'jquery';
import EmojiButton from 'emoji-button';

const Emoji = () => {
  $(document).on('turbolinks:load', event => {
    if ($("#post_content").length > 0) {
      initButton("#post_content");
    }
    if ($("#topic_content").length > 0) {
      initButton("#topic_content");
    }
  });

  $(document).on('click', '.emoji-btn', event => {
    event.preventDefault();
  });

  const initButton = emojiable => {
    const $emojiButton = document.createElement("a");
    $emojiButton.className = "emoji-btn btn"
    const $emojiHolder = document.createElement("span");
    $emojiHolder.className = "emoji-icon"
    $emojiHolder.innerHTML = "<img src='/assets/images/smiley.png'/>"
    $emojiButton.append($emojiHolder);

    emojiable.append($emojiButton);
    const picker = new EmojiButton();

    picker.on('emoji', emoji => {
      console.log("Selected emoji")
      console.log(emoji)

      emojiable.find('textarea')[0].value += emoji;
    });

    $emojiButton.addEventListener('click', () => {
      picker.pickerVisible ? picker.hidePicker() : picker.showPicker($emojiButton);
    });
  }
}

export default Emoji;
