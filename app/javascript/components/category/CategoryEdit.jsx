import React, { useState } from 'react'

function CategoryEdit({ category, updateCategory, setIsEditing }) {
  const [name, setName] = useState(category.name)

  const handleSubmit = (event) => {
    event.preventDefault()

    fetch(`/admin/categories/${category.id}.json`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      },
      body: JSON.stringify({ name })
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
        setIsEditing(false)
        updateCategory(data)
      })
      .catch(error => console.log(error))
  }

  const handleCancel = () => {
    setIsEditing(false)
    setName(category.name)
  }

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <input type="text" className="form-control" value={name} onChange={(event) => setName(event.target.value)} />
      </div>
      <div className="d-flex justify-content-between align-items-center">
        <button type="submit" className="btn btn-primary">Save</button>
        <button type="button" className="btn btn-secondary" onClick={handleCancel}>Cancel</button>
      </div>
    </form>
  )
}

export default CategoryEdit
