import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add(event) {
    const movieId = this.element.dataset.movieId
    const categoryId = event.target.dataset.categoryId

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/admin/movies/${movieId}/categories/${categoryId}/add_category`, {
      method: "POST",
      headers: {
        'X-CSRF-Token': csrfToken,
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        event.target.dataset.action = "click->movie-category#delete"
        event.target.classList.remove("admin-tag-enabled")
        event.target.classList.add("admin-tag-disabled")
      }
    });
  }

  delete(event) {
    const movieId = this.element.dataset.movieId
    const categoryId = event.target.dataset.categoryId

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/admin/movies/${movieId}/categories/${categoryId}/remove_category`, {
      method: "DELETE",
      headers: {
        'X-CSRF-Token': csrfToken,
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        event.target.dataset.action = "click->movie-category#add"
        event.target.classList.remove("admin-tag-disabled")
        event.target.classList.add("admin-tag-enabled")
      }
    });
  }
}
