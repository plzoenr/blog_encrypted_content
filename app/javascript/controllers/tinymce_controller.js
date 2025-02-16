import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea"];

  connect() {
    tinymce.remove();
    tinymce.init({
      target: this.textareaTarget,
      menubar: false,
      plugins: ['image'],
      toolbar: 'undo redo | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | image',
    });
  }

  disconnect() {
    tinymce.remove(editor);
  }
}
