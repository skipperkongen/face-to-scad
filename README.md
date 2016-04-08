# Vision test

This is how to call the Google Vision API. The API can do:

* Facial Detection (https://cloud.google.com/vision/docs/face-tutorial)
* Label Detection
* Logo Detection
* And much more

## Call Google Vision API with script

Get annotations for picture (at most one from each category):

```
./visionapi.sh mypicture.png
```

## Calling Google Vision API manually

Base64-encode an image:

```
INPUT_IMAGE=`base64 mypicture.jpg`
```

Create label-detection request (file called `request.json` in this example):

```
cat > request.json << EOF
{
  "requests":[
    {
      "image":{
        "content":"$INPUT_IMAGE"
      },
      "features":[
        {
          "type":"LABEL_DETECTION",
          "maxResults": 3
        }
      ]
    }
  ]
}
EOF
```

Call service (here you need your API key):

```
curl -v -k -s -H "Content-Type: application/json" \
  https://vision.googleapis.com/v1/images:annotate?key=<YOUR-API-KEY> \
  --data-binary @request.json
```
