#!/bin/sh
FILE=$1
if [ ! -f $FILE ];
then
   echo "usage: visionapi.sh IMAGE"
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
          "maxResults": 5
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
