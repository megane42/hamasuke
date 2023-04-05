# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "countup.js", to: "https://unpkg.com/countup.js@2.6.0/dist/countUp.min.js"
