import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['star', 'user_rating', 'average_rating', 'reviews_count']

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

    fetch('/api/ratings/update_or_create', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({
        movie_id: this.data.get('movie-id'),
        score: selectedRating
      })
    })
    .then(response => {
      if (response.status === 200) {
        return response.json()
      } else if (response.status === 422) {
        throw new Error('Unprocessable Entity')
      } else if (response.status === 401) {
        throw new Error('Unauthorized')
      } else {
        throw new Error('Something went wrong')
      }
    })
    .then(data => {
      this.user_ratingTarget.innerText = data.user_rating
      this.average_ratingTarget.innerText = data.average_rating
      this.reviews_countTarget.innerText = data.reviews_count
    })
    .catch(error => {
      console.error(error)
    })
  }

  deleteRating() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch('/api/ratings/', {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': csrfToken,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        movie_id: this.data.get('movie-id'),
      })
    })
    .then(response => {
      if (response.status === 200) {
        return response.json()
      } else if (response.status === 422) {
        throw new Error('Unprocessable Entity')
      } else if (response.status === 401) {
        throw new Error('Unauthorized')
      } else if (response.status === 404) {
        throw new Error('Not found')
      } else {
        throw new Error('Something went wrong')
      }
    })
    .then(data => {
      this.user_ratingTarget.innerText = "Not graded yet"
      this.average_ratingTarget.innerText = data.average_rating
      this.reviews_countTarget.innerText = data.reviews_count

      this.starTargets.forEach(function(starTarget) {
        starTarget.classList.remove("full-star");
        starTarget.classList.add("empty-star");
      });
    })
    .catch(error => {
      console.error(error);
    });
  }
}
