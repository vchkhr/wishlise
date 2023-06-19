import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "nameInput", "nameBirthday"]

  connect() {
    this.selectPublicity();

    this.nameBirthdayTarget.addEventListener("click", () => {
      this.nameInputTarget.value = this.nameBirthdayTarget.innerHTML;
    });

    this.formTarget.addEventListener("change", (event) => {
      this.selectPublicity();
    });
  }

  selectPublicity() {
    document.querySelectorAll(".wishlist-publicity-text").forEach((div) => {
      div.classList.add("hidden");
    });

    let publicity = this.formTarget.querySelector("input[name*=publicity]:checked").value;
    document.querySelector(`#wishlist_publicity_text_${publicity}`).classList.remove("hidden");
  }
}
