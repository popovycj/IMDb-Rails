import React, { useState, useEffect } from 'react'
import CategoryList from './CategoryList';
import CategoryForm from './CategoryForm';

function CategoryApp() {
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    fetch('/admin/categories.json')
      .then(response => response.json())
      .then(data => setCategories(data));
  }, [])

  const addCategory = (category) => {
    setCategories([category,...categories])
  }

  return (
    <div>
      <div className="jumbotron text-center mb-3">
        <h1>Categories</h1>

        <h5>
          <span id="category_counter">{categories.length} </span>
          categories available
        </h5>
      </div>

      <div className="container text-center">
        <div id="new_category" className="mb-3">
          <CategoryForm addCategory={addCategory} />
        </div>

        <CategoryList categories={categories}/>
      </div>
    </div>
  )
}

export default CategoryApp
