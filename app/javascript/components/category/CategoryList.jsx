import React, { useState, useEffect } from 'react'
import CategoryItem from './CategoryItem';


function CategoryList({ categories }) {
  return (
    <div className="categories">
      {categories.map(category => (
        <CategoryItem key={category.id} category={category} />
      ))}
    </div>
  )
}

export default CategoryList
