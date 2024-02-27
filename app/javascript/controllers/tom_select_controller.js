import { Controller } from "@hotwired/stimulus"
import 'tom-select'
import TomSelect      from "tom-select"

// Connects to data-controller="ts--select"
export default class extends Controller {
  connect() {
    console.log('tom_select_controller connected')
    const selectInput = document.getElementById('select-products')
    if (selectInput) {
      new TomSelect(selectInput, {
        onItemAdd:function(){
          this.setTextboxValue('');
          this.refreshOptions();
        },
        persist: false
      })
    }
  }
}