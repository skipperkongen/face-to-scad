# Vision test

This is how to call the Google Vision API. The API can do:

* Facial Detection (https://cloud.google.com/vision/docs/face-tutorial)
* Label Detection
* Logo Detection
* And much more

## Call Google Vision API with script

Get five labels for picture:

```
./visionapi.sh LABEL_DETECTION mypicture.png
```

## Calling Google Vision API manually

Base64-encoded image:

```
VISION_API_INPUT=`base64 mypicture.png`
VISION_API_ANNOTATION=LABEL_DETECTION
```

Create request JSON file (called `request.json` in this example):

```
cat > request.json << EOF
{
  "requests":[
    {
      "image":{
        "content":"$GOOGLE_VISION_API_INPUT"
      },
      "features":[
        {
          "type":"$GOOGLE_VISION_API_ANNOTATION",
          "maxResults": 5
        }
      ]
    }
  ]
}
EOF
```

Call service:

```
curl -v -k -s -H "Content-Type: application/json" \
  https://vision.googleapis.com/v1/images:annotate?key=<YOUR-API-KEY> \
  --data-binary @request.json
```
