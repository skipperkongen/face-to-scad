## Various

The request json files contain a base64-encoded JPG images from Photo Booth (pic2.jpg).

```
base64 <input image> | pbcopy
```

## Request

Face recognition (https://cloud.google.com/vision/docs/face-tutorial):

```
curl -v -k -s -H "Content-Type: application/json" \
  https://vision.googleapis.com/v1/images:annotate?key=<API-KEY> \
  --data-binary @request-face.json
```
