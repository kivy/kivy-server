#!/bin/sh
curl \
    --url https://ci.appveyor.com/api/builds \
    --request POST \
    --header "Authorization: Bearer $APPVEYOR_API_TOKEN" \
    --header "Content-Type: application/json" \
    --data " \
    { \
        \"accountName\": \"KivyOrg\", \
        \"projectSlug\": \"kivy\", \
        \"branch\": \"master\", \
        \"environmentVariables\": { \
            \"APPVEYOR_SCHEDULED_BUILD\": \"True\" \
        } \
    } \
    "
