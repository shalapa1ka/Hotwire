import {Controller} from "@hotwired/stimulus"
import {patch} from "@rails/request.js"

export default class extends Controller {
    static targets = ['image', 'title', 'save']
    static classes = ['loading']
    static values = {
        id: String
    }


    connect() {
        const title = document.createElement('p')
        title.textContent = this.imageTarget.alt
        title.contentEditable = true
        title.dataset.imagesTarget = 'title'
        title.dataset.action = 'click->images#editTitle'
        this.element.append(title)
    }

    editTitle(e) {
        if (!this.hasSaveTarget) {
            const btn = document.createElement('button')
            btn.textContent = 'Save'
            btn.dataset.imagesTarget = 'save'
            btn.classList = 'btn btn-primary btn-sm'
            btn.dataset.action = 'click->images#saveTitle'
            e.target.insertAdjacentElement('afterend', btn)
        }
    }

    async saveTitle(e) {
        e.preventDefault()
        e.target.classList.add(this.loadingClass)

        await this.doPatch(`api/images/${this.idValue}`, JSON.stringify({
            image: {
                title: this.titleTarget.innerText
            }
        }))

        e.target.remove()
    }

    getUrl(e) {
        navigator.clipboard.writeText(e.target.src)
        this.dispatch('copy', {detail: {content: 'Image url has been copied!'}})
    }

    titleTargetConnected(e) {
        console.log(e)
    }

    await

    async doPatch(url, body) {
        const response = await patch(url, {body})

        if (!response.ok) {
            raise('Something went wrong')
        }
    }
}