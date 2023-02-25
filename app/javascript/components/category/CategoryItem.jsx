import React from 'react'

function CategoryItem({ category }) {
  return (
    <div className="card card-body">
      <p className="card-text">
        <strong>Id:</strong> {category.id}<br/>
        <strong>Name:</strong> {category.name}
      </p>

      <div className="d-flex justify-content-between align-items-center">
        <button type="button" className="btn btn-primary">Edit</button>
        <button type="button" className="btn btn-danger">Delete</button>
      </div>
    </div>
  )
}

export default CategoryItem
