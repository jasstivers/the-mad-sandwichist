import { Controller } from '@hotwired/stimulus';
import TomSelect from 'tom-select';
export default class extends Controller {
  static values = {
    data: Array,
  };
  connect() {
    new TomSelect(this.element, {
      valueField: 'id',
      searchField: 'name',
      options: this.dataValue,
      render: {
        option: function (data, escape) {
          return `<div class="m-1 p-1 border rounded">
                <p class="name">${escape(data.name)}</p>
                <p class="type">${escape(data.type)}</p>
                <p class="trait">${escape(data.traits)}</p>
              </div>`;
        },
        item: function(data, escape) {
          return `<div>${escape(data.name)} - ${escape(data.type)}</div>`;
        }
      },
    });
  }
}
