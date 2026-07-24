// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import Alpine from "alpinejs"
window.Alpine = Alpine

window.copyTextToClipboard = async function(text) {
    if (!text) return false

    try {
        if (navigator.clipboard && window.isSecureContext) {
            await navigator.clipboard.writeText(text)
            return true
        }

        return window.fallbackCopyTextToClipboard(text)
    } catch (error) {
        return window.fallbackCopyTextToClipboard(text)
    }
}

window.fallbackCopyTextToClipboard = function(text) {
    const textArea = document.createElement('textarea')
    textArea.value = text
    textArea.setAttribute('readonly', '')
    textArea.style.position = 'fixed'
    textArea.style.opacity = '0'
    document.body.appendChild(textArea)
    textArea.focus()
    textArea.select()

    let copied = false

    try {
        copied = document.execCommand('copy')
    } catch (error) {
        copied = false
    }

    document.body.removeChild(textArea)
    return copied
}

document.addEventListener("DOMContentLoaded", function() {
    console.log('AlpineJS loaded')
    window.Alpine.start();
});