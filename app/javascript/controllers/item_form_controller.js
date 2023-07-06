import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "titleInput", "urlInput", "descriptionInput", "priceInput", "urlDescriptionEmpty", "urlDescriptionFilled"]

  connect() {
    this.urlInputTarget.addEventListener("input", () => {
      this.urlInput(this.urlInputTarget.value);
    });

    this.urlInput(this.urlInputTarget.value);

    if (this.formTarget.querySelector("input[type='radio'][name='item[wishlist_id]']:checked") == null) {
      this.formTarget.querySelector("input[type='radio'][name='item[wishlist_id]']").setAttribute("checked", "checked");
    }
  }

  urlInput(value) {
    if (value == "") {
      this.titleInputTarget.removeAttribute("placeholder");
      this.descriptionInputTarget.removeAttribute("placeholder");
      this.priceInputTarget.removeAttribute("placeholder");
      this.urlDescriptionEmptyTarget.classList.remove("hidden");
      this.urlDescriptionFilledTarget.classList.add("hidden");
    }
    else {
      this.titleInputTarget.setAttribute("placeholder", "\u2728 Will be parsed automatically");
      this.descriptionInputTarget.setAttribute("placeholder", "\u2728 Will be parsed automatically");
      this.priceInputTarget.setAttribute("placeholder", "\u2728");
      this.urlDescriptionEmptyTarget.classList.add("hidden");
      this.urlDescriptionFilledTarget.classList.remove("hidden");
    }
  }
}
