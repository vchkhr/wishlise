import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.fillFormErrors();
  }

  fillFormErrors() {
    let errors = JSON.parse(this.formTarget.getAttribute("data-form-errors"));
    for (const [key, value] of Object.entries(errors)) {
      let feedback = document.createElement("div");
      feedback.innerHTML = value.map(error => error.charAt(0).toUpperCase() + error.slice(1)).join('. ') + ".";
      feedback.classList.add("invalid-feedback");

      let input = this.formTarget.querySelector(`input[name*='${key}']`);
      input.classList.add("is-invalid");
      input.after(feedback);
    }
  }
}
