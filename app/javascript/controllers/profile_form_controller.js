import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "avatarForm", "submit"]

  connect() {
    this.fillFormValues();
    this.submitTarget.setAttribute("form", this.formTarget.id);
  }

  fillFormValues() {
    let values = JSON.parse(this.formTarget.getAttribute("data-form-values"));
    for (const [key, value] of Object.entries(values)) {
      let input = this.formTarget.querySelector(`input[name*='${key}']`)
      input.value = value;
    }
  }

  avatarSubmit() {
    this.avatarFormTarget.requestSubmit();
  }
}
