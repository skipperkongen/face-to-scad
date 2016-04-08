#!/bin/sh
FILE=$1
if [ ! -f $FILE ];
then
   echo "usage: visionapi.sh ANNOTATION MAX_RESULTS IMAGE"
fi

IMAGE=`base64 $FILE`

cat > .request.json << EOF
{
  "requests":[
    {
      "image":{
        "content":"$IMAGE"
      },
      "features":[
        {
          "type":"LABEL_DETECTION",
          "maxResults": 1
        },
        {
          "type":"TEXT_DETECTION",
          "maxResults": 1
        },
        {
          "type":"FACE_DETECTION",
          "maxResults": 1
        },
        {
          "type":"LANDMARK_DETECTION",
          "maxResults": 1
        },
        {
          "type":"LOGO_DETECTION",
          "maxResults": 1
        },
        {
          "type":"SAFE_SEARCH_DETECTION",
          "maxResults": 1
        },
        {
          "type":"IMAGE_PROPERTIES",
          "maxResults": 1
        }
      ]
    }
  ]
}
EOF

curl -v -k -s -H "Content-Type: application/json" \
  https://vision.googleapis.com/v1/images:annotate?key=$GOOGLE_VISION_API_KEY \
  --data-binary @.request.json

rm .request.json
