import { Application, Controller } from "@hotwired/stimulus"
import React from "react"
import { createRoot } from "react-dom/client"
import CategoryApp from "../components/category/CategoryApp"

// Connects to data-controller="category"
export default class extends Controller {
  connect() {
    createRoot(this.element).render(<CategoryApp />)
  }
}
