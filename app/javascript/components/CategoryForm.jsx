import React, { useState } from 'react';

const CategoryForm = ({ addCategory }) => {
  const [name, setName] = useState('')

  const handleSubmit = (event) => {
    event.preventDefault()

    fetch('/admin/categories.json', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      },
      body: JSON.stringify({ name: name })
    })
      .then(response => {
        if (response.ok) {
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
        addCategory(data)
        setName('')
      })
      .catch(error => console.log(error))
  }

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" placeholder="Name" value={name} onChange={(event) => setName(event.target.value)} />
      <button type="submit">Create</button>
    </form>
  )
}

export default CategoryForm
