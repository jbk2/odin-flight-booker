# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
pin "jquery-ui", to: "https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"
