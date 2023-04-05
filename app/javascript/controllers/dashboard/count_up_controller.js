import { Controller } from "@hotwired/stimulus"
import { CountUp } from 'countup.js';

// Connects to data-controller="dashboard--count-up"
export default class extends Controller {
  static targets = [ "countValue" ]

  connect() {
    const countUp = new CountUp(this.countValueTarget, this.countValueTarget.innerText, { duration: 1.5 });
    countUp.start();
  }
}
