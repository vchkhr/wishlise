import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "avatarForm", "submit"]

  connect() {
    this.submitTarget.setAttribute("form", this.formTarget.id);
  }

  avatarSubmit() {
    this.avatarFormTarget.requestSubmit();
  }
}
