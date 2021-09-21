FROM alpine

ARG artifactory_user_default

ARG artifactory_pass_default

RUN if [ -z $artifactory_user_default ]; then echo Missing build-arg 'artifactory_user_default' use --build-arg artifactory_user_default=XXXX && exit 1; fi

RUN if [ -z $artifactory_pass_default ]; then echo Missing build-arg 'artifactory_pass_default' use --build-arg artifactory_pass_default=XXXX && exit 1; fi

RUN apk add curl

WORKDIR /app

COPY ./src/ ./

RUN tar -czvf gb-app.tgz .

CMD curl -u ${artifactory_user_default}:${artifactory_pass_default} -X PUT https://gbartifactory.jfrog.io/artifactory/gb-templates/gb-app.tgz -T gb-app.tgz
