import React, { useState, useEffect } from 'react'

const FlashMessage = ({ flash }) => {
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    if (flash.length > 0) {
      setIsVisible(true)
      const timeoutId = setTimeout(() => setIsVisible(false), 2000)
      return () => clearTimeout(timeoutId)
    }
  }, [flash])

  if (!isVisible) {
    return null
  }

  const defineClass = (type) => {
    const classes = {
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
      success: 'alert-success'
    }
    return classes[type] || classes.success;
  }

  const [type, message] = flash

  return (
    <div className={`alert ${defineClass(type)} mb-3`}>
      {message}
    </div>
  )
}

export default FlashMessage
