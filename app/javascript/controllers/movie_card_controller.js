import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['star']

  connect() {
    this.userIdPromise = this.loadUserId()
  }

  async loadUserId() {
    return fetch("/user_id")
      .then(response => response.json())
      .then(data => {
        this.userId = data.user_id
        return data.user_id
      })
      .catch(error => {
        // Handle the error
      })
  }

  rateMovie(event) {
    const selectedRating = event.currentTarget.dataset.rating
    this.starTargets.forEach((star, index) => {
      if (index >= selectedRating) {
        star.classList.remove('full-star')
        star.classList.add('empty-star')
      } else {
        star.classList.remove('empty-star')
        star.classList.add('full-star')
      }
    })

    console.log(`requesting backend... with id: ${this.element.id} and rating: ${selectedRating}`)

    fetch(`/movies/${this.data.get('id')}/rate`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        score: rating,
        movie_id: this.element.id,
        user_id: this.loadUserId()
      })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Request failed");
      }
      return response.json();
    })
    .then(data => {
      console.log(data);  // Handle the response data
    })
    .catch(error => {
      console.error(error);  // Handle the error
    });
  }
}
