# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.11
pin "sortablejs" # @1.15.6
pin "tom-select", to: "https://cdn.jsdelivr.net/npm/tom-select@2.4.3/dist/esm/tom-select.complete.js"
pin "@orchidjs/sifter", to: "https://cdn.jsdelivr.net/npm/@orchidjs/sifter@1.1.0/dist/esm/sifter.js"
pin "@orchidjs/unicode-variants", to: "https://cdn.jsdelivr.net/npm/@orchidjs/unicode-variants@1.1.2/dist/esm/index.js"
# pin "@stimulus-components/chartjs", to: "@stimulus-components--chartjs.js" # @6.0.1
# pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
# pin "chart.js" # @4.4.8
pin "@stimulus-components/chartjs", to: "https://ga.jspm.io/npm:@stimulus-components/chartjs@6.0.1/dist/stimulus-chartjs.mjs"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.4/dist/color.esm.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.8/dist/chart.js"
