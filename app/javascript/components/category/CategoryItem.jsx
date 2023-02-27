import React, { useState } from 'react'
import CategoryEdit from './CategoryEdit';

function CategoryItem({ category, deleteCategory, updateCategory }) {
  const [isEditing, setIsEditing] = useState(false)

  const handleDelete = () => {
    fetch(`/admin/categories/${category.id}.json`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
      .then(response => {
        if (response.ok) {
          deleteCategory(category.id)
        } else if (response.status === 422) {
          throw new Error('Unprocessable Entity')
        } else if (response.status === 401) {
          throw new Error('Unauthorized')
        } else {
          throw new Error('Something went wrong')
        }
      })
      .catch(error => console.log(error))
  }

  const handleEdit = () => {
    setIsEditing(true)
  }

  if (isEditing) {
    return (
      <CategoryEdit category={category} updateCategory={updateCategory} setIsEditing={setIsEditing} />
    )
  } else {
    return (
      <div className="card card-body">
        <p className="card-text">
          <strong>Id:</strong> {category.id}<br/>
          <strong>Name:</strong> {category.name}
        </p>

        <div className="d-flex justify-content-between align-items-center">
          <button type="button" className="btn btn-primary" onClick={handleEdit}>Edit</button>
          <button type="button" className="btn btn-danger" onClick={handleDelete}>Delete</button>
        </div>
      </div>
    )
  }
}

export default CategoryItem
