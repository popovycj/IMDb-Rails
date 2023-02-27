import React, { useState, useEffect } from 'react'
import CategoryItem from './CategoryItem';


function CategoryList({ categories, deleteCategory, updateCategory }) {
  return (
    <div className="categories">
      {categories.map(category => (
        <CategoryItem key={category.id}
                      category={category}
                      deleteCategory={deleteCategory}
                      updateCategory={updateCategory}/>
      ))}
    </div>
  )
}

export default CategoryList
