# docker-frontend-testing :construction:

> Docker image for frontend testing.

## Features

  - Xvfb
  - Chrome
  - Firefox
  - Java 8 installed (for Selenium and [co.](https://github.com/Polymer/web-component-tester))

## Pull

    $ docker pull lasalefamine/frontend-testing:tagname

## Run (interact with bash)

    $ docker run -it lasalefamine/frontend-testing bash

## Insight
I'm using it for running `e2e` tests with [wct](https://github.com/Polymer/web-component-tester) and [nightwacth](nightwatchjs.org)/[testcafe](https://github.com/DevExpress/testcafe).
## License

MIT © LasaleFamine



