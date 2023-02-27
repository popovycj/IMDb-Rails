import React, { useState } from 'react';

const CategoryCreate = ({ addCategory, setFlash }) => {
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
        addCategory(data.category)
        setFlash(data.flashes[0])
        setName('')
      })
      .catch(error => console.log(error))
  }

  return (
    <form onSubmit={handleSubmit} className="form-inline">
      <div className="form-group mx-sm-3 mb-2">
        <input type="text" className="form-control" placeholder="Name" value={name} onChange={(event) => setName(event.target.value)} />
      </div>
      <button type="submit" className="btn btn-primary mb-2">Create</button>
    </form>
  )
}

export default CategoryCreate
