import {Controller} from "@hotwired/stimulus";


export default class extends Controller {
    static targets = ['bookmarks']

    static values = {
        admin: Boolean
    }

    bookmarkTargetConnected(e) {
        const actions = e.querySelector('.js-actions')

        if(actions && !this.adminValue) {
            actions.remove()
        }
    }

}