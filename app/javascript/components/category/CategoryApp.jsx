import React, { useState, useEffect } from 'react'
import CategoryList from './CategoryList';
import CategoryCreate from './CategoryCreate';
import FlashMessage from '../shared/FlashMessage';

function CategoryApp() {
  const [categories, setCategories] = useState([]);
  const [flash, setFlash] = useState([]);

  useEffect(() => {
    fetch('/admin/categories.json')
      .then(response => response.json())
      .then(data => setCategories(data));
  }, [])

  const addCategory = (category) => {
    setCategories([category,...categories])
  }

  const deleteCategory = (categoryId) => {
    setCategories(categories.filter(category => category.id !== categoryId))
  }

  const updateCategory = (category) => {
    setCategories(categories.map(c => c.id === category.id ? category : c))
  }

  return (
    <>
      <FlashMessage flash={flash} />

      <div className="jumbotron text-center mb-3">
        <h1>Categories</h1>

        <h5>
          <span id="category_counter">{categories.length} </span>
          categories available
        </h5>
      </div>

      <div className="container text-center">
        <div id="new_category" className="mb-3">
          <CategoryCreate addCategory={addCategory}
                          setFlash={setFlash} />
        </div>

        <CategoryList categories={categories}
                      deleteCategory={deleteCategory}
                      updateCategory={updateCategory}/>
      </div>
    </>
  )
}

export default CategoryApp
