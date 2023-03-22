import {Controller} from "@hotwired/stimulus"
import {patch} from "@rails/request.js"
import Sortable from "sortablejs"

export default class extends Controller {
    static targets = ["position"]

    connect() {
        this.sortable = new Sortable(this.element, {
            handle: ".handler",
            animation: 150, onEnd: async (event) => {
                try {
                    this.disable();
                    const response = await patch('/notes/reorder', {
                        body: JSON.stringify({
                            old_position: event.oldIndex + 1, new_position: event.newIndex + 1
                        })
                    });
                    if (!response.ok) {
                        throw new Error(`Something went wrong ${response.statusCode}`)
                    }

                    this.updatePositions();

                } catch (error) {
                    console.error(error);
                } finally {
                    this.enable();
                }
            }
        });
    }

    disable() {
        this.sortable.option("disabled", true);
        this.sortable.el.classList.add("opacity-50");
    }

    enable() {
        this.sortable.option("disabled", false);
        this.sortable.el.classList.remove("opacity-50");
    }

    updatePositions() {
        this.positionTargets.forEach((position, index) => {
            position.innerText = index + 1;
        });
    }
}