import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "avatarForm", "avatarInput", "submit"]

  connect() {
    this.submitTarget.setAttribute("form", this.formTarget.id);
    this.avatarInputTarget.type = "file";
    this.avatarInputTarget.value = "";
  }

  avatarSubmit() {
    this.avatarFormTarget.requestSubmit();
  }
}
